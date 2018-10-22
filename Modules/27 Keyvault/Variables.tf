######################################################################
# This module create a keyvault resource
######################################################################

#Variable declaration for Module

variable "KeyVaultName" {
  type = "string"
}

variable "KeyVaultLocation" {
  type    = "string"
  default = "westeurope"
}

variable "KeyVaultRG" {
  type = "string"
}

variable "KeyVaultSKUName" {
  type    = "string"
  default = "standard"
}

variable "KeyVaultObjectIDPolicy1" {
  type = "string"
}

variable "KeyVaultObjectIDPolicy2" {
  type = "string"
}

variable "KeyVaultTenantID" {
  type = "string"
}
/*
variable "KeyVaultApplicationID" {
  type = "string"
}
*/

variable "KeyVaultEnabledforDeployment" {
  type    = "string"
  default = "true"
}

variable "KeyVaultEnabledforDiskEncrypt" {
  type    = "string"
  default = "true"
}

variable "KeyVaultEnabledforTempDeploy" {
  type    = "string"
  default = "true"
}

#######################
#Variable for Policy 1
variable "KeyVaultCertpermlistPolicy1" {
  type    = "list"
  default = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update"]
}

variable "KeyVaultKeyPermlistPolicy1" {
  type    = "list"
  default = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
}

variable "KeyVaultSecretPermlistPolicy1" {
  type    = "list"
  default = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}

#######################
#Variable for Policy 2
variable "KeyVaultCertpermlistPolicy2" {
  type    = "list"
  default = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update"]
}

variable "KeyVaultKeyPermlistPolicy2" {
  type    = "list"
  default = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
}

variable "KeyVaultSecretPermlistPolicy2" {
  type    = "list"
  default = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}