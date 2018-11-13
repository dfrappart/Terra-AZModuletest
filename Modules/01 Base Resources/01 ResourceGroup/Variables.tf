##############################################################
#This module allows the creation of a RG
##############################################################


#Variable declaration for Module



variable "RGName" {
  type    = "string"
  default = "DefaultRG"
}


variable "RGLocation" {
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

variable "OwnerTag" {
  type    = "string"
  default = "That would be me"
}

variable "ProvisioningDateTag" {
  type    = "string"
  default = "Today :)"
}