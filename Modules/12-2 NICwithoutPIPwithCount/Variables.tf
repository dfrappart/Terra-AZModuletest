##############################################################
#This module allows the creation of VMs NICs without Public IP
##############################################################

#Variables for NIC creation

#The count value
variable "NICcount" {
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

#Behind a lb
variable "IsLoadBalanced" {
  type    = "string"
  default = "0"
}

#BackendPool id

variable "LBBackEndPoolid" {
  type    = "list"
  default = ["defaultPool1", "defaultPool1"]
}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

