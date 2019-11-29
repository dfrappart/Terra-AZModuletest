
variable "KeyVaultId" {
    type = string
}

variable "RGKeyVaultName" {
    type = string
}

variable "KeyVaultTenantID" {
    type = string
}

variable "KeyVaultAccessPolicyObjectId" {
    type = string
}



#######################
#Variable for Policy 1
variable "KeyVaultCertpermlistPolicy" {
  type    = "list"
  default = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update"]
}

variable "KeyVaultKeyPermlistPolicy" {
  type    = "list"
  default = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
}

variable "KeyVaultSecretPermlistPolicy" {
  type    = "list"
  default = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}

