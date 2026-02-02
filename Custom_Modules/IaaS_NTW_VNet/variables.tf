##############################################################
#TModule Spoke VNet with App GW
##############################################################

######################################################
# Environment variables

variable "ResourceGroupPrefix" {
  type        = string
  description = "Define the resource prexix, as define in the Cloud adoptio  framework."

  default = "rg"

}


variable "VnetResourcePrefix" {
  type        = string
  description = "Define the resource prexix, as define in the Cloud adoption  framework."

  default = "vnet"

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
/*
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
*/
variable "RgName" {
  type        = string
  description = "A string to define the resource group name. If not define, the empty value is replace by a local construct"
  default     = ""
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
    Name         = optional(string, "")
    AddressSpace = string
    DnsServers   = optional(list(string), [])
    EnableFlowlogs   = optional(bool, false)
  })

  default = {
    Name         = ""
    AddressSpace = "172.21.0.0/24"
    DnsServers   = []
  }
}

variable "Subnets" {
  description = "An object containing the informations needed to create subnets, the rules object is optional and is used to add nsg rules on top of the default_nsg_rules"
  type = list(object({
    Name             = string
    AllowCustomName  = bool
    EnableNsg        = bool
    EnableNsgDiagSet = optional(bool, false)
    #EnableFlowlogs   = optional(bool, false)
    AddressPrefix    = optional(string, null)
    Delegation = optional(object({
      DelegationName           = string
      ServiceDelegationName    = string
      ServiceDelegationActions = list(string)
    }), null)
    Nsg = object({
      Name = string
      Rules = map(object({
        Name                       = string
        Priority                   = number
        Direction                  = string
        Access                     = string
        Protocol                   = string
        SourcePortRange            = optional(string, null)
        SourcePortRanges           = optional(list(string), null)
        DestinationPortRange       = optional(string, null)
        DestinationPortRanges      = optional(list(string), null)
        SourceAddressPrefix        = optional(string, null)
        SourceAddressPrefixes      = optional(list(string), null)
        DestinationAddressPrefix   = optional(string, null)
        DestinationAddressPrefixes = optional(list(string), null)
      }))
    })
  }))

  default = [
    {
      Name            = "Subnet1"
      AllowCustomName = false
      EnableNsg       = true
      Nsg = {
        Name  = "Nsg-Subnet1"
        Rules = {}
      }
    }
  ]


}

variable "EnableNsgDenyAll" {
  type        = bool
  description = "A bool to enable or disable the addition of default deny all inbound and outbound rules to all NSGs"
  default     = false
}

variable "DefaultNsgRules" {
  description = "A map of object used to create dafault NSG rules for all NSGs inside the spoke"
  type = map(object({
    Name                       = string
    Priority                   = number
    Direction                  = string
    Access                     = string
    Protocol                   = string
    SourcePortRange            = optional(string, null)
    SourcePortRanges           = optional(list(string), [])
    DestinationPortRange       = optional(string, null)
    DestinationPortRanges      = optional(list(string), [])
    SourceAddressPrefix        = optional(string, null)
    SourceAddressPrefixes      = optional(list(string), [])
    DestinationAddressPrefix   = optional(string, null)
    DestinationAddressPrefixes = optional(list(string), [])
  }))

  default = {}
}


