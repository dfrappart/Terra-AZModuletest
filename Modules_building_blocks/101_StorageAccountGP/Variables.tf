##############################################################
#This module allows the creation of a storage account
##############################################################

#module variables

#The ST Name

variable "STASuffix" {
  type                                  = string
  description                           = "a suffix to add at the end of the storage account name"            
}

#The RG Name

variable "RGName" {
  type                                  = string
  description                           = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
}

#The Storage Account Location

variable "StorageAccountLocation" {
  type                                  = string
  description                           = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

#The Storage Account Tier

variable "StorageAccountTier" {
  type                                  = string
  default                               = "Standard"
  description                           = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
}

#The Storage Account Replication Type, accept LRS, GRS, RAGRS and ZRS.

variable "StorageReplicationType" {
  type                                  = string
  default                               = "LRS"
  description                           = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
}


#The Storage Account kind

variable "StorageAccoutKind" {
  type                                  = string
  default                               = null
  description                           = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to StorageV2."

}

#The Storage Account access tier

variable "StorageAccessTier" {
  type                                  = string
  default                               = null
  description                           = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot."
}

#The Storage HTTPS Settings

variable "HTTPSSetting" {
  type                                  = string
  default                               = true
  description                           = "Boolean flag which forces HTTPS if enabled, see here for more information. Defaults to true."
}

#The Storage TLS Version

variable "TLSVer" {
  type                                  = string
  default                               = "TLS1_2"
  description                           = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2."
}

#HNS enabled parameter

variable "IsHNSEnabled" {
  type                                  = string
  default                               = null
  description                           = " Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see here for more information). Changing this forces a new resource to be created."
}
/*
NOTE:

This can only be true when account_tier is Standard or when account_tier is Premium and account_kind is BlockBlobStorage 
*/

###################################################################
#Tag related variables section

variable "ResourceOwnerTag" {
  type                                  = string
  description                           = "Tag describing the owner"
  default                               = "That would be me"
}

variable "CountryTag" {
  type                                  = string
  description                           = "Tag describing the Country"
  default                               = "fr"
}

variable "CostCenterTag" {
  type                                  = string
  description                           = "Tag describing the Cost Center"
  default                               = "labtf"
}

variable "EnvironmentTag" {
  type                                  = string
  description                           = "The environment, dev, prod..."
  default                               = "dev"
}

variable "Project" {
  type                                  = string
  description                           = "The project name"
  default                               = "tfmodule"
}
