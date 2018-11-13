#Variable declaration for Module

#The Agent count
variable "AgentCount" {
  type    = "string"
  default = "1"
}

#The Agent Name
variable "AgentName" {
  type = "string"
}

#The Agent Location (Azure Region)
variable "AgentLocation" {
  type = "string"
}

#The RG in which the VM resides
variable "AgentRG" {
  type = "string"
}

#The VM Name
variable "VMName" {
  type = "list"
}

#Tag info

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

