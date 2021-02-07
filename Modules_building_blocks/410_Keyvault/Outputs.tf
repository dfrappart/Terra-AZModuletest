######################################################################
# This module create a keyvault resource
######################################################################


#VModule Output

output "FullKVOutput" {
  value             = azurerm_key_vault.TerraKeyVault
  sensitive         = true
}
output "Id" {
  value             = azurerm_key_vault.TerraKeyVault.id
  sensitive         = true
}

output "Name" {
  value             = azurerm_key_vault.TerraKeyVault.name
  sensitive         = false
}

output "Location" {
  value             = azurerm_key_vault.TerraKeyVault.location
  sensitive         = false
}

output "RG" {
  value             = azurerm_key_vault.TerraKeyVault.resource_group_name
  sensitive         = false 
}

output "SKU" {
  value             = azurerm_key_vault.TerraKeyVault.sku_name
  sensitive         = false
}

output "TenantId" {
  value             = azurerm_key_vault.TerraKeyVault.tenant_id
  sensitive         = false
}

output "URI" {
  value             = azurerm_key_vault.TerraKeyVault.vault_uri
  sensitive         = true
}


output "KeyVault_enabled_for_disk_encryption" {
  value             = azurerm_key_vault.TerraKeyVault.enabled_for_disk_encryption
  sensitive         = false
}

output "KeyVault_enabled_for_template_deployment" {
  value             = azurerm_key_vault.TerraKeyVault.enabled_for_template_deployment
  sensitive         = false
}
