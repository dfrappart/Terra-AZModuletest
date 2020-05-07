##############################################################
#This module allows the creation of a Subnet
##############################################################



#Creation fo the subnet

resource "azurerm_subnet" "TerraSubnet" {
  name                      = var.SubnetName
  resource_group_name       = var.RGName
  virtual_network_name      = var.VNetName
  address_prefixes          = var.Subnetaddressprefix
  #network_security_group_id = var.NSGid
  service_endpoints         = var.SVCEP
}

resource "azurerm_subnet_network_security_group_association" "Terra_Subnet_NSG_Association" {
    subnet_id                           = azurerm_subnet.TerraSubnet.id
    network_security_group_id   = var.NSGid
}