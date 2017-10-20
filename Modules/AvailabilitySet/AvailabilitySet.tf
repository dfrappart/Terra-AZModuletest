##############################################################
#This module allow the creation of an availability set for VMs
##############################################################

#Variable declaration for Module

#The AS name
variable "ASName" {
  type    = "string"

}

#The RG in which the AS is attached to
variable "RGName" {
  type    = "string"

}

#The location in which the AS is attached to
variable "ASLocation" {
  type    = "string"

}



#Tag value to help identify the resource. 
#Required tag are EnvironmentTAg defining the type of 
#environment and
#environment Tag usage specifying the use case of the environment

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}



# Availability Set Creation

resource "azurerm_availability_set" "Terra-AS" {

    name                    = "${var.ASName}${count.index+1}"
    location                = "${var.ASLocation}"
    managed                 = "true"
    resource_group_name     = "${var.RGName}"
    tags {
        environment = "${var.EnvironmentTag}"
        usage       = "${var.EnvironmentUsageTag}"
  }
}

#Output


output "Name" {

  value = "${azurerm_availability_set.Terra-AS.name}"
}

output "Id" {

  value = "${azurerm_availability_set.Terra-AS.id}"
}
