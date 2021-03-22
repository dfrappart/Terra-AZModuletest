##############################################################
#This module allows the creation of a storage account
##############################################################


#Output for the module

output "Name" {
  value                       = azurerm_storage_account.STOA.name
  sensitive                   = false
}

output "Id" {
  value                       = azurerm_storage_account.STOA.id
  sensitive                   = true
}

output "PrimaryBlobEP" {
  value                       = azurerm_storage_account.STOA.primary_blob_endpoint
  sensitive                   = true
}

output "PrimaryQueueEP" {
  value                       = azurerm_storage_account.STOA.primary_queue_endpoint
  sensitive                   = true
}

output "PrimaryTableEP" {
  value                       = azurerm_storage_account.STOA.primary_table_endpoint
  sensitive                   = true
}

output "PrimaryFileEP" {
  value                       = azurerm_storage_account.STOA.primary_file_endpoint
  sensitive                   = true
}

output "PrimaryAccessKey" {
  value                       = azurerm_storage_account.STOA.primary_access_key
  sensitive                   = true
}

output "SecondaryAccessKey" {
  value                       = azurerm_storage_account.STOA.secondary_access_key
  sensitive                   = true
}

output "ConnectionURI" {
  value                       = azurerm_storage_account.STOA.primary_blob_connection_string
  sensitive                   = true
}

output "RGName" {
  value                       = azurerm_storage_account.STOA.resource_group_name
  sensitive                   = true
}

output "STAFull" {
  value                       = azurerm_storage_account.STOA
  sensitive                   = true
}