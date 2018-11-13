######################################################################
# This module create a keyvault secret
######################################################################



#Module Output

output "Id" {
  value = "${azurerm_key_vault_key.TerraKey.id}"
}

output "Version" {
  value = "${azurerm_key_vault_key.TerraKey.version}"
}

output "Key-n" {
  value = "${azurerm_key_vault_key.TerraKey.n}"
}

output "Key-e" {
  value = "${azurerm_key_vault_key.TerraKey.e}"
}