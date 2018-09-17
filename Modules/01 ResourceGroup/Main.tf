##############################################################
#This module allows the creation of a RG
##############################################################



#Creating a Resource Group
resource "azurerm_resource_group" "Terra-RG" {

    
    name        = "${var.RGName}"
    location    = "${var.RGLocation}"

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }

}

