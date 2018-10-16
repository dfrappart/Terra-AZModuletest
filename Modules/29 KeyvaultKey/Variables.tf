######################################################################
# This module create a keyvault resource
######################################################################

#Variable declaration for Module

variable "KeyName" {
  type = "string"
}

variable "VaultURI" {
  type = "string"
}

variable "KeyType" {
  type = "string"
  default = "RSA"
}

variable "KeySize" {
  type = "string"
  default = "4096"
}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

