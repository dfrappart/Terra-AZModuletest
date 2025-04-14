#############################################################################
#data source for the subscription


data "azurerm_subscription" "current" {}

#############################################################################
#data source for App svc vnet and subnet
/*
data "azurerm_virtual_network" "AppSvcVnet" {
  name                = var.AppSvcVnetName
  resource_group_name = local.RgVnet
}

data "azurerm_subnet" "AppSvcVnetSubnet" {
  name                 = var.AppSvcVnetSubnetName
  virtual_network_name = azurerm_virtual_network.AppSvcVnet.name
  resource_group_name  = local.RgVnet
}

data "azurerm_subnet" "AppSvcPeSubnet" {
  name                 = var.AppSvcPeVnetSubnetName
  virtual_network_name = azurerm_virtual_network.AppSvcVnet.name
  resource_group_name  = local.RgVnet
}
*/
#############################################################################
#data source for App svc vnet and subnet
/*
data "azurerm_private_dns_zone" "AppSvcDnsZone" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = "rg-dns"
}

#############################################################################
#data source for diagnostic settings

/*
data "azurerm_monitor_diagnostic_categories" "AgwPubIP" {
  resource_id = azurerm_public_ip.AppGWPIP.id
}

data "azurerm_monitor_diagnostic_categories" "Agw" {
  resource_id = azurerm_application_gateway.AGW.id
}
*/