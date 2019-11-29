##############################################################
#This module allows the creation of a Subnet
##############################################################


#Creation fo the subnet

resource "azurerm_subnet" "TerraSubnet" {
  name                      = var.SubnetName
  resource_group_name       = var.RGName
  virtual_network_name      = var.VNetName
  address_prefix            = var.Subnetaddressprefix
  network_security_group_id = var.NSGid
  service_endpoints         = var.SVCEP
  route_table_id            = var.RouteTableId
}

resource "azurerm_subnet_network_security_group_association" "Terra_Subnet_NSG_Association" {
    subnet_id                           = azurerm_subnet.TerraSubnet.id
    azurerm_network_security_group_id   = var.NSGId
}

resource "azurerm_subnet_route_table_association" "Terra_Subnet_RT_Association" {
    subnet_id                           = azurerm_subnet.TerraSubnet.id
    azurerm_network_security_group_id   = var.RouteTableId
}
