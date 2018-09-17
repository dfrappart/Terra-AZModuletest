##############################################################
#This module allows the creation of a Netsork Security Group
##############################################################


#Output for the NSG module

output "Name" {
  value = "${azurerm_network_security_group.Terra-NSG.name}"
}

output "Id" {
  value = "${azurerm_network_security_group.Terra-NSG.id}"
}

output "RGName" {
  value = "${azurerm_network_security_group.Terra-NSG.resource_group_name}"
}
