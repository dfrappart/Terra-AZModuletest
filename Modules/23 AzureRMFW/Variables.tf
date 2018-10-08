##############################################################
#This module allows the creation of Route table
##############################################################

#Variable declaration for Module

#The Name of the FW
variable "FWName" {
  type = "string"
}

#The RG in which the route table is attached to
variable "RGName" {
  type = "string"
}

#The location of the FW
variable "FWLocation" {
  type = "string"
}

#The name of the ip config fo rthe Azure Firewall
variable "FWIPConfigName" {
  type = "string"
  default = "Config"
}

#The id of the subnet on which the FW is located
variable "FWSubnetId" {
  type = "string"
}

#The id of the subnet on which the FW is located
variable "FWPIPId" {
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

