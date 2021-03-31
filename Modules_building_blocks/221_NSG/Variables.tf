##############################################################
#This module allows the creation of a Netsork Security Group
##############################################################

#Variable declaration for Module

variable "NSGSuffix" {
  type                = string
  default             = ""
  description         = "A suffix to add at the end of the nsg name"

}

variable "RGName" {
  type                = string
  description         = "The name of the resource group in which the NSG lives"

}

variable "NSGLocation" {
  type                = string
  default             = "Westeurope"
  description         = "The region in which the resource lives"
}

variable "NICId" {
  type                = string
  default             = null 
  description         = "The Nic id associated to the nsg, default to null"

}

variable "SubnetId" {
  type                = string
  default             = null
  description         = "The Subnet id associated to the nsg, default to null"
}

###################################################################
#Tag related variables section

variable "ResourceOwnerTag" {
  type               = string
  description        = "Tag describing the owner"
  default            = "That would be me"
}

variable "CountryTag" {
  type                = string
  description         = "Tag describing the Country"
  default             = "fr"
}

variable "CostCenterTag" {
  type                = string
  description         = "Tag describing the Cost Center"
  default             = "labtf"
}

variable "EnvironmentTag" {
  type                = string
  description         = "The environment, dev, prod..."
  default             = "lab"
}

variable "Project" {
  type                = string
  description         = "The name of the project"
  default             = "tfmodule"
}