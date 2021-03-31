##############################################################
#This module allows the creation of a Subnet Gateway
##############################################################

#Variable declaration for Module

variable "SubnetSuffix" {
  type              = string
  description       = "A suffix for the subnet. Changing this forces a new resource to be created."

}


variable "RGName" {
  type              = string
  description       = "The name of the resource group in which to create the subnet. Changing this forces a new resource to be created."

}

variable "VNetName" {
  type              = string
  default           = "The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created."

}

variable "Subnetaddressprefixes" {
  type              = list
  description       = "The address prefixes to use for the subnet."

}

variable "ServicesEP" {
  type              = list
  description       = "The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web."
  default           = null

}



