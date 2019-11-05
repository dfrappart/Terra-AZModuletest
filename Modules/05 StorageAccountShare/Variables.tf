####################################################################
#This module allows the creation of a storage sharefile (Azure File)
####################################################################

#module variables

#The Azure File Name

variable "ShareName" {
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

#The Azure File Quota

variable "Quota" {
  type    = string
  default = "5120"
}



