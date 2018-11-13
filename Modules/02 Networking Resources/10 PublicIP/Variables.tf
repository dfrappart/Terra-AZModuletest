######################################################################
# This module allows the creation of a Public IP Address
######################################################################

#Module variables

#Public IP Count

variable "PublicIPCount" {
  type    = "string"
  default = "1"
}

#The Public IP Name

variable "PublicIPName" {
  type = "string"
}

#The Public IP Location

variable "PublicIPLocation" {
  type = "string"
}

#The RG in which the Public IP resides

variable "RGName" {
  type = "string"
}

#The IP Address allocation. Can be dynamic or static

variable "PIPAddressAllocation" {
  type    = "string"
  default = "static"
}

#The IP Address sku. Can be basic or standard

variable "PIPAddressSku" {
  type    = "string"
  default = "basic"
}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

