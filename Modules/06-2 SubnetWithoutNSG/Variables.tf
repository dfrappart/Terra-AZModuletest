##############################################################
#This module allows the creation of a Subnet Gateway
##############################################################

#Variable declaration for Module

variable "SubnetName" {
  type    = string
  default = "GatewaySubnet"
}


variable "RGName" {
  type    = string
  default = "DefaultRSG"
}

variable "VNetName" {
  type    = string

}

variable "Subnetaddressprefix" {
  type    = string

}

variable "SVCEP" {
  type    = list
  default = ["Microsoft.AzureCosmosDB", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.ServiceBus", "Microsoft.EventHub"]
}


