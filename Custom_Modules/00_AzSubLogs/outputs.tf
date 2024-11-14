###################################################################
#This module creates the basic resources for logging and monitoring
###################################################################

###################################################################
# Outputs for RG

output "RGLogName" {

  value = azurerm_resource_group.RGLogs.name
}

output "RGLogLocation" {

  value = azurerm_resource_group.RGLogs.location
}

output "RGLogId" {

  value = azurerm_resource_group.RGLogs.id
}

###################################################################
#Output for the log storage account

output "STALogFull" {
  value     = azurerm_storage_account.STALog
  sensitive = true
}
output "STALogName" {
  value = azurerm_storage_account.STALog.name
}

output "STALogId" {
  value     = azurerm_storage_account.STALog.id
  sensitive = true
}

output "STALogPrimaryBlobEP" {
  value     = azurerm_storage_account.STALog.primary_blob_endpoint
  sensitive = true
}

output "STALogPrimaryQueueEP" {
  value     = azurerm_storage_account.STALog.primary_queue_endpoint
  sensitive = true
}

output "STALogPrimaryTableEP" {
  value     = azurerm_storage_account.STALog.primary_table_endpoint
  sensitive = true
}

output "STALogPrimaryFileEP" {
  value     = azurerm_storage_account.STALog.primary_file_endpoint
  sensitive = true
}

output "STALogPrimaryAccessKey" {
  value     = azurerm_storage_account.STALog.primary_access_key
  sensitive = true
}

output "STALogSecondaryAccessKey" {
  value     = azurerm_storage_account.STALog.secondary_access_key
  sensitive = true
}

output "STALogConnectionURI" {
  value     = azurerm_storage_account.STALog.primary_blob_connection_string
  sensitive = true
}

###################################################################
#Output for the log analytics workspace

output "SubLogAnalyticsFull" {
  value     = azurerm_log_analytics_workspace.SubLogAnalyticsWS
  sensitive = true
}
output "SubLogAnalyticsWSId" {
  value     = azurerm_log_analytics_workspace.SubLogAnalyticsWS.id
  sensitive = true
}

output "SubLogAnalyticsWS_WSId" {
  value     = azurerm_log_analytics_workspace.SubLogAnalyticsWS.workspace_id
  sensitive = true
}

output "SubLogAnalyticsWS_Retention" {
  value = azurerm_log_analytics_workspace.SubLogAnalyticsWS.retention_in_days
}

output "SubLogAnalyticsWS_PrimaryAccessKey" {
  value     = azurerm_log_analytics_workspace.SubLogAnalyticsWS.primary_shared_key
  sensitive = true
}

output "SubLogAnalyticsWS_SecondaryAccessKey" {
  value     = azurerm_log_analytics_workspace.SubLogAnalyticsWS.secondary_shared_key
  sensitive = true
}

