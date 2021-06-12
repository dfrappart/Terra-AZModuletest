##############################################################
#This module allows the creation of a storage account
##############################################################

resource "azurerm_storage_data_lake_gen2_filesystem" "Datalakev2FS" {
  name                            = var.DatalakeFSName
  storage_account_id              = var.STAId

}

