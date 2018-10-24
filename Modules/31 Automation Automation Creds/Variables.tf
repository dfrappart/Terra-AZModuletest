##############################################################
#This module allows the creation of an automation account
##############################################################

#Variable declaration for Module

#The Name of the automation creds
variable "AutomationCredsName" {
  type = "string"
}

#The RG in which the automation account is attached to 
variable "RGName" {
  type = "string"
}

#The name of the associated automation account
variable "AutomationAccountName" {
  type = "string"
}

#The username in the creds
variable "AutoCredsUserName" {
  type = "string"
}

#the password in the creds

variable "AutoCredsPwd" {
  type = "string"
}

#the description

variable "AutoCredsDescription" {
  type = "string"
  default = "Terra Created Automation credentials"
}
