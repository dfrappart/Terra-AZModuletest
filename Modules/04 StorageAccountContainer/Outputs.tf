##############################################################
#This module allows the creation of a storage container
##############################################################



output "Id" {
  value = "${azurerm_storage_container.Terra-STC.id}"
}

output "Properties" {
  value = "${azurerm_storage_container.Terra-STC.properties}"
}

output "RGName" {
  value = "${azurerm_storage_container.Terra-STC.resource_group_name}"
}

output "Name" {
  value = "${azurerm_storage_container.Terra-STC.name}"
}
