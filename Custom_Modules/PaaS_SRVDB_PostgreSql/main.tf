# Defining some locals
locals {
  
}

###################################################################################
################################### PostgreSQL ####################################
###################################################################################

# PostgreSQL server
resource "azurerm_postgresql_server" "PostgreServer" {
  name                                        = "psql${lower(var.PSQLSuffix)}"
  location                                    = var.Location
  resource_group_name                         = var.RgName

  sku_name                                    = var.PostgreSkuName
  version                                     = var.PostgreVersion

  administrator_login                         = var.PostgreLogin
  administrator_login_password                = var.PostgrePwd

  auto_grow_enabled                           = var.PostgreAutoGrow
  storage_mb                                  = var.PostgreStorage

  backup_retention_days                       = var.PostgreRetentionDays
  geo_redundant_backup_enabled                = var.PostgreGeoRedundantBackup

  create_mode                                 = var.PostgreCreateMode
  creation_source_server_id                   = var.PostgreCreationSrcSrvId
  restore_point_in_time                       = var.PostgreRestorePIT

 dynamic "identity" {
   for_each = var.IsManagedIdentityEnabled ? ["fake"] : []

   content {
     type                                       = var.PostgreMSIType
   }
   
  }

  public_network_access_enabled               = var.IsPublicAccessEnabledEnabled

  infrastructure_encryption_enabled           = var.IsInfrastructureEncryptionEnabled


  
  ssl_enforcement_enabled                     = var.IsSSLEnforcmentEnabled
  ssl_minimal_tls_version_enforced            = var.PostgreTLSVer 

  threat_detection_policy {

    enabled                                   = var.IsthreatDetectionPolicyEnabled
    disabled_alerts                           = var.PostgreThreatDetectionDisabledAlertList
    email_account_admins                      = var.PostgreThreatDetectionEmailAdminAccount
    email_addresses                           = var.PostgreThreatDetectionEmailRecipientsList
    retention_days                            = var.PostgreThreatDetectionRetention
    storage_account_access_key                = var.PostgreThreatDetectionSTAKey
    storage_endpoint                          = var.PostgreThreatDetectionSTAEP

  }

  tags = merge(var.DefaultTags,var.ExtraTags)
    
}

# PostgreSQL databases

resource "azurerm_postgresql_database" "PostgreDB" {
  count                                       = length(var.PostgreDbList)
  name                                        = "psql-db-${lower(var.PSQLSuffix)}-${element(var.PostgreDbList,count.index+1)}" 
  resource_group_name                         = var.RgName
  server_name                                 = azurerm_postgresql_server.PostgreServer.name
  charset                                     = var.PostgreDbCharset
  collation                                   = var.PostgreDbCollation
}

# PostgreSQL VNet rules

resource "azurerm_postgresql_virtual_network_rule" "PosgreServerNetRule" {
  count                                       = length(var.SubnetIds)
  name                                        = "psql-vnrul-${lower(var.PSQLSuffix)}-${count.index+1}"
  resource_group_name                         = var.RgName
  server_name                                 = azurerm_postgresql_server.PostgreServer.name
  subnet_id                                   = element(var.SubnetIds,count.index)
  ignore_missing_vnet_service_endpoint        = true
}

# PostgreSQL FW rules

resource "azurerm_postgresql_firewall_rule" "SingleIP" {
  count                                       = length(var.AllowedPubIPs)
  name                                        = "psql-fwrul${var.PSQLSuffix}-${count.index+1}"
  resource_group_name                         = var.RgName
  server_name                                 = azurerm_postgresql_server.PostgreServer.name
  start_ip_address                            = var.AllowedPubIPs[count.index]
  end_ip_address                              = var.AllowedPubIPs[count.index]
}


###################################################################################
################################ Monitoring #######################################
###################################################################################



#DB Alert

resource "azurerm_monitor_metric_alert" "DBConnectThreshold" {


  name                                        = "malt${azurerm_postgresql_server.PostgreServer.name}-DBConnectThreshold"
  resource_group_name                         = var.RgName
  scopes                                      = [azurerm_postgresql_server.PostgreServer.id]
  description                                 = "${azurerm_postgresql_server.PostgreServer.name}-DBConnectThreshold"

  criteria {
    metric_namespace                          = "Microsoft.DBforPostgreSQL/servers"
    metric_name                               = "active_connections"
    aggregation                               = "Average"
    operator                                  = "Equals"
    threshold                                 = var.DBLowConnectionThreshold


  }

  criteria {
    metric_namespace                          = "Microsoft.DBforPostgreSQL/servers"
    metric_name                               = "active_connections"
    aggregation                               = "Average"
    operator                                  = "GreaterThan"
    threshold                                 = var.DBHighConnectionThreshold


  }

  criteria {
    metric_namespace                          = "Microsoft.DBforPostgreSQL/servers"
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

  
  name                                      = "malt${azurerm_postgresql_server.PostgreServer.name}-DBStorageThreshold"
  resource_group_name                       = var.RgName
  scopes                                    = [azurerm_postgresql_server.PostgreServer.id]
  description                               = "${azurerm_postgresql_server.PostgreServer.name}-DBStorageThreshold"

  criteria {
    metric_namespace                        = "Microsoft.DBforPostgreSQL/servers"
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

  
  name                                        = "malt${azurerm_postgresql_server.PostgreServer.name}-DBDBCPUThreshold"
  resource_group_name                         = var.RgName
  scopes                                      = [azurerm_postgresql_server.PostgreServer.id]
  description                                 = "${azurerm_postgresql_server.PostgreServer.name}-DBDBCPUThreshold"

  criteria {
    metric_namespace                          = "Microsoft.DBforPostgreSQL/servers"
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
  target_resource_id                    = azurerm_postgresql_server.PostgreServer.id
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
  target_resource_id                    = azurerm_postgresql_server.PostgreServer.id
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

