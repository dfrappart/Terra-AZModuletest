#############################################################################
#data source for the subscription


data "azurerm_subscription" "current" {}

#############################################################################
#data source for the subscription setup logs features


data "azurerm_monitor_diagnostic_categories" "AGWPubIP" {
  resource_id = azurerm_public_ip.AppGWPIP.id
}