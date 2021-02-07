######################################################################
# This module create a keyvault secret
######################################################################



#Module Output

output "Id" {
  value             = azurerm_key_vault_secret.TerraSecret.id
  sensitive         = true
}

output "Version" {
  value             = azurerm_key_vault_secret.TerraSecret.version
  sensitive         = false
}

output "Name" {
  value             = azurerm_key_vault_secret.TerraSecret.name
  sensitive         = false
}

output "SecretFullOutput" {
  value = azurerm_key_vault_secret.TerraSecret
  sensitive         = true
}