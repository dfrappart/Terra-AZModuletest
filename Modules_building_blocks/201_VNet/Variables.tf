##############################################################
#This module allows the creation of a VNet
##############################################################

#Variable declaration for Module

variable "VNetSuffix" {
  type                      = string
  default                   = ""
  description               = "A suffix added to the end of the vnet name. Changing this forces a new resource to be created."
}

variable "RGName" {
  type                      = string
  description               = "The name of the resource group in which to create the virtual network."
}

variable "VNetLocation" {
  type                      = string
  default                   = "westeurope"
  description               = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "VNetAddressSpace" {
  type                      = list
  default                   = ["10.0.0.0/20"]
  description               = "The address space that is used the virtual network. You can supply more than one address space."
}

variable "DNSServerList" {
  type                      = list
  default                   = null
  description               = "The List of IP addresses of DNS servers"
}

variable "IsVMProtectionEnabled" {
  type                      = string
  default                   = null
  description               = "Whether to enable VM protection for all the subnets in this Virtual Network. Defaults to false."
}

###################################################################
#Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type                      = string
  description               = "Application owner's e-mail address."
  default                   = "That would be me"
}

variable "CountryTag" {
  type                      = string
  description               = "Country name encoded on two letters. Possible values are FR, DE, US, HQ, etc."
  default                   = "fr"
}

variable "CostCenterTag" {
  type                      = string
  description               = "Project short string."
  default                   = "tflab" 
}

variable "Project" {
  type                      = string
  description               = "Project name."
  default                   = "tflab" 
}

variable "EnvironmentTag" {
  type                      = string
  description               = "Environment trigram. Possible values are DEV, UAT, PPD, PRD"
}

variable "ManagedByTag" {
  type                      = string
  description               = "Resource provisioner."
  default                   = "Terraform"
}
