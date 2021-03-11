######################################################################
# This module create a keyvault secret
######################################################################



#Module Output

output "Id" {
  value               = azurerm_key_vault_certificate.Cert.id
}

output "Full" {
  value               = azurerm_key_vault_certificate.Cert
  sensitive           = true
}

