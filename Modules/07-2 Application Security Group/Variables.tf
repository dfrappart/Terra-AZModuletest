##############################################################
#This module allows the creation of an Application Security 
#Group
##############################################################

#Variable declaration for Module

variable "ASGName" {
  type    = "string"
  default = "DefaultNSG"
}

variable "RGName" {
  type    = "string"
  default = "DefaultRSG"
}

variable "ASGLocation" {
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

