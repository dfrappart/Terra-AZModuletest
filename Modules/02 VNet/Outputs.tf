##############################################################
#This module allows the creation of a vNEt
##############################################################


#Output for the vNET module

output "Name" {
  value = "${azurerm_virtual_network.Terra-vNet.name}"
}

output "Id" {
  value = "${azurerm_virtual_network.Terra-vNet.id}"
}

output "AddressSpace" {
  value = "${azurerm_virtual_network.Terra-vNet.address_space}"
}

output "RGName" {
  value = "${azurerm_virtual_network.Terra-vNet.resource_group_name}"
}

output "RGLocation" {
  value = "${azurerm_virtual_network.Terra-vNet.location}"
}
