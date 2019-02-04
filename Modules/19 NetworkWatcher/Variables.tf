##############################################################
#This module allows the creation of a NEtwork Watcher
##############################################################

#Variable declaration for Module

#The NW name
variable "NWName" {
  type    = "string"

}

#The RG in which the AS is attached to
variable "RGName" {
  type    = "string"

}

#The location in which the AS is attached to
variable "NWLocation" {
  type    = "string"

}




#Tag value to help identify the resource. 
#Required tag are EnvironmentTAg defining the type of 
#environment and
#environment Tag usage specifying the use case of the environment

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

variable "OwnerTag" {
  type    = "string"
  default = "That would be me"
}

variable "ProvisioningDateTag" {
  type    = "string"
  default = "Today :)"
}



