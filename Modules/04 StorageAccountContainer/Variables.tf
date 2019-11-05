##############################################################
#This module allows the creation of a storage container
##############################################################

#module variables

#The ST container

variable "StorageContainerName" {
  type = string
}

#The RG Name

variable "RGName" {
  type = string
}

#The Storage Account Name

variable "StorageAccountName" {
  type = string
}

#The Storage Account container access type

variable "AccessType" {
  type    = string
  default = "private"
}

