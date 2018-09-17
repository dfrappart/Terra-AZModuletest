##############################################################
#This module allows the creation of VMs NICs with Public IP
##############################################################

#Variables for NIC creation

#The NIC count
variable "NICCount" {
  type    = "string"
  default = "1"
}

#The NIC name
variable "NICName" {
  type = "string"
}

#The NIC location
variable "NICLocation" {
  type = "string"
}

#The resource Group in which the NIC are attached to
variable "RGName" {
  type = "string"
}

#The subnet reference
variable "SubnetId" {
  type = "string"
}

#The public IP Reference

variable "PublicIPId" {
  type = "list"
}

variable "Primary" {
  type    = "string"
  default = "true"
}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

