##############################################################
# Variable for kubernetes User Assigned Identity
##############################################################

#Variable declaration for Module

variable "UAISuffix" {
  type        = string
  default     = "1"
  description = "A suffix added to the UAI name"
}

variable "TargetLocation" {
  type        = string
  default     = "westeurope"
  description = "The Azure region for the resource"
}

variable "TargetRG" {
  type        = string
  description = "The resource group in which the resources will be deployed"
}

###################################################################
#Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type        = string
  description = "Tag describing the owner"
  default     = "That would be me"
}

variable "CountryTag" {
  type        = string
  description = "Tag describing the Country"
  default     = "fr"
}

variable "CostCenterTag" {
  type        = string
  description = "Tag describing the Cost Center"
  default     = "tflab"
}

variable "Company" {
  type        = string
  description = "The Company owner of the resources"
  default     = "dfitc"
}

variable "Project" {
  type        = string
  description = "The name of the project"
  default     = "tfmodule"
}

variable "Environment" {
  type        = string
  description = "The environment, dev, prod..."
  default     = "lab"
}

######################################################################
# role assignment with a build in role
######################################################################


variable "RBACScope" {
  type        = string
  description = "The scope at which the Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM, or /providers/Microsoft.Management/managementGroups/myMG. Changing this forces a new resource to be created."
}

variable "BuiltinRoleName" {
  type        = string
  description = "The name of a built-in Role. Changing this forces a new resource to be created. Conflicts with role_definition_id. Refer to https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles for list of built in roles"
}
