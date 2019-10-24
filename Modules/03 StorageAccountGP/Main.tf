##############################################################
#This module allows the creation of a storage account
##############################################################



#Storage account creation
locals {

  STAName = lower(var.StorageAccountName)
}


resource "azurerm_storage_account" "Terra_STOA" {
  name                     = substr(var.StorageAccountName,0,15)
  resource_group_name      = var.RGName
  location                 = var.StorageAccountLocation
  account_tier             = var.StorageAccountTier
  account_replication_type = var.StorageReplicationType
  account_kind             = "StorageV2"

  tags = {
    Environment            = var.EnvironmentTag
    Usage                  = var.EnvironmentUsageTag
    StorageReplicationType = var.StorageReplicationType
    StorageAccountTier     = var.StorageAccountTier
    Owner                  = var.OwnerTag
    ProvisioningDate       = var.ProvisioningDateTag
  }
}

