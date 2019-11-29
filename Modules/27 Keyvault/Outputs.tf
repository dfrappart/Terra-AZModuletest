######################################################################
# This module create a keyvault resource
######################################################################


#Module Output

output "RGKeyVaultName" {
  value = azurerm_resource_group.RGKeyVault.name
}

output "RGKeyVaultId" {
  value = azurerm_resource_group.RGKeyVault.id
}

output "Id" {
  value = azurerm_key_vault.TerraKeyVault.id
}

output "Name" {
  value = azurerm_key_vault.TerraKeyVault.name
}


output "URI" {
  value = azurerm_key_vault.TerraKeyVault.vault_uri
}


output "SKU" {
  value = azurerm_key_vault.TerraKeyVault.sku
}

output "KeyVault_enabled_for_disk_encryption" {
  value = azurerm_key_vault.TerraKeyVault.enabled_for_disk_encryption
}

output "KeyVault_enabled_for_template_deployment" {
  value = azurerm_key_vault.TerraKeyVault.enabled_for_template_deployment
}

output "KeyVault_location" {
  value = azurerm_key_vault.TerraKeyVault.location
}