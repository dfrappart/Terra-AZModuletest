##############################################################
#This module allows the creation of a storage account
##############################################################

#module variables

#The ST Name

variable "StorageAccountName" {
  type = "string"
}

#The RG Name

variable "RGName" {
  type = "string"
}

#The Storage Account Location

variable "StorageAccountLocation" {
  type = "string"
}

#The Storage Account Tier

variable "StorageAccountTier" {
  type    = "string"
  default = "Standard"
}

#The Storage Account Replication Type, accept LRS, GRS, RAGRS and ZRS.

variable "StorageReplicationType" {
  type    = "string"
  default = "LRS"
}

#Varaibles defining Tags

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

