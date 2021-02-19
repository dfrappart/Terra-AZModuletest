##############################################################
#This module allows the creation of a storage account
##############################################################

#module variables

#The LGA Name

variable "LGASuffix" {
  type                                  = string
  description                           = "a suffix to add at the end of the Logic app name"            
}

#The RG Name

variable "RGName" {
  type                                  = string
  description                           = "The name of the resource group in which to create the resources. Changing this forces a new resource to be created."
}

#The Storage Account Location

variable "LGALocation" {
  type                                  = string
  description                           = "Specifies the supported Azure location where the Logic App Workflow exists. Changing this forces a new resource to be created."
}

#The Storage Account Tier

variable "LGAISEId" {
  type                                  = string
  default                               = null
  description                           = "The ID of the Integration Service Environment to which this Logic App Workflow belongs. Changing this forces a new Logic App Workflow to be created."
}

#The Storage Account Replication Type, accept LRS, GRS, RAGRS and ZRS.

variable "LGAIAId" {
  type                                  = string
  default                               = null
  description                           = "The ID of the integration account linked by this Logic App Workflow."
}


#The Storage Account kind

variable "LGASchema" {
  type                                  = string
  default                               = null
  description                           = "Specifies the Schema to use for this Logic App Workflow. Defaults to https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#. Changing this forces a new resource to be created."

}

#The Storage Account access tier

variable "LGAWorkflowVersion" {
  type                                  = string
  default                               = null
  description                           = "Specifies the version of the Schema used for this Logic App Workflow. Defaults to 1.0.0.0. Changing this forces a new resource to be created."
}

#The Storage Account access tier

variable "LGAParam" {
  type                                  = map
  default                               = null
  description                           = "A map of Key-Value pairs."
}


###################################################################
#Tag related variables section

variable "ResourceOwnerTag" {
  type                                  = string
  description                           = "Tag describing the owner"
  default                               = "That would be me"
}

variable "CountryTag" {
  type                                  = string
  description                           = "Tag describing the Country"
  default                               = "fr"
}

variable "CostCenterTag" {
  type                                  = string
  description                           = "Tag describing the Cost Center"
  default                               = "labtf"
}

variable "EnvironmentTag" {
  type                                  = string
  description                           = "The environment, dev, prod..."
  default                               = "lab"
}

variable "Project" {
  type                                  = string
  description                           = "The project name"
  default                               = "tfmodule"
}
