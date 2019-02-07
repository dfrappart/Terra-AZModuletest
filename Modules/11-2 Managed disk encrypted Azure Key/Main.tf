###################################################################
#This module allows the creation of a Managed disk with count option
###################################################################



#ManagedDisk creation

resource "azurerm_managed_disk" "TerraManagedDiskwithcount" {
  count                = "${var.Manageddiskcount}"
  name                 = "${var.ManageddiskName}${count.index+1}"
  location             = "${var.ManagedDiskLocation}"
  resource_group_name  = "${var.RGName}"
  storage_account_type = "${var.StorageAccountType}"
  create_option        = "${var.CreateOption}"
  disk_size_gb         = "${var.DiskSizeInGB}"
  encryption_settings {
    enabled = true

    key_encryption_key {
      key_url = "${var.KeyURI}"
      source_vault_id = "${var.KeyVaultId}"

    }

    disk_encryption_key {
      secret_url = "${var.DiskSecreturi}"
      source_vault_id = "${var.KeyVaultId}"

    }

  }

    tags {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}

