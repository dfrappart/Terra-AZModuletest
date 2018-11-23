######################################################################
# This module creates an external load balancer be
######################################################################

#Module variables


variable "FERuleName" {
  type = "string"
}


variable "RGName" {
  type = "string"
}

variable "LBId" {
  type = "string"
}

variable "LBProbId" {
  type = "string"
}



variable "FERuleFEPort" {
  type = "string"
}

variable "FERuleBEPort" {
  type = "string"
}

variable "FERuleProtocol" {
  type = "string"
  default = "tcp"
}