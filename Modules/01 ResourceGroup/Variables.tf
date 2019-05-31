##############################################################
#This module allows the creation of a RG
##############################################################


#Variable declaration for Module



variable "RGName" {
  type    = "string"
  default = "GTMRG2"
}


variable "RGLocation" {
  type    = "string"
  default = "South Central US"
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