##############################################################
#This module allows the creation of a VNet
##############################################################


#Output for the VNet module

output "Name" {
  value = azurerm_virtual_network.VNet.name
}

output "Id" {
  value = azurerm_virtual_network.VNet.id
}

output "AddressSpace" {
  value = azurerm_virtual_network.VNet.address_space
}

output "RGName" {
  value = azurerm_virtual_network.VNet.resource_group_name
}

output "Location" {
  value = azurerm_virtual_network.VNet.location
}

output "VnetFull" {
  value = azurerm_virtual_network.VNet
}