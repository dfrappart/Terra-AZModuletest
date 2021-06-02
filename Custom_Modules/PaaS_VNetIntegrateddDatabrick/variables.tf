######################################################
# Module dtbs Variables
######################################################

######################################################
# Diagnostic settngs variable

variable "STALogId" {
  type                = string
  description         = "The storage account used for the diag settings"
  
}

variable "LawLogId" {
  type                = string
  description         = "The log analytics used for the diag settings"

}

variable "LawLogLocation" {
  type                = string
  description         = "The log analytics used for the diag settings"

}

variable "LawLogWorkspaceId" {
  type                = string
  description         = "The log analytics used for the diag settings"

}

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
#Resource Group variables

variable "TargetRG" {
  type                = string
  description         = "The Resource Group containing all the resources for this module"
  
}

variable "AzureRegion" {
  type                = string
  description         = "The Azure location"
  default             = "westeurope"
  
}

######################################################
#VNet variables

variable "VNetSuffix" {
  type                = string
  description         = "VNet name"
  default             = "dtbws"


}

variable "VNetAddressSpace" {
  type                = list
  description         = "The VNet IP Range"
  default             = [
                          "192.168.102.0/24"
                        ]

}

######################################################
#Subnets variables

variable "SubnetNames" {
  type                = list
  description         = "List of subnet names"
  default             = [
                          "pub-dtbs",
                          "priv-dtbs"

                        ]       

}

variable "Subnetaddressprefix" {
  type                = list
  description         = "List of subnet range"
  default             = ["default"]       

}

variable "SVCEP" {
  type                = list
  description         = "The list of service endpoint for the subnets"
  default             = null
}



######################################################
#Databricks workspace variables

variable "DTBWSSuffix" {
  type                = string
  description         = "A suffix for the Databricks workspace"
  default             = "1"

}

variable "DTBWSSku" {
  type                = string
  description         = "The sku of the Databricks workspace"
  default             = "standard"

}

variable "DTBWSPIP" {
  type                = string
  description         = "Define the dtbws param no_public_ip, default to false to have public ip"
  default             = false
}



######################################################
#Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type                = string
  description         = "Tag describing the owner"
  default             = "That would be me"
}

variable "CountryTag" {
  type                = string
  description         = "Tag describing the Country"
  default             = "fr"
}

variable "CostCenterTag" {
  type                = string
  description         = "Tag describing the Cost Center"
  default             = "lab"
}

variable "Project" {
  type                = string
  description         = "The name of the project"
  default             = "tfmodule"
}

variable "Environment" {
  type                = string
  description         = "The environment, dev, prod..."
  default             = "lab"
}