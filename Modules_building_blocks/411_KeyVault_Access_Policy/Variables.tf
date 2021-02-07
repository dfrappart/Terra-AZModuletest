######################################################################
# This module create a keyvault resource
######################################################################

#Variable declaration for Module

variable "VaultId" {
  type                        = string
  description                 = "(Required) Specifies the id of the Key Vault resource. Changing this forces a new resource to be created."
}

variable "KeyVaultTenantId" {
  type                        = string
  description                 = "(Required) The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Changing this forces a new resource to be created."

}

variable "KeyVaultAPObjectId" {
  type                        = string
  description                 = "Required) The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies. Changing this forces a new resource to be created."

}

variable "Keyperms" {
  type                        = list
  default                     = null
  #["backup","create","decrypt","delete","encrypt","get","import","list","purge","recover","restore","sign","unwrapKey","update","verify","wrapKey"]
  description                 = "(Optional) List of key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey."
}

variable "Secretperms" {
  type                        = list
  default                     = null
  #["backup","delete","get","list","purge","recover","restore","set"]
  description                 = "(Optional) List of secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set."
}

variable "Certperms" {
  type                        = list
  default                     = null
  #["backup","create","delete","deleteissuers","get","getissuers","import","list","listissuers","managecontacts","manageissuers","purge","recover","restore","setissuers","update"]
  description                 = "Optional) List of certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update."
}

variable "Storageperms" {
  type                        = list
  default                     = null
  #["backup", "delete", "deletesas", "get", "getsas", "list", "listsas", "purge", "recover", "regeneratekey", "restore", "set", "setsas","update"]
  description                 = "(Optional) List of storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update."
}
