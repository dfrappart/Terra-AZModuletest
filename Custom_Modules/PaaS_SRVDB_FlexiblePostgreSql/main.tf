# Defining some locals
locals {
  
}

###################################################################################
################################### PostgreSQL ####################################
###################################################################################

# PostgreSQL server

resource "azurerm_postgresql_flexible_server" "PostGreSQLFlexServer" {
  name                                        = "psql-flex${lower(var.PSQLSuffix)}"
  resource_group_name                         = var.RgName
  location                                    = var.Location

  administrator_login                         = var.PostgreLogin
  administrator_password                      = var.PostgrePwd

  backup_retention_days                       = var.PostgreRetentionDays
  geo_redundant_backup_enabled                = var.PostgreGeoRedundantBackup

  create_mode                                 = var.PostgreCreateMode
  source_server_id                            = var.PostgreCreationSrcSrvId
  point_in_time_restore_time_in_utc           = var.PostgreRestorePIT

  
  delegated_subnet_id                         = var.PSQLSubnetId == "unspecified" ? azurerm_subnet.psqlsubnet[0].id : var.PSQLSubnetId
  private_dns_zone_id                         = var.PSQLPrivateDNSZoneId == "unspecified" ? azurerm_private_dns_zone.psqlflexdnszone[0].id : var.PSQLPrivateDNSZoneId

  high_availability {
    mode                                      = var.HAMode
    standby_availability_zone                 = var.HAStandbyAZ
  }

  zone                                        = var.PostgreZone

  dynamic "maintenance_window" {
    for_each = var.CustomMaintenanceWindow ? ["fake"] : []

    content {
      day_of_week                             = var.CustomMaintenanceWindowDay
      start_hour                              = var.CustomMaintenanceWindowHour
      start_minute                            = var.CustomMaintenanceWindowMinute
    }
  }



  storage_mb                                  = var.PostgreStorage
  version                                     = var.PostgreVersion
  sku_name                                    = var.PostgreSkuName
  
  tags = merge(var.DefaultTags,var.ExtraTags)


}

# PostgreSQL databases


# Network requirements

######################################################################
# creating an azure postgresql flexible server for lab usage

resource "azurerm_virtual_network" "psqlflexiblentw" {
  count                                       = var.PSQLSubnetId == "unspecified" ? 1 : 0
  name                                        = "psqlflexiblentw"
  location                                    = var.Location
  resource_group_name                         = var.RgName
  address_space                               = ["172.24.0.0/16"]  
}

resource "azurerm_private_dns_zone" "psqlflexdnszone" {
  count                                       = var.PSQLSubnetId == "unspecified" ? 1 : 0
  name                                        = "dfrpsqltest.postgres.database.azure.com"
  resource_group_name                         = var.RgName
}

