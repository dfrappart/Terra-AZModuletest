#################################################################
#This module allows the creation of an automation DSC Config node
#################################################################

#Variable declaration for Module

#The Name of the automation DSC Config
variable "AutomationRunbookName" {
  type = "string"
}

#The location
variable "Location" {
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

#Verbose log activation value, default to true
variable "LogVerboseActivated" {
  type    = "string"
  default = "true"
}

#Progress log activation value, default to true
variable "LogProgressActivated" {
  type    = "string"
  default = "true"
}

#Runbook Type
variable "RunbookType" {
  type    = "string"
  default = "PowerShell"
}
#Runbook description
variable "RunbookDesc" {
  type    = "string"
  default = "Terra Created Runbok"
}
#The file path for the runbook
variable "SettingsFilePath" {
  type = "string"
}


