##############################################################
#This module allows the creation of a storage container
##############################################################



output "Id" {
  value = azurerm_storage_container.Terra_STC.id
}

output "Properties" {
  value = azurerm_storage_container.Terra_STC.properties
}

output "RGName" {
  value = azurerm_storage_container.Terra_STC.resource_group_name
}

output "Name" {
  value = azurerm_storage_container.Terra_STC.name
}