variable "SecureNsgRules" {
  description = "A map of object used to create dafault NSG rules for all NSGs inside the spoke"
  type = map(object({
    Name                       = string
    Priority                   = number
    Direction                  = string
    Access                     = string
    Protocol                   = string
    SourcePortRange            = optional(string, null)
    SourcePortRanges           = optional(list(string), [])
    DestinationPortRange       = optional(string, null)
    DestinationPortRanges      = optional(list(string), [])
    SourceAddressPrefix        = optional(string, null)
    SourceAddressPrefixes      = optional(list(string), [])
    DestinationAddressPrefix   = optional(string, null)
    DestinationAddressPrefixes = optional(list(string), [])
  }))

  default = {
    DenyAllIn = {
      Name                     = "Default_DenyAll_Inbound"
      Priority                 = 4000
      Direction                = "Inbound"
      Access                   = "Deny"
      Protocol                 = "*"
      SourcePortRange          = "*"
      DestinationPortRange     = "*"
      SourceAddressPrefix      = "*"
      DestinationAddressPrefix = "*"

    }
    AllowLbIn = {
      Name                     = "Default_AllowLoadBalancer_Inbound"
      Priority                 = 3500
      Direction                = "Inbound"
      Access                   = "Allow"
      Protocol                 = "*"
      SourcePortRange          = "*"
      DestinationPortRange     = "*"
      SourceAddressPrefix      = "AzureLoadBalancer"
      DestinationAddressPrefix = "*"

    }
  }
}

variable "BastionNsgRules" {
  description = "A map of object used to create dafault NSG rules for all NSGs inside the spoke"
  type = map(object({
    Name                       = string
    Priority                   = number
    Direction                  = string
    Access                     = string
    Protocol                   = string
    SourcePortRange            = optional(string, null)
    SourcePortRanges           = optional(list(string), [])
    DestinationPortRange       = optional(string, null)
    DestinationPortRanges      = optional(list(string), [])
    SourceAddressPrefix        = optional(string, null)
    SourceAddressPrefixes      = optional(list(string), [])
    DestinationAddressPrefix   = optional(string, null)
    DestinationAddressPrefixes = optional(list(string), [])
  }))

  default = {
    Default_BastionSubnet_AllowHTTPSBastionIn = {
      Name                     = "Default_BastionSubnet_AllowHTTPSBastionIn"
      Priority                 = 3010
      Direction                = "Inbound"
      Access                   = "Allow"
      Protocol                 = "Tcp"
      SourcePortRange          = "*"
      DestinationPortRange     = "443"
      SourceAddressPrefix      = "Internet"
      DestinationAddressPrefix = "*"

    }
    Default_BastionSubnet_AllowGatewayManager = {
      Name                     = "Default_BastionSubnet_AllowGatewayManager"
      Priority                 = 3020
      Direction                = "Inbound"
      Access                   = "Allow"
      Protocol                 = "Tcp"
      SourcePortRange          = "*"
      DestinationPortRanges    = ["443"]
      SourceAddressPrefix      = "GatewayManager"
      DestinationAddressPrefix = "*"

    }
    Default_BastionSubnet_AllowAzureLB = {
      Name                     = "Default_BastionSubnet_AllowAzureLB"
      Priority                 = 3030
      Direction                = "Inbound"
      Access                   = "Allow"
      Protocol                 = "Tcp"
      SourcePortRange          = "*"
      DestinationPortRanges    = ["443"]
      SourceAddressPrefix      = "AzureLoadBalancer"
      DestinationAddressPrefix = "*"

    }
    Default_BastionSubnet_AllowBastionCommunicationIn = {
      Name                     = "Default_BastionSubnet_AllowBastionCommunicationIn"
      Priority                 = 3040
      Direction                = "Inbound"
      Access                   = "Allow"
      Protocol                 = "Tcp"
      SourcePortRange          = "*"
      DestinationPortRanges    = ["8080", "5701"]
      SourceAddressPrefix      = "VirtualNetwork"
      DestinationAddressPrefix = "VirtualNetwork"

    }
    Default_BastionSubnet_AllowRemoteBastionOut = {
      Name                     = "Default_BastionSubnet_AllowRemoteBastionOut"
      Priority                 = 3010
      Direction                = "Outbound"
      Access                   = "Allow"
      Protocol                 = "Tcp"
      SourcePortRange          = "*"
      DestinationPortRanges    = ["22", "3389"]
      SourceAddressPrefix      = "*"
      DestinationAddressPrefix = "VirtualNetwork"

    }
    Default_AllowAzureCloudHTTPSOut = {
      Name                     = "Default_AllowAzureCloudHTTPSOut"
      Priority                 = 3020
      Direction                = "Outbound"
      Access                   = "Allow"
      Protocol                 = "Tcp"
      SourcePortRange          = "*"
      DestinationPortRanges    = ["443"]
      SourceAddressPrefix      = "*"
      DestinationAddressPrefix = "AzureCloud"

    }
    Default_AllowAzureBastionGetSessionInformationOut = {
      Name                     = "Default_AllowAzureBastionGetSessionInformationOut"
      Priority                 = 3030
      Direction                = "Outbound"
      Access                   = "Allow"
      Protocol                 = "Tcp"
      SourcePortRange          = "*"
      DestinationPortRanges    = ["80"]
      SourceAddressPrefix      = "*"
      DestinationAddressPrefix = "Internet"

    }
    Default_BastionSubnet_DenyVNetOut = {
      Name                     = "Default_BastionSubnet_DenyVNetOut"
      Priority                 = 3040
      Direction                = "Outbound"
      Access                   = "Deny"
      Protocol                 = "Tcp"
      SourcePortRange          = "*"
      DestinationPortRange    = "*"
      SourceAddressPrefix      = "*"
      DestinationAddressPrefix = "VirtualNetwork"

    }
    Default_BastionSubnet_DenyInternetOut = {
      Name                     = "Default_BastionSubnet_DenyInternetOut"
      Priority                 = 3050
      Direction                = "Outbound"
      Access                   = "Deny"
      Protocol                 = "*"
      SourcePortRange          = "*"
      DestinationPortRange    = "*"
      SourceAddressPrefix      = "*"
      DestinationAddressPrefix = "Internet"

    }
  }
}

