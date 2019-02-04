##############################################################
#This module allows the creation of a storage account
##############################################################



#Storage account creation

resource "azurerm_storage_account" "Terra-STOA" {
  name                     = "stoa${lower(var.StorageAccountName)}"
  resource_group_name      = "${var.RGName}"
  location                 = "${var.StorageAccountLocation}"
  account_tier             = "${var.StorageAccountTier}"
  account_replication_type = "${var.StorageReplicationType}"
  account_kind             = "StorageV2"

  tags {
    Environment            = "${var.EnvironmentTag}"
    Usage                  = "${var.EnvironmentUsageTag}"
    StorageReplicationType = "${var.StorageReplicationType}"
    StorageAccountTier     = "${var.StorageAccountTier}"
    Owner                  = "${var.OwnerTag}"
    ProvisioningDate       = "${var.ProvisioningDateTag}"
  }
}

