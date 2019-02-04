##############################################################
#This module allows the creation of a RG
##############################################################



#Creating a Resource Group
resource "azurerm_resource_group" "Terra-RG" {

    
    name        = "${var.RGName}"
    location    = "${var.RGLocation}"

    tags {
    Environment = "${var.EnvironmentTag}"
    Usage       = "${var.EnvironmentUsageTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
    }

}

