##############################################################
#This module allows the creation of an automation DSC Config
##############################################################

#Variable declaration for Module

#The Name of the automation DSC Config
variable "AutomationDSCConfigName" {
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

#the description

variable "AutomationDSCConfigDescription" {
  type = "string"
  default = "Terra Created Automation DSC Config"
}

#the description

variable "LogverboseEnabledStatus" {
  type = "string"
  default = "true"
}
