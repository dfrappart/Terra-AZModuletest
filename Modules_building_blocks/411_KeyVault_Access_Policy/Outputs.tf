######################################################################
# This module create a keyvault secret
######################################################################



#Module Output

output "Id" {
  value             = azurerm_key_vault_access_policy.TerraKeyVaultAP.id
  sensitive         = true
}

output "KeyVaultId" {
  value             = azurerm_key_vault_access_policy.TerraKeyVaultAP.key_vault_id
  sensitive         = true
}

output "KeyVaultAcccessPolicyFullOutput" {
  value             = azurerm_key_vault_access_policy.TerraKeyVaultAP
  sensitive         = true
}