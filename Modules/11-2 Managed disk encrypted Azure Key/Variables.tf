###################################################################
#This module allows the creation of a Managed disk with count option
###################################################################

#Variable declaration for Module

#The count value
variable "Manageddiskcount" {
  type    = "string"
  default = "1"
}

#The Managed Disk name
variable "ManageddiskName" {
  type = "string"
}

#The RG in which the MD is attached to
variable "RGName" {
  type = "string"
}

#The location in which the MD is attached to
variable "ManagedDiskLocation" {
  type = "string"
}

#The underlying Storage account type. Value accepted are Standard_LRS and Premium_LRS
variable "StorageAccountType" {
  type = "string"
}

#The create option. Value accepted
#Import - Import a VHD file in to the managed disk (VHD specified with source_uri).
#Empty - Create an empty managed disk.
#Copy - Copy an existing managed disk or snapshot (specified with source_resource_id). 

variable "CreateOption" {
  type = "string"
}

# Specifies the size of the managed disk to create in gigabytes. 
#If create_option is Copy, then the value must be equal 
#to or greater than the source's size.
#Take also into account the pricing related to the size:
#129 GB equal 512 Provisioned so prefer 
#corresponding value to storage tiers desired

variable "KeyURI" {
  type = "string"
  default = "https://dfkeyvaulttest01.vault.azure.net/keys/Diskkeytest/136fd88d68e44c86a2ea7b97e0933140"
}

variable "KeyVaultId" {
  type = "string"
  default = "/subscriptions/f1f020d0-0fa6-4d01-b816-5ec60497e851/resourceGroups/RG-KeyVaultTest/providers/Microsoft.KeyVault/vaults/dfkeyvaulttest01"
  
}

variable "DiskSecreturi" {
  type = "string"
  default = "https://dfkeyvaulttest01.vault.azure.net/secrets/DiskSecret/e4ed7648ab8e469da7471556d6e1f41b"
}


variable "DiskSizeInGB" {
  type = "string"
}
variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

