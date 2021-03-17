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
  value = azurerm_storage_account.STALog
  sensitive = true
}
output "STALogName" {
  value = azurerm_storage_account.STALog.name
}

output "STALogId" {
  value = azurerm_storage_account.STALog.id
}

output "STALogPrimaryBlobEP" {
  value = azurerm_storage_account.STALog.primary_blob_endpoint
}

output "STALogPrimaryQueueEP" {
  value = azurerm_storage_account.STALog.primary_queue_endpoint
}

output "STALogPrimaryTableEP" {
  value = azurerm_storage_account.STALog.primary_table_endpoint
}

output "STALogPrimaryFileEP" {
  value = azurerm_storage_account.STALog.primary_file_endpoint
}

output "STALogPrimaryAccessKey" {
  value = azurerm_storage_account.STALog.primary_access_key
}

output "STALogSecondaryAccessKey" {
  value = azurerm_storage_account.STALog.secondary_access_key
}

output "STALogConnectionURI" {
  value = azurerm_storage_account.STALog.primary_blob_connection_string
}

###################################################################
#Output for the log analytics workspace

output "SubLogAnalyticsFull" {
  value = azurerm_log_analytics_workspace.SubLogAnalyticsWS
  sensitive = true
}
output "SubLogAnalyticsWSId" {
  value = azurerm_log_analytics_workspace.SubLogAnalyticsWS.id
}

output "SubLogAnalyticsWS_WSId" {
  value = azurerm_log_analytics_workspace.SubLogAnalyticsWS.workspace_id
}

output "SubLogAnalyticsWS_Retention" {
  value = azurerm_log_analytics_workspace.SubLogAnalyticsWS.retention_in_days
}

output "SubLogAnalyticsWS_PrimaryAccessKey" {
  value = azurerm_log_analytics_workspace.SubLogAnalyticsWS.primary_shared_key 
}

output "SubLogAnalyticsWS_SecondaryAccessKey" {
  value = azurerm_log_analytics_workspace.SubLogAnalyticsWS.secondary_shared_key  
}

output "SubLogAnalyticsWS_PortalURL" {
  value = azurerm_log_analytics_workspace.SubLogAnalyticsWS.portal_url  
}