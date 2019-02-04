##############################################################
#This module allows the creation of a Local VPN Gateway Object
##############################################################



#Module Output


output "Id" {

  value = "${azurerm_local_network_gateway.TerraLocalGW.id}"
  
}

output "Address" {
  value = "${azurerm_local_network_gateway.TerraLocalGW.gateway_address}"
}

output "AddressSpace" {
  value = "${azurerm_local_network_gateway.TerraLocalGW.address_space}"
}