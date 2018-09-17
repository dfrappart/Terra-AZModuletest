##############################################################
#This module allows the creation of a Subnet
##############################################################

#Variable declaration for Module

variable "SubnetName" {
  type    = "string"
  default = "DefaultSubnet"
}

variable "RGName" {
  type    = "string"
  default = "DefaultRSG"
}

variable "vNetName" {
  type = "string"
}

variable "Subnetaddressprefix" {
  type = "string"
}

variable "NSGid" {
  type = "string"
}

variable "SVCEP" {
  type    = "list"
  default = ["Microsoft.AzureCosmosDB", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.ServiceBus", "Microsoft.EventHub"]
}

variable "RouteTableId" {
  type    = "string"
  default = "null"
}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

