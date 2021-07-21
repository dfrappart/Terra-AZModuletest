##############################################################
#This module creates an AKS Clulster with RBAC and Kubenet
##############################################################




##############################################################
# basic parameters

variable "AKSClusId" {
  type                          = string
  description                   = "The Id of the Cluster"
  default                       = "westeurope"
}

variable "AKSRGName" {
  type                          = string
  description                   = "The RG for for AKS"

}


variable "AKSClusName" {
  type                          = string
  description                   = "The name of the cluster"

}

######################################################
############### Monitoring Variable ##################
######################################################

variable "ACG1Id" {
  type        = string
  description = "Resource Id of the 1st action group"
}


######################################################
#Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type          = string
  description   = "Tag describing the owner"
  default       = "That would be me"
}

variable "CountryTag" {
  type          = string
  description   = "Tag describing the Country"
  default       = "fr"
}

variable "CostCenterTag" {
  type          = string
  description   = "Tag describing the Cost Center"
  default       = "lab"
}

variable "Company" {
  type          = string
  description   = "The Company owner of the resources"
  default       = "dfitc"
}

variable "Project" {
  type          = string
  description   = "The name of the project"
  default       = "tfmodule"
}

variable "Environment" {
  type          = string
  description   = "The environment, dev, prod..."
  default       = "dev"
}

variable "extra_tags" {
  type        = map
  description = "Additional optional tags."
  default     = {}
}