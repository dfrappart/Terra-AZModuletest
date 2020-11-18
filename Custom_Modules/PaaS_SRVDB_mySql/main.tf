###################################################################################
################################### MySQL #########################################
###################################################################################

# MySQLSQL server
resource "azurerm_mysql_server" "MySQLServer" {
  name                                        = "msql${lower(var.mysqlsuffix)}"
  location                                    = var.Location
  resource_group_name                         = var.RGName

  sku_name                                    = var.MySQLSkuName
  version                                     = var.MySQLVersion

  administrator_login                         = var.MySQLLogin
  administrator_login_password                = var.MySQLPwd

  auto_grow_enabled                           = var.MySQLAutoGrow
  backup_retention_days                       = var.MySQLRetentionDays

  create_mode                                 = var.MySQLCreateMode
  creation_source_server_id                   = var.SRCSRVId
  geo_redundant_backup_enabled                = var.MySQLGeoRedundantBackup

  infrastructure_encryption_enabled           = var.IsInfraEncrypted

  public_network_access_enabled               = var.IsPublicAccessEnabled

  restore_point_in_time                       = var.RestorePIT
    
  ssl_enforcement_enabled                     = var.IsSSLEnforcementEnabled
  ssl_minimal_tls_version_enforced            = var.TLSVersion

  storage_mb                                  = var.MySQLStorageSize

  threat_detection_policy {

    enabled                                   = var.IsThreatDetectionEnabled
    disabled_alerts                           = var.DisabledThreatAlertList
    email_account_admins                      = var.EmailAccountAdminEnabled
    email_addresses                           = var.ThreatAlertEmail
    retention_days                            = var.ThreatAlertRetentionDays
    storage_account_access_key                = var.ThreatAlertTargetStorageKey
    storage_endpoint                          = var.ThreatAlertTargetEP

  }



  tags = {
    ResourceOwner                             = var.ResourceOwnerTag
    Country                                   = var.CountryTag
    CostCenter                                = var.CostCenterTag
    Environment                               = var.EnvironmentTag
    ManagedBy                                 = "Terraform" 
  }
    
}

# MySQL Azure AD administrator

resource "azurerm_mysql_active_directory_administrator" "MySQLServerADAdmin" {
  server_name                                 = azurerm_mysql_server.MySQLServer.name
  resource_group_name                         = var.RGName
  login                                       = var.MySQLADAdminLogin
  object_id                                   = var.MySQLADAdminObjectId
  tenant_id                                   = data.azurerm_subscription.current.tenant_id

}

# MySQL databases
resource "azurerm_mysql_database" "MySQLDB" {
  count                                       = length(var.MySQLDbList)
  name                                        = "mysql-db${var.mysqlsuffix}-${element(var.MySQLDbList,count.index)}" 
  resource_group_name                         = var.RGName
  server_name                                 = azurerm_mysql_server.MySQLServer.name
  charset                                     = var.MySQLDbCharset
  collation                                   = var.MySQLDbCollation
}

resource "azurerm_mysql_virtual_network_rule" "MySQLServerVNetRule" {
  count                                       = length(var.SubnetIds)
  name                                        = "mysql-vnrul${var.mysqlsuffix}-${count.index+1}"
  resource_group_name                         = var.RGName
  server_name                                 = azurerm_mysql_server.MySQLServer.name
  subnet_id                                   = element(var.SubnetIds,count.index)
  #The following parameters is not exposed yet in the API and default to false, as opposite to psql equivalent
  #ignore_missing_vnet_service_endpoint        = true
}



###################################################################################
################################ Monitoring #######################################
###################################################################################



#DB Alert

