##############################################################
#This module allows the creation of a vNEt
##############################################################


#Output for the Log Analytics Workspace module

output "Name" {
  value = azurerm_log_analytics_workspace.TerraLogAnalyticsWS.name
}

output "Location" {
  value = azurerm_log_analytics_workspace.TerraLogAnalyticsWS.location
}

output "RG" {
  value = azurerm_log_analytics_workspace.TerraLogAnalyticsWS.resource_group_name
}

output "Sku" {
  value = azurerm_log_analytics_workspace.TerraLogAnalyticsWS.sku
}

output "Id" {
  value = azurerm_log_analytics_workspace.TerraLogAnalyticsWS.id
}

output "PSK" {
  value = azurerm_log_analytics_workspace.TerraLogAnalyticsWS.primary_shared_key
}

output "SSK" {
  value = azurerm_log_analytics_workspace.TerraLogAnalyticsWS.secondary_shared_key
}

output "WSId" {
  value = azurerm_log_analytics_workspace.TerraLogAnalyticsWS.workspace_id
}

output "PortalUrl" {
  value = azurerm_log_analytics_workspace.TerraLogAnalyticsWS.portal_url
}