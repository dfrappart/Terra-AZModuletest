######################################################################
# This module create a keyvault resource
######################################################################


#VModule Output

output "Id" {
  value = "${azurerm_key_vault.TerraKeyVault.id}"
}

output "Name" {
  value = "${azurerm_key_vault.TerraKeyVault.name}"
}


output "URI" {
  value = "${azurerm_key_vault.TerraKeyVault.vault_uri}"
}


output "SKU" {
  value = "${azurerm_key_vault.TerraKeyVault.sku}"
}

output "KeyVaultAccessPolicy" {
  value = "${azurerm_key_vault.TerraKeyVault.access_policy}"
}

output "KeyVault_enabled_for_disk_encryption" {
  value = "${azurerm_key_vault.TerraKeyVault.enabled_for_disk_encryption}"
}

output "KeyVault_enabled_for_template_deployment" {
  value = "${azurerm_key_vault.TerraKeyVault.enabled_for_template_deployment}"
}

output "KeyVault_location" {
  value = "${azurerm_key_vault.TerraKeyVault.location}"
}