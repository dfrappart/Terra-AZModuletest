
resource "azurerm_disk_encryption_set" "OsDiskEncryptionSet" {
  count               = var.CreateOSDiskDiskEncryptionSet ? 1 : 0
  name                = "des-osdisk-avm-${lower(var.VMSuffix)}"
  location            = local.TargetLocation
  resource_group_name = var.TargetRg
  key_vault_key_id    = var.OsDiskEncryptionSetKeyVaultKeyId
  identity {
    type         = local.OSDiskEncryptionSetIdIdentityType
    identity_ids = var.OSDiskEncryptionSetUAIIds
  }
  auto_key_rotation_enabled = var.IsOsDiskEncryptionSetAutoKeyRotationEnabled

}