######################################################################
# This module allows the creation of a Public IP Address
######################################################################

#Module variables


#The Public IP Name

variable "PublicIPName" {
  type = string
}

#The Public IP Location

variable "PublicIPLocation" {
  type = string
}

#The RG in which the Public IP resides

variable "RGName" {
  type = string
}


#Is the IP regional or zone redundant ?
#Warning: if the IP is zone redundant, no basic sku available

variable "PIPZones" {
  type    = list
  default = null
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
