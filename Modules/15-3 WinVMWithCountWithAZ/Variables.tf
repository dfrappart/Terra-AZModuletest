###################################################################################
#This module allows the creation of 1 Windows VM with 1 NIC
###################################################################################

#Variable declaration for Module

#The VM count
variable "VMCount" {
  type    = "string"
  default = "1"
}

#The VM name
variable "VMName" {
  type = "string"
}

#The VM location
variable "VMLocation" {
  type = "string"
}

#The RG in which the VMs are located
variable "VMRG" {
  type = "string"
}

#The NIC to associate to the VM
variable "VMNICid" {
  type = "list"
}

#The VM size
variable "VMSize" {
  type    = "string"
  default = "Standard_F1"
}

#The Target AZ for the VM
variable "VMAZ" {
  type = "string"
  default = "1"
}

variable "AZ" {
  type = "list"
  default = ["1","2","3","1","2","3","1","2","3","1","2","3"]
}

#The Managed Disk Storage tier

variable "VMStorageTier" {
  type    = "string"
  default = "Premium_LRS"
}

#The VM Admin Name

variable "VMAdminName" {
  type    = "string"
  default = "VMAdmin"
}

#The VM Admin Password

variable "VMAdminPassword" {
  type = "string"
}

#The OS Disk Size

variable "OSDisksize" {
  type    = "string"
  default = "128"
}

# Managed Data Disk reference

variable "DataDiskId" {
  type = "list"
  default = ["256"]
}

# Managed Data Disk Name

variable "DataDiskName" {
  type = "list"
  default = ["NoDatadisk"]
}

# Managed Data Disk size

variable "DataDiskSize" {
  type = "list"
  default = ["NoDatadisk"]
}

# VM images info
#get appropriate image info with the following command
#Get-AzureRMVMImagePublisher -location WestEurope
#Get-AzureRMVMImageOffer -location WestEurope -PublisherName <PublisherName>
#Get-AzureRmVMImageSku -Location westeurope -Offer <OfferName> -PublisherName <PublisherName>

variable "VMPublisherName" {
  type = "string"
  default = "microsoftwindowsserver"
}

variable "VMOffer" {
  type = "string"
  default = "WindowsServer"
}

variable "VMsku" {
  type = "string"
  default = "2016-Datacenter"
}

#The boot diagnostic storage uri

variable "DiagnosticDiskURI" {
  type = "string"
}

#Tag info

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

variable "CloudinitscriptPath" {
  type = "string"
}

variable "VMTypeTag" {
  type = "string"
  default = "Base"
}

variable "VMOSTag" {
  type = "string"
  default = "Win2016"
}


variable "OwnerTag" {
  type = "string"
  default = "david@teknews.cloud"
}

variable "ProvisioningDateTag" {
  type = "string"
  default = "Today :)"
}

variable "SLAUptimeTag" {
  type = "string"
  #Can be 5712, 5724, 7724
  default = "5712"
}

variable "WithDataDisk" {
  type = "string"
  default = "1"
}