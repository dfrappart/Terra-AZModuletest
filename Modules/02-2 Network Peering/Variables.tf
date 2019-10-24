##############################################################
#This module allows the creation of a VNet
##############################################################

#Variable declaration for Module

variable "VNetPeeringName" {
  type    = string

}

variable "RGName" {
  type    = string

}

variable "LocalVNetName" {
  type    = string

}

variable "RemoteVNetId" {
  type    = string

}

variable "IsVirtualNetworkAcccessAllowed" {
  type    = string
  default = "false"

}

variable "IsForwardedTrafficAllowed" {
  type    = string
  default = "false"

}

variable "IsGWTransitAllowed" {
  type    = string
  default = "false"

}

variable "UseRemoteGW" {
  type    = string
  default = "false"

}