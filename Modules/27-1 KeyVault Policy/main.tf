


#KeyVault Access Policy Creation

resource "azurerm_key_vault_access_policy" "TerraKeyVaultAccessPolicy" {

  key_vault_id          = var.KeyVaultId
  #resource_group_name   = var.RGKeyVaultName

  tenant_id             = var.KeyVaultTenantID
  object_id             = var.KeyVaultAccessPolicyObjectId
  #application_id        = var.KeyVaultAccessPolicyObjectId
  

  certificate_permissions = var.KeyVaultCertpermlistPolicy
  key_permissions         = var.KeyVaultKeyPermlistPolicy
  secret_permissions      = var.KeyVaultSecretPermlistPolicy

}