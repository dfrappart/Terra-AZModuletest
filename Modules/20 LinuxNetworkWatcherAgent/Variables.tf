###################################################################################
#This module allows the creation of a Network Watcher Agent
###################################################################################

#Variable declaration for Module

variable "AgentCount" {
  type    = "string"
  default = "1"
}

variable "AgentName" {
  type = "string"
}

variable "AgentLocation" {
  type = "string"
}

variable "AgentRG" {
  type = "string"
}

variable "VMName" {
  type = "list"
}

variable "EnvironmentTag" {
  type = "string"
}

variable "EnvironmentUsageTag" {
  type = "string"
}
