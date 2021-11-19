###################################################################
#This module creates the basic resources for logging and monitoring
###################################################################

###################################################################
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
  default       = "tflab"
}



variable "Company" {
  type          = string
  description   = "The Company owner of the resources"
  default       = "dfitc"
}

variable "Project" {
  type          = string
  description   = "The name of the project"
  default       = "tflab"
}

variable "Environment" {
  type          = string
  description   = "The environment, dev, prod..."
  default       = "lab"
}


###################################################################
#Module resoures variables

variable "RGLogLocation" {
  type          = string
  description   = "Variable defining the region for the log resources"
  default       = "westeurope"
}

variable "SubLogSuffix" {
  type          = string
  description   = "Suffix to add to the resources, by default, log"
  default       = "log"
}

#The Storage TLS Version

variable "TLSVer" {
  type                                  = string
  default                               = "TLS1_2"
  description                           = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2."
}

variable "LAWSku" {
  type          = string
  description   = "SKu for Log analytics, PerGB2018"
  default       = "PerGB2018"
}

variable "LAWRetention" {
  type          = string
  description   = "Retention in days for the log analytics workspace, default to 30 days"
  default       = "30"
}

variable "SubId" {
  type          = string
  description   = "The subscription id, to confiugure the diag logs"

}