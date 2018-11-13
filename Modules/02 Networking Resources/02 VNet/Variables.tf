##############################################################
#This module allows the creation of a vNEt
##############################################################

#Variable declaration for Module

variable "vNetName" {
  type    = "string"
  default = "DefaultvNet"
}

variable "RGName" {
  type    = "string"
  default = "DefaultRSG"
}

variable "vNetLocation" {
  type    = "string"
  default = "Westeurope"
}

variable "vNetAddressSpace" {
  type    = "list"
  default = ["10.0.0.0/20"]
}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

