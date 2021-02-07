######################################################################
# This module create a keyvault resource
######################################################################



#Resource Creation

resource "azurerm_key_vault_access_policy" "TerraKeyVaultAP" {
  
  key_vault_id                = var.VaultId
  tenant_id                   = var.KeyVaultTenantId
  object_id                   = var.KeyVaultAPObjectId
  key_permissions             = var.Keyperms
  secret_permissions          = var.Secretperms
  certificate_permissions     = var.Certperms
  storage_permissions         = var.Storageperms

}

