##############################################################
#This module allows the creation of a Local VPN Gateway Object
##############################################################

#Variable declaration for Module

# Site to site connection Name

variable "S2SConnectName" {
  type = "string"
}

#Site to Site connection object location in Azure

variable "S2SConnectLocation" {
  type = "string"
}

#Site to site connection Resource Group

variable "S2SConnectRG" {
  type = "string"
}

#ID virtual network gateway

variable "S2SConnectGWId" {
  type = "string"
}

#ID local network gateway

variable "S2SConnectLGWId" {
  type = "string"
}

#Shared Key

variable "S2SConnectKey" {
  type = "string"
}

#variables ipsec config############################
variable "S2Sdh_group" {}

variable "S2Sike_encryption" {}

variable "S2Sike_integrity" {}

variable "S2Sipsec_encryption" {}

variable "S2Sipsec_integrity" {}

variable "S2Spfs_group" {}

variable "S2Ssa_datasize" {
  type = "string"
  default = "102400000"
}

variable "S2Ssa_lifetime" {
    type = "string"
  default = "27000"
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