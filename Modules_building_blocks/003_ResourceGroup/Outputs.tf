##############################################################
#This module allows the creation of a RG
##############################################################


#Output for the RG module

output "RGName" {

  value           = azurerm_resource_group.RG.name
}

output "RGLocation" {

  value           = azurerm_resource_group.RG.location
}

output "RGId" {

  value           = azurerm_resource_group.RG.id
}

output "RGFull" {

  value           = azurerm_resource_group.RG
}