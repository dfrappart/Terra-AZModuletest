##############################################################
#TModule Spoke VNet with App GW
##############################################################

######################################################
# Data sources variables

variable "RGLogName" {
  type          = string
  description   = "name of the RG containing the logs collector objects (sta and log analytics)"
}

variable "LawSubLogName" {
  type          = string
  description   = "name of the log analytics workspace containing the logs"
}

variable "STALogId" {
  type          = string
  description   = "Id of the storage account containing the logs"
}

variable "TargetRG" {
  type          = string
  description   = "name of the RG targeted for the deployment"
}

variable "TargetLocation" {
  type          = string
  description   = "Location of the resources to be deployed"
}

######################################################
#VNet variables

variable "VNetAddressSpace" {
  type          = list
  default       = ["172.20.0.0/24"]
  description   = "The IP address range for the VNet. It is a list and can thus contain more than 1 ip ranges"
}

variable "VNetSuffix" {
  type          = string
  default       = "Spoke"
  description   = "The suffix for the module spoke, something like spoke01"
}

variable "CidrDividerInfraSubnet" {
  type          = string
  default       = 2
  description   = "The divider used for the function cidrsubnet. Default to 2 with a default CIDR to /24"
}

variable "CidrDividerAppSubnet" {
  type          = string
  default       = 2
  description   = "The divider used for the function cidrsubnet. Default to 2 with a default CIDR to /24"
}

variable "BastionSubnetPosition" {
  type          = string
  default       = 0
  description   = "A integer used in the function cidrsubnet to position the subnet range"
}

variable "AGWSubnetPosition" {
  type          = string
  default       = 1
  description   = "A integer used in the function cidrsubnet to position the subnet range"
}

variable "FESubnetPosition" {
  type          = string
  default       = 2
  description   = "A integer used in the function cidrsubnet to position the subnet range"
}

variable "BESubnetPosition" {
  type          = string
  default       = 3
  description   = "A integer used in the function cidrsubnet to position the subnet range"
}
######################################################
# Bastion activation

variable "IsBastionEnabled" {
  type          = bool
  default       = false
  description   = "Define if Bastion is enabled or not"
}

######################################################
# Bastion activation

variable "IsTrafficAnalyticsEnabled" {
  type          = bool
  default       = true
  description   = "Define if Traffic Analytics is enabled or not"
}

#variable "BastionDisabledIPConfig" {
#  type = map(object({
#    "name" = string
#    "public_ip_address" = string
#    "subnet_id" = string
#  }))
#  default = {
#    "name" = "bst-pubip-config"
#    "public_ip_address_id" = "/subscriptions/00000000-0000-0000-0000-00000000000/resourceGroups/<rg_name>/providers/Microsoft.Network/publicIPAddresses/<bst-pubip>"
#    "subnet_id" = "/subscriptions/00000000-0000-0000-0000-00000000000/resourceGroups/<rg_name>/providers/Microsoft.Network/virtualNetworks/vnetpocdoc/subnets/AzureBastionSubnet"
#
#    }
#  
#}
#
######################################################
#Network watcher variables

variable "NetworkWatcherName" {
  type          = string
  default       = "NetworkWatcher_westeurope"
  description   = "The name of the network watcher, in the appropriate region"
}

variable "NetworkWatcherRGName" {
  type          = string
  default       = "NetworkWatcherRG"
  description   = "The name of the network watcher resource group"
}

######################################################
#Subnets variables

variable "SubnetEndpointLists" {
  type          = list
  default       = ["Microsoft.Sql","Microsoft.ContainerRegistry"]
  description   = "The list of Service endpoints to associate with the subnet."
}

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

                                          "Metric" = {
                                            MetricCatName             = "Capacity"
                                            IsMetricCatEnabledForLAW  = true
                                            IsMetricCatEnabledForSTA  = true
                                            IsRetentionEnabled        = true
                                            RetentionDaysValue        = 365
    }

  }
}