variable "CustomVnet" {
  type        = bool
  description = "Define the Vnet type. If false, the subnets are following a regular pattern in size. If true, subnets follow specific patterns"
  default     = false
}

######################################################
# Log variables

variable "LawLogId" {
  type        = string
  description = "ID of the log analytics workspace containing the logs, if not specified, no diagnostic settings to log analytics is created"
  default     = "unspecified"
}
variable "StaLogId" {
  type        = string
  description = "Id of the storage account containing the logs, if not specified, no diagnostic settings to storage account is created"
  default     = "unspecified"
}

variable "CreateLocalSta" {
  type        = bool
  description = "A bool to enable or disable the creation of a local storage account for logs"
  default     = false
}

variable "CreateLocalLaw" {
  type        = bool
  description = "A bool to enable or disable the creation of a local log analytics workspace for logs"
  default     = false
}

######################################################
# Vnet Log variables

variable "EnableVnetDiagSettings" {
  type        = bool
  description = "A bool to enable or disable the diagnostic settings"
  default     = false
}


variable "VnetLogCategories" {

  description = "A list of log categories to activate on the Virtual Network. If set to null, it will use a data source to enable all categories"
  type        = list(any)
  default     = null

}

variable "VnetMetricCategories" {

  description = "A list of metric categories to activate on the Virtual Network. If set to null, it will use a data source to enable all categories"
  type        = list(any)
  default     = null

}

######################################################
# Nsg Log variables
variable "NsgLogCategories" {

  description = "A list of log categories to activate on the Nsgs. If set to null, it will use a data source to enable all categories"
  type        = list(any)
  default     = null

}

variable "NsgMetricCategories" {

  description = "A list of metric categories to activate on the Nsgs. If set to null, it will use a data source to enable all categories"
  type        = list(any)
  default     = null

}

######################################################
# Flow logs variables

variable "IsTrafficAnalyticsEnabled" {
  type        = bool
  description = "Define if flow log is enabled wih traffic analytics"
  default     = true
}

variable "NetworkWatcherRGName" {
  type        = string
  default     = "unspecified"
  description = "Define the Resource group for Network Watcher. If not specified, locals block create the default resource group name for network watcher"
}

variable "NetworkWatcherName" {
  type        = string
  default     = "unspecified"
  description = "Define the Network Watcher Name. If not specified, locals block create the default name for network watcher"
}