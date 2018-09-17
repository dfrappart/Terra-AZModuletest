##############################################################
#This module allows the creation of a Netsork Security Group Rule
##############################################################

#Variable declaration for Module

# The NSG rule requires a RG location in which the NSG for which the rule is created is located
variable "RGName" {
  type    = "string"
  default = "DefaultRSG"
}

#The NSG rule requires a reference to a NSG 
variable "NSGReference" {
  type = "string"
}

#The NSG Rule Name, a string value allowing to identify the rule after deployment
variable "NSGRuleName" {
  type    = "string"
  default = "DefaultNSGRule"
}

#The NSG rule priority is an integer value defining the priority in which the rule is applyed in the NSG 
variable "NSGRulePriority" {
  type = "string"
}

#The NSG rule direction define if the rule is for ingress or egress trafic. Allowed value are inbound and outbound 
variable "NSGRuleDirection" {
  type = "string"
}

#The NSG Rule Access value,  a string value defining if the rule allow or block the specified traffic. Accepted value are Allow or Block
variable "NSGRuleAccess" {
  type    = "string"
  default = "Allow"
}

#The NSG rule protocol define which type of trafic to allow/block. It accept the string tcp, udp, icmp or *
variable "NSGRuleProtocol" {
  type = "string"
}

#The NSG rule source port range define the port(s) from which the trafic origing is allowed/blocked
variable "NSGRuleSourcePortRange" {
  type    = "string"
  default = "*"
}

#The NSG rule destination port range define the port(s) on which the trafic destination is allowed/blocked
variable "NSGRuleDestinationPortRange" {
  type = "string"
}

#The NSG rule address preifx defines the source address(es) from whichthe trafic origin is allowed/blocked
variable "NSGRuleSourceAddressPrefix" {
  type = "string"
}

#The NSG rule address preifx defines the source address(es) from whichthe trafic origin is allowed/blocked
variable "NSGRuleDestinationAddressPrefix" {
  type = "string"
}

