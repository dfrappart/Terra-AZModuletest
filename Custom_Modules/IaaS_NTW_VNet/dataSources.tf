#############################################################################
#This file is used to define data source refering to Azure existing resources
#############################################################################


#############################################################################
#data source for the subscription


data "azurerm_subscription" "current" {}


#############################################################################
#data source for Vnet RG


data "azurerm_resource_group" "RgVnet" {
  name = azurerm_virtual_network.Vnet.resource_group_name
}

#############################################################################
#data source for diagnostic settings

data "azurerm_monitor_diagnostic_categories" "Vnet" {
  resource_id = azurerm_virtual_network.Vnet.id
}


data "azurerm_monitor_diagnostic_categories" "Nsg" {

  for_each    = local.Subnets
  resource_id = azurerm_network_security_group.Nsgs[each.key].id
}

#############################################################################
#data source for log analytics - used for flow logs

data "azurerm_log_analytics_workspace" "LawLog" {
  count               = var.CreateLocalLaw ? 1 : 0
  resource_group_name = split("/", var.LawLogId)[4]
  name                = split("/", var.LawLogId)[8]
}

data "azurerm_storage_account" "StaLog" {
  count               = var.CreateLocalSta ? 1 : 0
  resource_group_name = split("/", var.StaLogId)[4]
  name                = split("/", var.StaLogId)[8]


}
