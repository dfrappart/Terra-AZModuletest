
resource "azurerm_disk_encryption_set" "OsDiskEncryptionSet" {
  count               = var.CreateOSDiskDiskEncryptionSet ? 1 : 0
  name                = "des-mdmanaged-hdd-osdisk-${lower(var.VMSuffix)}"
  location            = local.TargetLocation
  resource_group_name = var.TargetRg
  key_vault_key_id    = var.OsDiskEncryptionSetKeyVaultKeyId
  identity {
    type         = local.OSDiskEncryptionSetIdIdentityType
    identity_ids = var.OSDiskEncryptionSetUAIIds
  }
  auto_key_rotation_enabled = var.IsOsDiskEncryptionSetAutoKeyRotationEnabled

}

resource "azurerm_disk_encryption_set" "DataDiskEncryptionSet" {
  for_each            = var.Datadisks
  name                = "des-mdmanaged-${azurerm_managed_disk.DataDisk[each.key].name}"
  location            = local.TargetLocation
  resource_group_name = var.TargetRg
  key_vault_key_id    = each.value.DiskEncryptionSetKeyVaultKeyId
  identity {
    type         = each.value.DataDiskEncryptionSetIdentityType
    identity_ids = [each.value.DesUaiId]
  }
  auto_key_rotation_enabled = each.value.IsDiskEncryptionSetAutoKeyRotationEnabled

}