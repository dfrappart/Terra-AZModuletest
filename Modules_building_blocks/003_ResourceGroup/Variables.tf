##############################################################
#This module allows the creation of a RG
##############################################################


#Variable declaration for Module



variable "RGSuffix" {
  type              = string
  default           = "-1"
}


variable "RGLocation" {
  type              = string
  default           = "westeurope"
}


###################################################################
#Tag related variables and naming convention section

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
  default             = "rxldefaultcostcenter"
}

variable "EnvironmentTag" {
  type                = string
  description         = "The environment, dev, prod..."
  default             = "dev"
}