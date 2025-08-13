#############################################################################
#data source for the subscription


data "azurerm_subscription" "current" {}

#############################################################################
#data source for diagnostic settings


data "azurerm_monitor_diagnostic_categories" "PubIps" {
  count       = local.EnablePubIpDiagSettings ? 1 : 0
  resource_id = azurerm_public_ip.LbPubIp[0].id
}

data "azurerm_monitor_diagnostic_categories" "Lb" {
  count       = local.EnableLbDiagSettings ? 1 : 0
  resource_id = azurerm_lb.Lb.id
}

