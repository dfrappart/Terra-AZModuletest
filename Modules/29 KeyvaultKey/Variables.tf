######################################################################
# This module create a keyvault resource
######################################################################

#Variable declaration for Module

variable "KeyName" {
  type = string
}

variable "VaultURI" {
  type = string
}

variable "KeyType" {
  type = string
  default = "RSA"
}

variable "KeySize" {
  type = string
  default = "4096"
}

variable "KeyOpts" {
  type = list
  default = ["decrypt","encrypt","sign","unwrapKey","verify","wrapKey"]
}

variable "EnvironmentTag" {
  type    = string
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = string
  default = "Poc usage only"
}

variable "OwnerTag" {
  type    = string
  default = "That would be me"
}

variable "ProvisioningDateTag" {
  type    = string
  default = "Today :)"
}

