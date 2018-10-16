######################################################################
# This module create a keyvault resource
######################################################################

#Variable declaration for Module

variable "PasswordName" {
  type = "string"
}

variable "PasswordValue" {
  type = "string"
}

variable "VaultURI" {
  type = "string"
}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

#Resource Creation

resource "azurerm_key_vault_secret" "TerraWinVMPwd" {
  name      = "${var.PasswordName}"
  value     = "${var.PasswordValue}"
  vault_uri = "${var.VaultURI}"

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

#Module Output

output "ID" {
  value = "${azurerm_key_vault_secret.TerraWinVMPwd.id}"
}

output "Version" {
  value = "${azurerm_key_vault_secret.TerraWinVMPwd.version}"
}

output "Name" {
  value = "${azurerm_key_vault_secret.TerraWinVMPwd.name}"
}
