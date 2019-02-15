##############################################################
#This module allows the creation of an Azure VPN Gateway
##############################################################


#Output

output "Name" {
  #value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.name}"]
  value = "${FTOption == "false" ? azurerm_virtual_network_gateway.TerraVirtualNetworkGW.name : azurerm_virtual_network_gateway.TerraVirtualNetworkGW.nameAA}"
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
