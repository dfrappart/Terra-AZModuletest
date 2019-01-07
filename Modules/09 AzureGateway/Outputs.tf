##############################################################
#This module allows the creation of an Azure VPN Gateway
##############################################################


#Output

output "Name" {
  #value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.name}"]
  value = "${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.name}"
}

output "Id" {
  #value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.*.id}"]
  value = "${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.id}"
}

output "Type" {
  #value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.*.type}"]
  value = "${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.type}"
}

output "Sku" {
  #value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.*.sku}"]
  value = "${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.sku}"
}
