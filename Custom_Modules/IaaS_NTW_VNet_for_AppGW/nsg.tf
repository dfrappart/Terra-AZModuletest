

resource "azurerm_network_security_group" "Nsgs" {

  lifecycle {
    ignore_changes = [
      tags["StartDate"]
    ]
  }

  for_each            = local.Subnets
  name                = format("%s-%s", "nsg", azurerm_subnet.Subnets[each.key].name)
  location            = azurerm_virtual_network.Vnet.location
  resource_group_name = azurerm_virtual_network.Vnet.resource_group_name



  tags = merge(var.DefaultTags, var.ExtraTags, { "StartDate" = local.StartDateTag })
}

resource "azurerm_subnet_network_security_group_association" "NsgtoSubnets" {

  for_each                  = local.Subnets
  subnet_id                 = azurerm_subnet.Subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.Nsgs[each.key].id
}