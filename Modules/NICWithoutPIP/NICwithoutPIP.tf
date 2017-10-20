##############################################################
#This module allow the creation of VMs NICs
##############################################################

#Variables for NIC creation

#The NIC name
variable "NICName" {
  type    = "string"

}

#The NIC count
variable "NICCount" {
  type    = "string"
  default = "1"

}

#The NIC location
variable "NICLocation" {
  type    = "string"

}

#The resource Group in which the NIC are attached to
variable "RGName" {
  type    = "string"

}

#The subnet reference
variable "SubnetId" {
  type    = "string"

}


variable "Primary" {
  type    = "string"

}


variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

# NIC Creation 

resource "azurerm_network_interface" "TerraNICnopip" {

    name                    = "${var.NICName}"
    location                = "${var.NICLocation}"
    resource_group_name     = "${var.RGName}"

    ip_configuration {

        name                                        = "ConfigIP-NIC${var.NICName}"
        subnet_id                                   = "${var.SubnetId}"
        private_ip_address_allocation               = "dynamic"
        #public_ip_address_id                        = "${var.PublicIPId}"
        primary                                     = "${var.Primary}" 
            }

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   


}

output "Name" {

  value = "${azurerm_network_interface.TerraNICnopip.name}"
}

output "Id" {

  value = "${azurerm_network_interface.TerraNICnopip.id}"
}

output "PrivateIP" {

  value = "${azurerm_network_interface.TerraNICnopip.private_ip_address}"
}

output "Mac" {

  value = "${azurerm_network_interface.TerraNICnopip.mac_address}"
}
