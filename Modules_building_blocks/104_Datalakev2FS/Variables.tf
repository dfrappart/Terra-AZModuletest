##############################################################
#This module allows the creation of a storage account
##############################################################

#module variables

#The ST Name

variable "DatalakeFSName" {
  type                                  = string
  description                           = "The name of the Data Lake Gen2 File System which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created."            
}

#The RG Name

variable "STAId" {
  type                                  = string
  description                           = "Specifies the ID of the Storage Account in which the Data Lake Gen2 File System should exist. Changing this forces a new resource to be created."
}