resource "azurerm_subnet" "psqlsubnet" {
  count                                       = var.PSQLSubnetId == "unspecified" ? 1 : 0
  name                                        = "psqlsubnet"
  resource_group_name                         = var.RgName
  virtual_network_name                        = azurerm_virtual_network.psqlflexiblentw[0].name
  address_prefixes                            = ["172.24.0.0/24"]
  service_endpoints                           = ["Microsoft.Storage"]
  delegation {
    name                                      = "postgresql"
    service_delegation {
      name                                      = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions                                       = [
                                                        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}


resource "azurerm_private_dns_zone_virtual_network_link" "PVDNSLinkToPsqlVNet" {
  count                                       = var.PSQLSubnetId == "unspecified" ? 1 : 0
  name                                        = "${azurerm_private_dns_zone.psqlflexdnszone[0].name}_to_${azurerm_virtual_network.psqlflexiblentw[0].name}"
  private_dns_zone_name                       = azurerm_private_dns_zone.psqlflexdnszone[0].name
  virtual_network_id                          = azurerm_virtual_network.psqlflexiblentw[0].id
  resource_group_name                         = var.RgName
}

###################################################################################
################################ Monitoring #######################################
###################################################################################

#DB Alert

resource "azurerm_monitor_metric_alert" "DBConnectThreshold" {


  name                                        = "malt${azurerm_postgresql_flexible_server.PostGreSQLFlexServer.name}-DBConnectThreshold"
  resource_group_name                         = var.RgName
  scopes                                      = [azurerm_postgresql_flexible_server.PostGreSQLFlexServer.id]
  description                                 = "${azurerm_postgresql_flexible_server.PostGreSQLFlexServer.name}-DBConnectThreshold"

  criteria {
    metric_namespace                          = "Microsoft.DBforPostgreSQL/flexibleServers"
    metric_name                               = "active_connections"
    aggregation                               = "Average"
    operator                                  = "Equals"
    threshold                                 = var.DBLowConnectionThreshold


  }

  criteria {
    metric_namespace                          = "Microsoft.DBforPostgreSQL/flexibleServers"
    metric_name                               = "active_connections"
    aggregation                               = "Average"
    operator                                  = "GreaterThan"
    threshold                                 = var.DBHighConnectionThreshold


  }

  criteria {
    metric_namespace                          = "Microsoft.DBforPostgreSQL/flexibleServers"
    metric_name                               = "connections_failed"
    aggregation                               = "Total"
    operator                                  = "GreaterThan"
    threshold                                 = var.DBFailedConnectionThreshold


  }

  dynamic "action" {
    for_each = var.ACGIds
    iterator = each
    
    content {
      action_group_id                          = each.key
    }
    
  }

  frequency                                   = "PT1M"
  window_size                                 = "PT1M"




  tags = merge(var.DefaultTags,var.ExtraTags)

}

resource "azurerm_monitor_metric_alert" "DBStorage" {

  
  name                                      = "malt${azurerm_postgresql_flexible_server.PostGreSQLFlexServer.name}-DBStorageThreshold"
  resource_group_name                       = var.RgName
  scopes                                    = [azurerm_postgresql_flexible_server.PostGreSQLFlexServer.id]
  description                               = "${azurerm_postgresql_flexible_server.PostGreSQLFlexServer.name}-DBStorageThreshold"

  criteria {
    metric_namespace                        = "Microsoft.DBforPostgreSQL/flexibleServers"
    metric_name                             = "storage_percent"
    aggregation                             = "Average"
    operator                                = "GreaterThan"
    threshold                               = var.DBStoragePercentHighThreshold


  }

  dynamic "action" {
    for_each = var.ACGIds
    iterator = each
    
    content {
      action_group_id                          = each.key
    }
    
  }

  frequency                                 = "PT1M"
  window_size                               = "PT1M"




  tags = merge(var.DefaultTags,var.ExtraTags)

}

resource "azurerm_monitor_metric_alert" "DBCPU" {

  
  name                                        = "malt${azurerm_postgresql_flexible_server.PostGreSQLFlexServer.name}-DBDBCPUThreshold"
  resource_group_name                         = var.RgName
  scopes                                      = [azurerm_postgresql_flexible_server.PostGreSQLFlexServer.id]
  description                                 = "${azurerm_postgresql_flexible_server.PostGreSQLFlexServer.name}-DBDBCPUThreshold"

  criteria {
    metric_namespace                          = "Microsoft.DBforPostgreSQL/flexibleServers"
    metric_name                               = "cpu_percent"
    aggregation                               = "Average"
    operator                                  = "GreaterThan"
    threshold                                 = var.DBCPUPercentHighThreshold


  }


  dynamic "action" {
    for_each = var.ACGIds
    iterator = each
    
    content {
      action_group_id                          = each.key
    }
    
  }


  frequency                                   = "PT1M"
  window_size                                 = "PT1M"




  tags = merge(var.DefaultTags,var.ExtraTags)

}

###################################################################################
############################# Diagnostic settings #################################
###################################################################################

resource "azurerm_monitor_diagnostic_setting" "AzurePSQLDiagToSTA" {
  count                                 = var.STALogId == "unspecified" ? 0 : 1
  name                                  = "mon-psql-diag-to-STA-${lower(var.PSQLSuffix)}"
  target_resource_id                    = azurerm_postgresql_flexible_server.PostGreSQLFlexServer.id
  storage_account_id                    = var.STALogId
  #log_analytics_workspace_id            = var.LawLogId

  dynamic "log" {
    for_each = var.LogCategory

    content {
      category                            = log.value.LogCatName
      enabled                             = log.value.IsLogCatEnabledForSTA
        retention_policy {
          enabled                           = log.value.IsRetentionEnabled
          days                              = log.value.RetentionDaysValue
        } 
    }

  }


  dynamic "metric" {
    for_each = var.MetricCategory

    content {
      category                            = metric.value.MetricCatName
      enabled                             = metric.value.IsMetricCatEnabledForSTA
      retention_policy {
        enabled                           = metric.value.IsRetentionEnabled
        days                              = metric.value.RetentionDaysValue
    }  
    }
  
  }

}

resource "azurerm_monitor_diagnostic_setting" "AzurePSQLDiagToLAWA" {
  count                                 = var.LawLogId == "unspecified" ? 0 : 1 
  name                                  = "mon-psql-diag-to-Law-${lower(var.PSQLSuffix)}"
  target_resource_id                    = azurerm_postgresql_flexible_server.PostGreSQLFlexServer.id
  log_analytics_workspace_id            = var.LawLogId

  dynamic "log" {
    for_each = var.LogCategory

    content {
      category                            = log.value.LogCatName
      enabled                             = log.value.IsLogCatEnabledForLAW
        retention_policy {
          enabled                           = log.value.IsRetentionEnabled
          days                              = log.value.RetentionDaysValue
        } 
    }

  }


  dynamic "metric" {
    for_each = var.MetricCategory

    content {
      category                            = metric.value.MetricCatName
      enabled                             = metric.value.IsMetricCatEnabledForLAW
 
    }
  
  }

}