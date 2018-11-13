##############################################################
#This module allows the creation of a vNEt
##############################################################


#Creating a vNet

resource "azurerm_virtual_network" "Terra-vNet" {
  name                = "${var.vNetName}"
  resource_group_name = "${var.RGName}"
  address_space       = "${var.vNetAddressSpace}"
  location            = "${var.vNetLocation}"

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

