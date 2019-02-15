##############################################################
#This module allows the creation of an Azure VPN Gateway
##############################################################


#Output

output "GWName" {
  value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.name}"]
  #value = "${FTOption == "false" ? azurerm_virtual_network_gateway.TerraVirtualNetworkGW.name : azurerm_virtual_network_gateway.TerraVirtualNetworkGW.nameAA}"
}

output "GWId" {
  value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.*.id}"]
  #value = "${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.id}"
}

output "GWType" {
  value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.*.type}"]
  #value = "${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.type}"
}

output "GWSku" {
  value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.*.sku}"]
  #value = "${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.sku}"
}

output "GWAAName" {
  value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGWAA.name}"]
  #value = "${FTOption == "false" ? azurerm_virtual_network_gateway.TerraVirtualNetworkGW.name : azurerm_virtual_network_gateway.TerraVirtualNetworkGW.nameAA}"
}

output "GWAAId" {
  value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGWAA.*.id}"]
  #value = "${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.id}"
}

output "GWAAType" {
  value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGWAA.*.type}"]
  #value = "${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.type}"
}

output "GWAASku" {
  value = ["${azurerm_virtual_network_gateway.TerraVirtualNetworkGWAA.*.sku}"]
  #value = "${azurerm_virtual_network_gateway.TerraVirtualNetworkGW.sku}"
}