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



######################################################
#Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type          = string
  description   = "Tag describing the owner"
  default       = "That would be me"
}

variable "CountryTag" {
  type          = string
  description   = "Tag describing the Country"
  default       = "fr"
}

variable "CostCenterTag" {
  type          = string
  description   = "Tag describing the Cost Center"
  default       = "lab"
}

variable "Project" {
  type          = string
  description   = "The name of the project"
  default       = "vnet"
}

variable "Environment" {
  type          = string
  description   = "The environment, dev, prod..."
  default       = "lab"
}