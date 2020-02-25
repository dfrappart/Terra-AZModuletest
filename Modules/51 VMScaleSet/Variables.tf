######################################################################
# # This module creates an external load balancer health probe
######################################################################

#Module variables



variable "ExtLBName" {
  type = string
}

variable "AzureRegion" {
  type = string
}

variable "RGName" {
  type = string
}

variable "FEConfigName" {
  type = string
}

variable "PublicIPId" {
  type = string
}

variable "LBBackEndPoolName" {
  type = string
}

variable "LBProbeName" {
  type = string
}

variable "LBProbePort" {
  type = string
}

variable "FERuleName" {
  type = string
}

variable "FERuleProtocol" {
  type = string
}

variable "FERuleFEPort" {
  type = string
}

variable "FERuleBEPort" {
  type = string
}

variable "EnvironmentTag" {
  type    = string
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = string
  default = "Poc usage only"
}

variable "OwnerTag" {
  type    = string
  default = "That would be me"
}

variable "ProvisioningDateTag" {
  type    = string
  default = "Today :)"
}


variable "LBSku" {
  type    = string
  default = "standard"
}