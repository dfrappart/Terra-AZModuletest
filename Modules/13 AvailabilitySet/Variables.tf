##############################################################
#This module allows the creation of an availability set for VMs
##############################################################

#Variable declaration for Module

#The AS name
variable "ASName" {
  type = "string"
}

#The RG in which the AS is attached to
variable "RGName" {
  type = "string"
}

#The location in which the AS is attached to
variable "ASLocation" {
  type = "string"
}

variable "FaultDomainCount" {
  type    = "string"
  default = 3
}

#Tag value to help identify the resource. 
#Required tag are EnvironmentTAg defining the type of 
#environment and
#environment Tag usage specifying the use case of the environment

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

