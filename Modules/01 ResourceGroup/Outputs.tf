##############################################################
#This module allows the creation of a RG
##############################################################


#Output for the RG module

output "Name" {

  value = azurerm_resource_group.Terra_RG.name
}

output "Location" {

  value = azurerm_resource_group.Terra_RG.location
}

output "Id" {

  value = azurerm_resource_group.Terra_RG.id
}