##############################################################
#This module allows the creation of a Subnet Gateway
##############################################################



#Output



output "Name" {

  value = "${azurerm_subnet.TerraSubnet.name}"
}

output "Id" {

  value = "${azurerm_subnet.TerraSubnet.id}"
}

output "AddressPrefix" {

  value = "${azurerm_subnet.TerraSubnet.address_prefix}"
}