##############################################################
#This module allows the creation of a VNet
##############################################################

#Variable declaration for Module

variable "VNetName" {
  type    = string
  default = "DefaultVNet"
}

variable "RGName" {
  type    = string
  default = "DefaultRSG"
}

variable "VNetLocation" {
  type    = string
  default = "Westeurope"
}

variable "VNetAddressSpace" {
  type    = list
  default = ["10.0.0.0/20"]
}

variable "EnvironmentTag" {
  type    = string
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = string
  default = "Poc usage only"
}

variable "OwnerTag" {
  type    = string
  default = "That would be me"
}

variable "ProvisioningDateTag" {
  type    = string
  default = "Today :)"
}