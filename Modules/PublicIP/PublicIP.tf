######################################################################
# This module allow the creation of a Public IP Address
######################################################################

#Module variables


#The Public IP Name

variable "PublicIPName" {
  type    = "string"

}

#The Public IP Location

variable "PublicIPLocation" {
  type    = "string"

}

#The RG in which the Public IP resides

variable "RGName" {
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

# Creating Public IP 

resource "random_string" "PublicIPfqdnprefix" {



    length = 5
    special = false
    upper = false
    number = false
}

resource "azurerm_public_ip" "TerraPublicIP" {


    name                            = "${var.PublicIPName}"
    location                        = "${var.PublicIPLocation}"
    resource_group_name             = "${var.RGName}"
    public_ip_address_allocation    = "static"
    domain_name_label               = "${random_string.PublicIPfqdnprefix.result}${var.PublicIPName}"

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   

}

#Module output

output "Name" {

  value = "${azurerm_public_ip.TerraPublicIP.name}"
}

output "Id" {

  value = "${azurerm_public_ip.TerraPublicIP.id}"
}

output "IPAddress" {

  value = "${azurerm_public_ip.TerraPublicIP.ip_address}"
}

output "fqdn" {

  value = "${azurerm_public_ip.TerraPublicIP.fqdn}"
}