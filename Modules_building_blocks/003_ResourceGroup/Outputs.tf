##############################################################
#This module allows the creation of a RG
##############################################################


#Output for the RG module

output "RGName" {

  value           = azurerm_resource_group.TerraRG.name
}

output "RGLocation" {

  value           = azurerm_resource_group.TerraRG.location
}

output "RGId" {

  value           = azurerm_resource_group.TerraRG.id
}