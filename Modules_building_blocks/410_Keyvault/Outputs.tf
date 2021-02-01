######################################################################
# This module create a keyvault resource
######################################################################


#VModule Output

output "FullKVOutput" {
  value = azurerm_key_vault.TerraKeyVault
}
output "Id" {
  value = azurerm_key_vault.TerraKeyVault.id
}

output "Name" {
  value = azurerm_key_vault.TerraKeyVault.name
}

output "Location" {
  value = azurerm_key_vault.TerraKeyVault.location
}

output "RG" {
  value = azurerm_key_vault.TerraKeyVault.resource_group_name 
}

output "SKU" {
  value = azurerm_key_vault.TerraKeyVault.sku_name
}

output "TenantId" {
  value = azurerm_key_vault.TerraKeyVault.tenant_id
}

output "URI" {
  value = azurerm_key_vault.TerraKeyVault.vault_uri
}


output "KeyVault_enabled_for_disk_encryption" {
  value = azurerm_key_vault.TerraKeyVault.enabled_for_disk_encryption
}

output "KeyVault_enabled_for_template_deployment" {
  value = azurerm_key_vault.TerraKeyVault.enabled_for_template_deployment
}
