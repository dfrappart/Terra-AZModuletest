##############################################################
#This module allows the creation of a Subnet
##############################################################



#Creation fo the subnet

resource "azurerm_subnet" "TerraSubnet" {
  name                      = "${var.SubnetName}"
  resource_group_name       = "${var.RGName}"
  virtual_network_name      = "${var.vNetName}"
  address_prefix            = "${var.Subnetaddressprefix}"
  network_security_group_id = "${var.NSGid}"
  service_endpoints         = "${var.SVCEP}"
}

