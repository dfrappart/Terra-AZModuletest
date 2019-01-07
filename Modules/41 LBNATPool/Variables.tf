######################################################################
# This module creates an external load balancer be
######################################################################

#Module variables


variable "NATPoolName" {
  type = "string"
}


variable "RGName" {
  type = "string"
}

variable "LBId" {
  type = "string"
}



variable "NATPoolFEPortStart" {
  type = "string"

}

variable "NATPoolFEEnd" {
  type = "string"

}

variable "NATPoolBEPort" {
  type = "string"

}

variable "NATPoolProtocol" {
  type = "string"
  default = "tcp"
}

variable "FEConfigName" {
  type = "string"

}