resource "azurerm_monitor_metric_alert" "DBConnectThreshold" {


  name                                        = "malt-DBConnectThreshold-${azurerm_mysql_server.MySQLServer.name}"
  resource_group_name                         = var.RGName
  scopes                                      = [azurerm_mysql_server.MySQLServer.id]
  description                                 = "${azurerm_mysql_server.MySQLServer.name}-DBConnectThreshold"

  criteria {
    metric_namespace                          = "Microsoft.DBforMySQL/servers"
    metric_name                               = "active_connections"
    aggregation                               = "Average"
    operator                                  = "Equals"
    threshold                                 = var.DBLowConnectionThreshold


  }

  criteria {
    metric_namespace                          = "Microsoft.DBforMySQL/servers"
    metric_name                               = "active_connections"
    aggregation                               = "Average"
    operator                                  = "GreaterThan"
    threshold                                 = var.DBHighConnectionThreshold


  }

  criteria {
    metric_namespace                          = "Microsoft.DBforMySQL/servers"
    metric_name                               = "connections_failed"
    aggregation                               = "Total"
    operator                                  = "GreaterThan"
    threshold                                 = var.DBFailedConnectionThreshold


  }

  action {
    action_group_id                           = var.ACG1Id
  }


  frequency                                   = "PT1M"
  window_size                                 = "PT1M"




  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Environment                         = var.EnvironmentTag
    ManagedBy                           = "Terraform"
  }

}

resource "azurerm_monitor_metric_alert" "DBStorage" {

  
  name                                      = "malt-DBStorageThreshold-${azurerm_mysql_server.MySQLServer.name}"
  resource_group_name                       = var.RGName
  scopes                                    = [azurerm_mysql_server.MySQLServer.id]
  description                               = "${azurerm_mysql_server.MySQLServer.name}-DBStorageThreshold"

  criteria {
    metric_namespace                        = "Microsoft.DBforMySQL/servers"
    metric_name                             = "storage_percent"
    aggregation                             = "Average"
    operator                                = "GreaterThan"
    threshold                               = var.DBStoragePercentHighThreshold


  }


  action {
    action_group_id                         = var.ACG1Id
  }


  frequency                                 = "PT1M"
  window_size                               = "PT1M"




  tags = {
    ResourceOwner                           = var.ResourceOwnerTag
    Country                                 = var.CountryTag
    CostCenter                              = var.CostCenterTag
    Environment                             = var.EnvironmentTag
    ManagedBy                               = "Terraform"
  }

}

resource "azurerm_monitor_metric_alert" "DBCPU" {

  
  name                                        = "malt-DBDBCPUThreshold-${azurerm_mysql_server.MySQLServer.name}-DBDBCPUThreshold"
  resource_group_name                         = var.RGName
  scopes                                      = [azurerm_mysql_server.MySQLServer.id]
  description                                 = "${azurerm_mysql_server.MySQLServer.name}-DBDBCPUThreshold"

  criteria {
    metric_namespace                          = "Microsoft.DBforMySQL/servers"
    metric_name                               = "cpu_percent"
    aggregation                               = "Average"
    operator                                  = "GreaterThan"
    threshold                                 = var.DBCPUPercentHighThreshold


  }


  action {
    action_group_id                           = var.ACG1Id
  }


  frequency                                   = "PT1M"
  window_size                                 = "PT1M"




  tags = {
    ResourceOwner                             = var.ResourceOwnerTag
    Country                                   = var.CountryTag
    CostCenter                                = var.CostCenterTag
    Environment                               = var.EnvironmentTag
    ManagedBy                                 = "Terraform"
  }

}

###################################################################################
############################# Diagnostic settings #################################
###################################################################################

resource "azurerm_monitor_diagnostic_setting" "AzureMSQLDiag" {
  name                                        = "diag-${azurerm_mysql_server.MySQLServer.name}"
  target_resource_id                          = azurerm_mysql_server.MySQLServer.id
  storage_account_id                          = var.STAId
  log_analytics_workspace_id                  = var.LawId

  log {
    category                                  = "MySqlSlowLogs"
    enabled                                   = true
    retention_policy {
      enabled                                 = true
      days                                    = 365
    } 
  }

  log {
    category                                  = "MySqlAuditLogs"
    enabled                                   = true
    retention_policy {
      enabled                                 = true
      days                                    = 365
    } 
  }

  metric {
    category                                  = "AllMetrics"
    enabled                                   = true
    retention_policy {
      enabled                                 = true
      days                                    = 365
    }    
  }

}

