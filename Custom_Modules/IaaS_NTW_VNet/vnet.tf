###################################################################################
# Virtual Network


resource "azurerm_virtual_network" "Vnet" {

  lifecycle {
    ignore_changes = [
      tags["StartDate"]
    ]

  }

  name                = local.VnetName
  location            = var.Location
  resource_group_name = local.RgName
  address_space       = [var.Vnet.AddressSpace]
  dns_servers         = var.Vnet.DnsServers
  tags                = merge(var.DefaultTags, var.ExtraTags, { "StartDate" = local.StartDateTag })

}


resource "azurerm_ip_group" "VnetCidr" {
  name                = local.VnetName
  location            = azurerm_virtual_network.Vnet.location
  resource_group_name = azurerm_virtual_network.Vnet.resource_group_name

  cidrs = [var.Vnet.AddressSpace]

  tags = merge(var.DefaultTags, var.ExtraTags, { "StartDate" = local.StartDateTag })

  lifecycle {
    ignore_changes = [tags["StartDate"]]


  }

}