######################################################################
# This module creates an external load balancer
######################################################################

#Module variables

variable "IntLBName" {
  type = string
}

variable "AzureRegion" {
  type = string
}

variable "RGName" {
  type = string
}


variable "EnvironmentTag" {
  type = string
}

variable "EnvironmentUsageTag" {
  type = string
}

variable "OwnerTag" {
  type = string
  default = "Taht would be me"
}

variable "ProvisioningDateTag" {
  type = string
  default = "Today :)"
}

variable "LBSku" {
  type = string
  default = "standard"
}