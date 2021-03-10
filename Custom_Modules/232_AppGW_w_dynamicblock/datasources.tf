#############################################################################
#data source for the subscription


data "azurerm_subscription" "current" {}

#############################################################################
#data source for the subscription setup logs features


data "azurerm_resource_group" "RgSubLogs" {
  name                        = var.RgSubLogName
}

data "azurerm_log_analytics_workspace" "LawSubLog" {
  name                        = var.LawSubLogName
  resource_group_name         = data.azurerm_resource_group.RgSubLogs.name
}

data "azurerm_storage_account" "STASubLog" {
  name                        = var.StaSubLogName
  resource_group_name         = data.azurerm_resource_group.RgSubLogs.name
}
