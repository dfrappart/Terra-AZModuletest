##############################################################
#This module allow the creation of a Route Table 
#(User Defined Route in Azure Terminology)
##############################################################

#Variable declaration for Module

variable "RouteTableName" {
  type    = "string"
  default = "CustomRoute"
}



variable "RGName" {
  type    = "string"
  default = "DefaultRSG"
}

variable "RouteTableLocation" {
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

#Creating a Route Table

resource "azurerm_route_table" "Terra-routetable" {

    name                = "${var.RouteTableName}"
    resource_group_name = "${var.RGName}"
    location            = "${var.RouteTableLocation}"

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   
}


#Output for the Route module

output "Name" {

  value = "${azurerm_route_table.Terra-vNet.name}"
}

output "Id" {

  value = "${azurerm_route_table.Terra-vNet.id}"
}

