##############################################################
#This module allows the creation of Route 
##############################################################

#Variable declaration for Module

#The Name of the route
variable "RouteName" {
  type = string
}

#The RG in which the route table is attached to
variable "RGName" {
  type = string
}

#The route table name with which the route is associated to
variable "RTName" {
  type = string
}

#The destination CIDR to which the route applies
variable "DestinationCIDR" {
  type = string
}

#The type of Azure hop the packet should be sent to. 
#Possible values are VirtualNetworkGateway, VnetLocal, 
#Internet, VirtualAppliance and None
variable "NextHop" {
  type = string
}

#Contains the IP address packets should be forwarded to.
#Next hop values are only allowed in routes where the 
#next hop type is VirtualAppliance.
variable "NextHopinIPAddress" {
  type = string
}

