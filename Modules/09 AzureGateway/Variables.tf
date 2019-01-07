##############################################################
#This module allows the creation of an Azure VPN Gateway
##############################################################

#Variable declaration for Module

variable "AGWName" {
  type = "string"
}

variable "AGWRGName" {
  type    = "string"
  default = "DefaultRG"
}

variable "AGWLocation" {
  type = "string"
}

variable "AGWType" {
  type    = "string"
  default = "Vpn"
}

variable "AGWVpnType" {
  type    = "string"
  default = "Routebased"

  #default = "Policybased"
}

variable "EnableBGP" {
  type    = "string"
  default = "false"
}

variable "FTOption" {
  type    = "string"
  default = "false"
}

variable "AGWsku" {
  type    = "string"
  default = "VpnGw1"

  #default = "VpnGw2"
  #default = "VpnGw3"
  #default = "Basic"
}

variable "AGWIPConfName" {
  type    = "string"
  default = "DefaultGWConf"
}

variable "AGWPRivateIPAlloc" {
  type    = "string"
  default = "Dynamic"
}

variable "AGWSubnetId" {
  type = "string"
}

variable "AGWPIPId" {
  type = "string"
}

variable "count" {
  type    = "string"
  default = "1"
}

# Variables to define the Tag


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

