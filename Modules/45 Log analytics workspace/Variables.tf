##############################################################
#This module allows the creation of a vNEt
##############################################################

#Variable declaration for Module

variable "LAWName" {
  type    = string
  default = "TerraLAW"
}

variable "LAWLocation" {
  type    = string

}

variable "LAWRGName" {
  type    = string

}

variable "LAWSku" {
  type    = string
  default = "PerGB2018"

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