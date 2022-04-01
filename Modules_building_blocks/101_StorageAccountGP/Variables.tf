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

variable "DefaultTags" {
  type                                  = map
  description                           = "Define a set of default tags"
  default                               = {
    ResourceOwner                       = "That would be me"
    Country                             = "fr"
    CostCenter                          = "labtf"
    Project                             = "tfmodule"
    Environment                         = "lab"
    ManagedBy                           = "Terraform"

  }
}

variable "ExtraTags" {
  type                                  = map
  description                           = "Define a set of additional optional tags."
  default                               = {}
}


###################################################################
# Diag settings related variables section

variable "LawLogId" {
  type                                  = string
  description                           = "The Id of the Log Analytics workspace used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0"
  default                               = "unspecified"
}

variable "STALogId" {
  type                                  = string
  description                           = "The Id of the storage account used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0"
  default                               = "unspecified"
}

variable "LogCategories" {
  type                                  = map(object({
                                            LogCatName                = string
                                            IsLogCatEnabledForLAW     = bool
                                            IsLogCatEnabledForSTA     = bool
                                            IsRetentionEnabled        = bool
                                            RetentionDaysValue        = number
  }))
  description                           = "Define The logs categories"
  default                               = {

                                          "Category1" = {
                                            LogCatName                = "StorageRead"
                                            IsLogCatEnabledForLAW     = false
                                            IsLogCatEnabledForSTA     = true
                                            IsRetentionEnabled        = true
                                            RetentionDaysValue        = 365
    }
                                          "Category2" = {
                                            LogCatName                = "StorageWrite"
                                            IsLogCatEnabledForLAW     = false
                                            IsLogCatEnabledForSTA     = true
                                            IsRetentionEnabled        = true
                                            RetentionDaysValue        = 365
    }
                                          "Category3" = {
                                            LogCatName                = "StorageDelete"
                                            IsLogCatEnabledForLAW     = false
                                            IsLogCatEnabledForSTA     = true
                                            IsRetentionEnabled        = true
                                            RetentionDaysValue        = 365
    }

  }
}

variable "MetricCategories" {
  type                                  = map(object({
                                            MetricCatName             = string
                                            IsMetricCatEnabledForLAW  = bool
                                            IsMetricCatEnabledForSTA  = bool
                                            IsRetentionEnabled        = bool
                                            RetentionDaysValue        = number
  }))
  description                           = "Define The metric categories"
  default                               = {

                                          "Metric1" = {
                                            MetricCatName             = "Transaction"
                                            IsMetricCatEnabledForLAW  = true
                                            IsMetricCatEnabledForSTA  = true
                                            IsRetentionEnabled        = true
                                            RetentionDaysValue        = 365
    }

  }
}

###################################################################
# Network rules related variables section

variable "AllowedIPList" {
  type                                  = list
  description                           = "List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed."
  default                               = []
}

variable "AllowedSubnetIdList" {
  type                                  = list
  description                           = "A list of virtual network subnet ids to to secure the storage account."
  default                               = []
}

variable "ByPassConfig" {
  type                                  = list
  description                           = " Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  default                               = ["Logging","Metrics"]
}