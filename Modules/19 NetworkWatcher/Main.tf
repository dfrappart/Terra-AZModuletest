##############################################################
#This module allows the creation of a NEtwork Watcher
##############################################################



# NW Set Creation

resource "azurerm_network_watcher" "Terra_NW" {

    name                    = "${var.NWName}"
    location                = "${var.NWLocation}"
    resource_group_name     = "${var.RGName}"
    
    tags {
        Environment         = "${var.EnvironmentTag}"
        Usage               = "${var.EnvironmentUsageTag}"
        Owner               = "${var.OwnerTag}"
        ProvisioningDate    = "${var.ProvisioningDateTag}"
  }
}


