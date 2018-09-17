##############################################################
#This module allows the creation of a Netsork Security Group
##############################################################

#Variable declaration for Module

variable "NSGName" {
  type    = "string"
  default = "DefaultNSG"
}

variable "RGName" {
  type    = "string"
  default = "DefaultRSG"
}

variable "NSGLocation" {
  type    = "string"
  default = "Westeurope"
}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

