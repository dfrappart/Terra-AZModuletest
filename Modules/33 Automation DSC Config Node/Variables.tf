#################################################################
#This module allows the creation of an automation DSC Config node
#################################################################

#Variable declaration for Module

#The Name of the automation DSC Config
variable "AutomationDSCConfigNodeName" {
  type = "string"
}

#The RG in which the automation DSC Config is attached to 
variable "RGName" {
  type = "string"
}

#The name of the associated automation account
variable "AutomationAccountName" {
  type = "string"
}

#The location
variable "Location" {
  type = "string"
}

#The template path for the embedded content
variable "SettingsTemplatePath" {
  type = "string"
}


