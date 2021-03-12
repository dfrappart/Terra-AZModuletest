##############################################################
#This module allows the creation of a NEtwork Watcher
##############################################################

#Variable declaration for Module


variable "IsDeploymentTypeGreenField" {
  type                        = string
  default                     = true
  description                 = "Describe the type of deployment, can be GreenField or not. If GreenField, means that the subscription setup is not applied on a newly created subscription."


}

#The RG in which the AS is attached to
variable "NWRGRole" {
  type    = string
  default = "networkwatcher"

}

#The location in which the AS is attached to
variable "NWLocationsList" {
  type    = list
  default = [
    "francecentral",
    "westeurope",
    "northeurope",
    "eastasia",
    "southeastasia",
    "centralus",
    "eastus",
    "eastus2",
    "westus",
    "northcentralus",
    "southcentralus",
    "japanwest",
    "japaneast",
    "brazilsouth",
    "australiaeast",
    "australiasoutheast",
    "southindia",
    "centralindia",
    "westindia",
    "canadacentral",
    "canadaeast",
    "uksouth",
    "ukwest",
    "westcentralus",
    "westus2",
    "koreacentral",
    "koreasouth",
    "australiacentral",
    "uaenorth",
    "southafricanorth"

  ]

}

variable "ASCPricingTier" {
  type          = string
  description   = "The Azure Security Center Pricing Tiers, can be Free or Standard"
  default       = "Free"
}

variable "ASCContactMail" {
  type          = string
  description   = "The Azure Security Center Pricing Tiers, can be Free or Standard"
  default       = "Free"
}

variable "notifySecContact" {
  type          = string
  description   = "Are the Security Contact notified by ASC ? Defualt to True"
  default       = true
}

variable "notifySubAdmins" {
  type          = string
  description   = "Are the Subscription Admins notified by ASC ? Defualt to True"
  default       = true
}

variable "LawId" {
  type          = string
  description   = "The Log Analytics Id, used to specify the LAW Workspace for ASC"

}

variable "Subid" {
  type          = string
  description   = "The Subscription Id"

}

variable "RGLogs" {
  type          = string
  description   = "The resource group targeted for the the observability resources"

}

variable "SubContactList" {
  type          = string
  description   = "The contactlist email address for the alerting"
  default       = "david@teknews.cloud"

}

#Tag value to help identify the resource. 
#Required tag are EnvironmentTAg defining the type of 
#environment and
#environment Tag usage specifying the use case of the environment

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
  default       = ""
}

variable "Project" {
  type          = string
  description   = "The name of the project"
  default       = "tfsubsetup"
}

variable "Environment" {
  type          = string
  description   = "The environment, dev, prod..."
  default       = "lab"
}
