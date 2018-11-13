##############################################################
#This module allows the creation of an automation account
##############################################################

#Variable declaration for Module

#The Name of the automation account
variable "AutomationAccountName" {
  type = "string"
}

#The RG in which the automation account is attached to 
variable "RGName" {
  type = "string"
}

#The location of the route table
variable "AutomationAccountLocation" {
  type = "string"
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

