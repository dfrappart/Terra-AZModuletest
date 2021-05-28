##############################################################
#This module allows the creation of a RG
##############################################################


#Output for the RG module

output "RGName" {

  value           = azurerm_resource_group.RG.name
  sensitive       = false
}

output "RGLocation" {

  value           = azurerm_resource_group.RG.location
  sensitive       = false
}

output "RGId" {

  value           = azurerm_resource_group.RG.id
  sensitive       = false
}

output "RGFull" {

  value           = azurerm_resource_group.RG
  sensitive       = false
}