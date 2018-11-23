######################################################################
# This module creates an external load balancer be
######################################################################

#Module variables


variable "LBProbeName" {
  type = "string"
}


variable "RGName" {
  type = "string"
}

variable "LBId" {
  type = "string"
}

variable "LBProbePort" {
  type = "string"
}
