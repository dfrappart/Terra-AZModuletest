######################################################################
# This module create a keyvault resource
######################################################################

#Variable declaration for Module

variable "KeyVaultSuffix" {
  type                  = string
  default               = "1"
  description           = "A suffix added to the keyvault name" 
}

variable "TargetLocation" {
  type                  = string
  default               = "westeurope"
  description           = "The Azure region for the resource"
}

variable "TargetRG" {
  type                  = string
  description           = "The resource group in which the resources will be deployed"
}

variable "KeyVaultSKUName" {
  type                  = string
  default               = "standard"
  description           = "The SKU for the Key Vault"
}

variable "KeyVaultTenantID" {
  type                  = string
  description           = "The Azure Tenant Id"

}

variable "KeyVaultEnabledforDeployment" {
  type                  = string
  default               = null
  description           = "Is the keyvault enabled for deployment"
}

variable "KeyVaultEnabledforDiskEncrypt" {
  type                  = string
  default               = null
  description           = "Is the keyvault enabled for deployment"
}

variable "KeyVaultEnabledforTempDeploy" {
  type                  = string
  default               = null
  description           = "Is the keyvault enabled for deployment"
}

variable "STASubLogId" {
  type                  = string
  description           = "Is the keyvault enabled for deployment"
}

variable "LawSubLogId" {
  type                  = string
  description           = "Is the keyvault enabled for deployment"

}

variable "IsKVEnabledForRBAC" {
  type                  = string
  description           = "(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false."
  default               = false

}

variable "IsKVPurgeProtectEnabled" {
  type                  = string
  description           = "(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false."
  default               = false

}

variable "KVSoftDeleteRetention" {
  type                  = string
  description           = "(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days."
  default               = null

}


###################################################################
#Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type                  = string
  description           = "Tag describing the owner"
  default               = "That would be me"
}

variable "CountryTag" {
  type                  = string
  description           = "Tag describing the Country"
  default               = "fr"
}

variable "CostCenterTag" {
  type                  = string
  description           = "Tag describing the Cost Center"
  default               = "lab"
}

variable "Company" {
  type                  = string
  description           = "The Company owner of the resources"
  default               = "dfitc"
}

variable "Project" {
  type          = string
  description   = "The name of the project"
  default       = "tfmodule"
}

variable "Environment" {
  type                  = string
  description           = "The environment, dev, prod..."
  default               = "dev"
}