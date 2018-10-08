##############################################################
#This module allows the creation of FW collection rules
##############################################################

#Variable declaration for Module

#The Name of the rule collection
variable "FWRuleCollecName" {
  type = "string"
}

#The RG in which the rule collection is attached to
variable "RGName" {
  type = "string"
}

#The FW in which to attach the rule collection
variable "FWName" {
  type = "string"
}

variable "FWRuleCollecPriority" {
  type = "string"
  default = 100
}

variable "FWRuleCollecAction" {
  type = "string"
  default = "Allow"
}


#The rule Name

variable "FWRuleName" {
  type = "string"
}


#The rule description
variable "FWRuleDesc" {
  type = "string"
}


#The rule sources addresses
variable "FWRuleCollecSourceAddresses" {
  type = "list"
}

#The rule destination ports
variable "FWRuleCollecDestPorts" {
  type = "list"
}

#The rule destination Addresses
variable "FWRuleCollecDestAddresses" {
  type = "list"
}

#The rule protos
variable "FWRuleProtos" {
  type = "list"
  default = ["TCP","UDP"]
}



