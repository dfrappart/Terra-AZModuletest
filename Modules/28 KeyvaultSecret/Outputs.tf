######################################################################
# This module create a keyvault secret
######################################################################



#Module Output

output "Id" {
  value = azurerm_key_vault_secret.TerraSecret.id
}

output "Version" {
  value = azurerm_key_vault_secret.TerraSecret.version
}

output "Name" {
  value = azurerm_key_vault_secret.TerraSecret.name
}

output "Value" {
  value = azurerm_key_vault_secret.TerraSecret.value
}