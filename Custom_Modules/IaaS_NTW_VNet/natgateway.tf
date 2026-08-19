

resource "azurerm_nat_gateway" "NatGw" {
  count                   = var.EnableNatGateway ? 1 : 0
  name                    = local.NatGatewayName
  location                = azurerm_virtual_network.Vnet.location
  resource_group_name     = azurerm_virtual_network.Vnet.resource_group_name
  sku_name                = "StandardV2"
  idle_timeout_in_minutes = var.NatGateway.IdleTimeout

}

resource "azurerm_public_ip" "NatGwPubIp" {
  count               = var.EnableNatGateway ? 1 : 0
  name                = "${local.NatGatewayName}${count.index + 1}"
  location            = azurerm_virtual_network.Vnet.location
  resource_group_name = azurerm_virtual_network.Vnet.resource_group_name
  allocation_method   = "Static"
  sku                 = "StandardV2"
}

resource "azurerm_nat_gateway_public_ip_association" "NatPubIpAssociation" {
  count                = var.EnableNatGateway ? 1 : 0
  nat_gateway_id       = azurerm_nat_gateway.NatGw[0].id
  public_ip_address_id = azurerm_public_ip.NatGwPubIp[0].id
}

resource "azurerm_subnet_nat_gateway_association" "SubnetNatGwAssociation" {
  for_each       = { for k, v in local.Subnets : k => v if v.EnableNatGateway == true }
  subnet_id      = azurerm_subnet.Subnets[each.key].id
  nat_gateway_id = azurerm_nat_gateway.NatGw[0].id
}