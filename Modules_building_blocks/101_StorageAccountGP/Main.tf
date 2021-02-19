##############################################################
#This module allows the creation of a storage account
##############################################################

resource "azurerm_storage_account" "Terra_STOA" {
  name                                  = "st${lower(var.STASuffix)}"
  resource_group_name                   = var.RGName
  location                              = var.StorageAccountLocation
  account_tier                          = var.StorageAccountTier
  account_replication_type              = var.StorageReplicationType
  account_kind                          = var.StorageAccoutKind
  access_tier                           = var.StorageAccessTier
  enable_https_traffic_only             = var.HTTPSSetting
  min_tls_version                       = var.TLSVer

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Environment                         = var.EnvironmentTag
    ManagedBy                           = "Terraform"
  }
}

