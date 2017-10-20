##############################################################
#This module allow the creation of a Netsork Security Group
##############################################################

#Variable declaration for Module

variable "NSGName" {
  type    = "string"
  default = "DefaultNSG"
}



variable "RGName" {
  type    = "string"
  default = "DefaultRSG"
}

variable "NSGLocation" {
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

#Creation fo the NSG
resource "azurerm_network_security_group" "Terra-NSG" {

    name                = "${var.NSGName}"
    location            = "${var.NSGLocation}"
    resource_group_name = "${var.RGName}"


    tags {
        environment = "${var.EnvironmentTag}"
        usage       = "${var.EnvironmentUsageTag}"
    }  
}


#Output for the NSG module

output "Name" {

  value = "${azurerm_network_security_group.Terra-NSG.name}"
}

output "Id" {

  value ="${azurerm_network_security_group.Terra-NSG.id}"
}