##############################################################
#This module allows the creation of a storage account
##############################################################


#Output for the module

output "FullOutput" {
  value                       = azurerm_storage_data_lake_gen2_filesystem.Datalakev2FS
  sensitive                   = true
}

