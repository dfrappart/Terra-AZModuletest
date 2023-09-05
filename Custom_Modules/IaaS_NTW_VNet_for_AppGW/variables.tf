##############################################################
#TModule Spoke VNet with App GW
##############################################################

######################################################
# Environment variables

variable "ResourcePrefix" {
  type        = string
  description = "Define the resource prexix, as define in the Cloud adoptio  framework."

  default = "rg"

}

variable "Env" {
  type        = string
  description = "Define the environment kind. Possible value are sbx, dev or prd"

  validation {
    condition     = contains(["sbx", "dev", "prd"], var.Env)
    error_message = "The environment value can be only one of sbx, dev or prd"
  }

  default = "sbx"

}

variable "AppName" {
  type        = string
  description = "Define the app name"

  default = ""

}

variable "ObjectIndex" {
  type        = number
  description = "Define the index of the resources"

  #validation {
  #  condition = can(regex("^[0-9]{3}$"), var.ObjectIndex)
  #  error_message = "The object index should be defined with 3 digit, from 000 to 999"
  #}

  default = 1

}

variable "Location" {
  type        = string
  description = "The azure region"
  default     = "eastus"
}

######################################################
# Resource group variables

variable "Rg" {
  description = "An object containing the resource group to be created with it's location"
  type = object({
    Name     = string
    Location = string
    CreateRG = bool
  })

  default = {
    Name = ""
    Location = "eastus"
    CreateRG = true
  }
}
variable "RgName" {
  type        = string
  description = "The resource core name. Should follow the pattern dbaas-<env>-<tenant>-<instance>-<specificidentifyingstring>"
  default     = "unspecified"
}

variable "CreateRG" {
  type        = bool
  description = "Is the rg created within the module. Default to false"
  default     = false
}

###################################################################
# Tag related variables section

variable "DefaultTags" {
  type        = map(any)
  description = "Define a set of default tags"
  default = {
    Environment   = "dev"
    Project       = "tfmodule"
    Company       = "dfitc"
    CostCenter    = "lab"
    Country       = "fr"
    ResourceOwner = "That would be me"

  }
}

variable "ExtraTags" {
  type        = map(any)
  description = "Define a set of additional optional tags."
  default     = {}
}

######################################################
# VNet variables

variable "Vnet" {
  description = "An object containing the vnet name, address space and linked dns servers (defaults to Azure DNS), the number of subnets is automatically defined based on the address space's mask"
  type = object({
    Name          = string
    AddressSpace = string
    DnsServers   = list(string)
  })

  default = {
    Name = ""
    AddressSpace = "172.21.0.0/24"
    DnsServers = []
  }
}

variable "Subnets" {
  description = "An object containing the informations needed to create subnets, the rules object is optional and is used to add nsg rules on top of the default_nsg_rules"
  type = list(object({
    Name = string
    AllowCustomName = bool
    Nsg = object({
      Name = string
      Rules = map(object({
        Name                       = string
        Priority                   = number
        Direction                  = string
        Access                     = string
        Protocol                   = string
        SourcePortRange            = string
        DestinationPortRange       = string
        SourceAddressPrefix        = string
        DestinationAddressPrefix   = string
      }))
    })
  }))

  default = [ 
    {
      Name = "Subnet1"
      AllowCustomName = false
      Nsg = {
        Name = "Nsg-Subnet1"
        Rules = {}
      }
    } 
  ]


}

variable "default_nsg_rules" {
  description = "A map of object used to create dafault NSG rules for all NSGs inside the spoke"
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))

  default = {}
}

/*
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
# Bastion features

variable "BastionSku" {
  type          = string
  default       = "Standard"
  description   = "The SKU of the Bastion Host. Accepted values are Basic and Standard"
}

variable "BastionTunnelingEnabled" {
  type          = bool
  default       = true
  description   = "Is Tunneling feature enabled for the Bastion Host. Defaults to false."
}

variable "BastionFileCopyEnabled" {
  type          = bool
  default       = true
  description   = "Is File Copy feature enabled for the Bastion Host. Defaults to false."
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

variable "VNetLogCategories" {
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
                                            LogCatName                = "VMProtectionAlerts"
                                            IsLogCatEnabledForLAW     = true
                                            IsLogCatEnabledForSTA     = true
                                            IsRetentionEnabled        = true
                                            RetentionDaysValue        = 365
    }


  }
}

variable "VNetMetricCategories" {
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
                                            MetricCatName             = "AllMetrics"
                                            IsMetricCatEnabledForLAW  = false
                                            IsMetricCatEnabledForSTA  = true
                                            IsRetentionEnabled        = true
                                            RetentionDaysValue        = 365
    }

  }
}

*/