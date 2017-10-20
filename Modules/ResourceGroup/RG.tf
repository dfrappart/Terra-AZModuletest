##############################################################
#This module allow the creation of a RG
##############################################################


#Variable declaration for Module



variable "RGName" {
  type    = "string"
  default = "DefaultRSG"
}


variable "RGLocation" {
  type    = "string"
  default = "Westeurope"
}


variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

#Creating a Resource Group
resource "azurerm_resource_group" "Terra-RG" {

    
    name        = "${var.RGName}"
    location    = "${var.RGLocation}"

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }

}

#Output for the RG module

output "Name" {

  value = "${azurerm_resource_group.Terra-RG.name}"
}

output "Location" {

  value = "${azurerm_resource_group.Terra-RG.location}"
}

output "Id" {

  value = "${azurerm_resource_group.Terra-RG.id}"
}