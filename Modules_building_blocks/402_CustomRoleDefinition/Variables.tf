######################################################################
# This module create a custom role 
######################################################################

#Variable declaration for Module

variable "RoleGuid" {
  type                    = string
  description             = "A unique UUID/GUID which identifies this role - one will be generated if not specified. Changing this forces a new resource to be created."
  default                 = null
}

variable "RoleName" {
  type                    = string
  description             = "The name of the Role Definition. Changing this forces a new resource to be created."
}

variable "RoleScope" {
  type                    = string
  description             = "The scope at which the Role Definition applies too, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM. It is recommended to use the first entry of the assignable_scopes. Changing this forces a new resource to be created."
}

variable "RoleDescription" {
  type                    = string
  description             = "A description of the Role Definition."
  default                 = ""
}

variable "RoleAssignableScopes" {
  type                    = string
  description             = "One or more assignable scopes for this Role Definition, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM."
  default                 = null
}

variable "Permission_Actions" {
  type                    = "list"
  description             = "One or more Allowed Actions, such as *, Microsoft.Resources/subscriptions/resourceGroups/read. See 'Azure Resource Manager resource provider operations' for details."
  default                 = null
}

variable "Permission_NotActions" {
  type                    = "list"
  description             = "One or more Disallowed  Actions, such as *, Microsoft.Resources/subscriptions/resourceGroups/read. See 'Azure Resource Manager resource provider operations' for details."
  default                 = null
}

variable "Permission_Data_Actions" {
  type                    = "list"
  description             = "One or more Allowed Data Actions, such as *, Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read. See 'Azure Resource Manager resource provider operations' for details."
  default                 = null
}

variable "Permission_Not_Data_Actions" {
  type                    = "list"
  description             = "One or more Disallowed Data Actions, such as *, Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read. See 'Azure Resource Manager resource provider operations' for details."
  default                 = null
}