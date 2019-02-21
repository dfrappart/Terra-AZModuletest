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

variable "KeyVaultId" {
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

variable "OwnerTag" {
  type    = "string"
  default = "That would be me"
}

variable "ProvisioningDateTag" {
  type    = "string"
  default = "Today :)"
}

