######################################################################
# This module create a User Assign resource
######################################################################

#Variable declaration for Module

variable "UAISuffix" {
  type                  = string
  default               = "1"
  description           = "A suffix added to the UAI name" 
}

variable "TargetLocation" {
  type                  = string
  default               = "westeurope"
  description           = "The Azure region for the resource"
}

variable "TargetRG" {
  type                  = string
  description           = "The resource group in which the resources will be deployed"
}

###################################################################
#Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type                  = string
  description           = "Tag describing the owner"
  default               = "That would be me"
}

variable "CountryTag" {
  type                  = string
  description           = "Tag describing the Country"
  default               = "fr"
}

variable "CostCenterTag" {
  type                  = string
  description           = "Tag describing the Cost Center"
  default               = "tflab"
}

variable "Company" {
  type                  = string
  description           = "The Company owner of the resources"
  default               = "dfitc"
}

variable "Project" {
  type                  = string
  description           = "The name of the project"
  default               = "tfmodule"
}

variable "Environment" {
  type                  = string
  description           = "The environment, dev, prod..."
  default               = "lab"
}