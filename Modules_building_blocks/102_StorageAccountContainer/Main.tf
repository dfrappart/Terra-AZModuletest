##############################################################
#This module allows the creation of a storage container
##############################################################


#Storage container creation

resource "azurerm_storage_container" "STC" {
  name                  = var.StorageContainerName
  storage_account_name  = var.StorageAccountName
  container_access_type = var.AccessType
}

