##############################################################
#This module allow the creation of a vNEt
##############################################################

#Variable declaration for Module

variable "vNetName" {
  type    = "string"
  default = "DefaultvNet"
}



variable "RGName" {
  type    = "string"
  default = "DefaultRSG"
}

variable "vNetLocation" {
  type    = "string"
  default = "Westeurope"
}

variable "vNetAddressSpace" {
  type    = "list"
  default = ["10.0.0.0/20"]
}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

#Creating a vNet

resource "azurerm_virtual_network" "Terra-vNet" {

    name                = "${var.vNetName}"
    resource_group_name = "${var.RGName}"
    address_space       = "${var.vNetAddrespace}"
    location            = "${var.vNetLocation}"

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   
}


#Output for the vNET module

output "Name" {

  value = "${azurerm_virtual_network.Terra-vNet.name}"
}

output "Id" {

  value = "${azurerm_virtual_network.Terra-vNet.id}"
}

output "Addressspace" {

  value = "${azurerm_virtual_network.Terra-vNet.address_space}"
}

output "Location" {

  value = "${azurerm_virtual_network.Terra-vNet.location}"
}