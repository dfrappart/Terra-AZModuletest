##############################################################
#This module allows the creation of a storage account
##############################################################


#Output for the module

output "Name" {
  value = "${azurerm_storage_account.Terra-STOA.name}"
}

output "Id" {
  value = "${azurerm_storage_account.Terra-STOA.id}"
}

output "PrimaryBlobEP" {
  value = "${azurerm_storage_account.Terra-STOA.primary_blob_endpoint}"
}

output "PrimaryQueueEP" {
  value = "${azurerm_storage_account.Terra-STOA.primary_queue_endpoint}"
}

output "PrimaryTableEP" {
  value = "${azurerm_storage_account.Terra-STOA.primary_table_endpoint}"
}

output "PrimaryFileEP" {
  value = "${azurerm_storage_account.Terra-STOA.primary_file_endpoint}"
}

output "PrimaryAccessKey" {
  value = "${azurerm_storage_account.Terra-STOA.primary_access_key}"
}

output "SecondaryAccessKey" {
  value = "${azurerm_storage_account.Terra-STOA.secondary_access_key}"
}

output "ConnectionURI" {
  value = "${azurerm_storage_account.Terra-STOA.primary_blob_connection_string}"
}

output "RGName" {
  value = "${azurerm_storage_account.Terra-STOA.resource_group_name}"
}
