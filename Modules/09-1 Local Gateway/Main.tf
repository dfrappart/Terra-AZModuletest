##############################################################
#This module allows the creation of a Local VPN Gateway Object
##############################################################



#Resource Creation

resource "azurerm_local_network_gateway" "TerraLocalGW" {

  name                  = "${var.LGWName}"
  location              = "${var.LGWLocation}"
  resource_group_name   = "${var.LGWRG}"
  gateway_address       = "${var.LGWAdress}"
  address_space         = "${var.LGWAddressspace}"

    tags {
    Environment       = "${var.EnvironmentTag}"
    Usage             = "${var.EnvironmentUsageTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
    }  

}

