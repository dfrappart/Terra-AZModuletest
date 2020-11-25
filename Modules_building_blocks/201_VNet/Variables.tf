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

###################################################################
#Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type        = string
  description = "Application owner's e-mail address."
}

variable "CountryTag" {
  type        = string
  description = "Country name encoded on two letters. Possible values are FR, DE, US, HQ, etc."
}

variable "CostCenterTag" {
  type        = string
  description = "Project trigram." 
}

variable "EnvironmentTag" {
  type        = string
  description = "Environment trigram. Possible values are DEV, UAT, PPD, PRD"
}

variable "ManagedByTag" {
  type        = string
  description = "Resource provisioner."
  default     = "Terraform"
}
