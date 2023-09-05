###################################################################################
# Virtual Network


resource "azurerm_virtual_network" "Vnet" {
  name                = local.VnetName
  location            = azurerm_resource_group.VNetResourceGroup[0].location
  resource_group_name = azurerm_resource_group.VNetResourceGroup[0].name
  address_space       = [var.Vnet.AddressSpace]
  dns_servers         = var.Vnet.DnsServers
  tags                = merge(var.DefaultTags, var.ExtraTags, { "StartDate" = local.StartDateTag })
  
}