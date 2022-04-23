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

  
  delegated_subnet_id                         = var.PSQLSubnetId
  private_dns_zone_id                         = var.PSQLPrivateDNSZoneId

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




###################################################################################
################################ Monitoring #######################################
###################################################################################



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