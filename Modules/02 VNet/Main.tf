##############################################################
#This module allows the creation of a VNet
##############################################################


#Creating a VNet

resource "azurerm_virtual_network" "Terra_VNet" {
  name                = var.VNetName
  resource_group_name = var.RGName
  address_space       = var.VNetAddressSpace
  location            = var.VNetLocation

  tags = {
    Environment       = var.EnvironmentTag
    Usage             = var.EnvironmentUsageTag
    Owner             = var.OwnerTag
    ProvisioningDate  = var.ProvisioningDateTag
  }
}

