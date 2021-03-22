##############################################################
#This module allows the creation of a storage container
##############################################################

#module variables

#The ST container

variable "StorageContainerName" {
  type                        = string
  default                     = data1
  description                 = "The name of the storage container"
}


#The Storage Account Name

variable "StorageAccountName" {
  type                        = string
  description                 = "The name of the storage account in which the container is created"
}

#The Storage Account container access type

variable "AccessType" {
  type                        = string
  default                     = "private"
  description                 = "Define the access of the container, default to private"
}

