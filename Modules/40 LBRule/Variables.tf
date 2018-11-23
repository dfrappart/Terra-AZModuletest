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
  default = "80"
}

variable "FERuleBEPort" {
  type = "string"
  default = "8001"
}

variable "FERuleProtocol" {
  type = "string"
  default = "tcp"
}

variable "FEConfigName" {
  type = "string"

}