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
    Environment       = "${var.EnvironmentTag}"
    Usage             = "${var.EnvironmentUsageTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
  }
}

