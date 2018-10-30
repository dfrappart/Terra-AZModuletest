#################################################################
#This module allows the creation of logic app workflow 
#################################################################

#Variable declaration for Module

#The Name of the automation DSC Config
variable "LogicAppName" {
  type = "string"
}

#The RG in which the automation DSC Config is attached to 
variable "RGName" {
  type = "string"
}


#The location
variable "Location" {
  type = "string"
}


variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

