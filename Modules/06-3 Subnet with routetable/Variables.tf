##############################################################
#This module allows the creation of a Subnet
##############################################################

#Variable declaration for Module

variable "SubnetName" {
  type    = string
  default = "DefaultSubnet"
}

variable "RGName" {
  type    = string
  default = "DefaultRSG"
}

variable "VNetName" {
  type = string
}

variable "Subnetaddressprefix" {
  type = string
}

variable "NSGid" {
  type = string
  default = "null"
}

variable "SVCEP" {
  type    = list
  default = null
}

variable "RouteTableId" {
  type    = string
  default = "null"
}

variable "EnvironmentTag" {
  type    = string
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = string
  default = "Poc usage only"
}

