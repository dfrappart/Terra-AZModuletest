######################################################################
# This module creates an external load balancer be
######################################################################

#Module variables


variable "NATRuleName" {
  type = "string"
}


variable "RGName" {
  type = "string"
}

variable "LBId" {
  type = "string"
}



variable "NATRuleFEPort" {
  type = "string"
  default = "22001"
}

variable "NATRuleBEPort" {
  type = "string"
  default = "22"
}

variable "NATRuleProtocol" {
  type = "string"
  default = "tcp"
}

variable "FEConfigName" {
  type = "string"

}