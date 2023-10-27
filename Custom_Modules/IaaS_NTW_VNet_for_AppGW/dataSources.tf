#############################################################################
#This file is used to define data source refering to Azure existing resources
#############################################################################


#############################################################################
#data source for the subscription


data "azurerm_subscription" "current" {}

#############################################################################
#data source for diagnostic settings

data "azurerm_monitor_diagnostic_categories" "Vnet" {
  resource_id = azurerm_virtual_network.Vnet.id
}


data "azurerm_monitor_diagnostic_categories" "Nsg" {

  for_each = local.Subnets
  resource_id = azurerm_network_security_group.Nsgs[each.key].id
}
#############################################################################
#data source for the subscription setup logs features

/*
data "azurerm_resource_group" "RGLogs" {
  name                        = var.RGLogName
}

data "azurerm_log_analytics_workspace" "LawSubLog" {
  name                        = var.LawSubLogName
  resource_group_name         = data.azurerm_resource_group.RGLogs.name
}

*/

output "diagvnet" {

  value = data.azurerm_monitor_diagnostic_categories.Vnet
}

output "diagNsg" {

  value = data.azurerm_monitor_diagnostic_categories.Nsg
}