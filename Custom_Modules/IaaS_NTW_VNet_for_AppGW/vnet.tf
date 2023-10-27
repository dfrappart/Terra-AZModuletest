###################################################################################
# Virtual Network


resource "azurerm_virtual_network" "Vnet" {

  lifecycle {
    ignore_changes = [
      tags["StartDate"]
    ]
  }
  
  name                = local.VnetName
  location            = var.Location #azurerm_resource_group.VNetResourceGroup[0].location
  resource_group_name = var.RgName #azurerm_resource_group.VNetResourceGroup[0].name
  address_space       = [var.Vnet.AddressSpace]
  dns_servers         = var.Vnet.DnsServers
  tags                = merge(var.DefaultTags, var.ExtraTags, { "StartDate" = local.StartDateTag })
  
}