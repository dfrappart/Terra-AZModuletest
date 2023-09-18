#############################################################################
#data source for the subscription


data "azurerm_subscription" "current" {}

#############################################################################
#data source for diagnostic settings


data "azurerm_monitor_diagnostic_categories" "AgwPubIP" {
  resource_id = azurerm_public_ip.AppGWPIP.id
}

data "azurerm_monitor_diagnostic_categories" "Agw" {
  resource_id = azurerm_application_gateway.AGW.id
}