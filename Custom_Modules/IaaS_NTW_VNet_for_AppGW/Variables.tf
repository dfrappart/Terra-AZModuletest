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