##############################################################
#This module allows the creation of Route table
##############################################################

#Variable declaration for Module

#The Name of the route
variable "RouteTableName" {
  type = "string"
}

#The RG in which the route table is attached to
variable "RGName" {
  type = "string"
}

#The location of the route table
variable "RTLocation" {
  type = "string"
}

#Define if bgp route propagation is disable or not
variable "BGPDisabled" {
  type = "string"
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

