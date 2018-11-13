##############################################################
#This module allows the creation of a storage container
##############################################################


#Storage container creation

resource "azurerm_storage_container" "Terra-STC" {
  name                  = "${var.StorageContainerName}"
  resource_group_name   = "${var.RGName}"
  storage_account_name  = "${var.StorageAccountName}"
  container_access_type = "${var.AccessType}"
}

