##############################################################
#This module allow the creation of a Route 
#associated with a route table
##############################################################

#Variable declaration for Module

#The route name
variable "RouteName" {
  type    = "string"
  default = "CustomRoute"
}

#The RG in which the route is located
variable "RGName" {
  type    = "string"
  default = "DefaultRSG"
}

#The subnet address prefix which the route applies to
variable "SubnetAddressPrefix" {
  type    = "string"

}

#The next hop type, accepted values are 
#VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None
variable "NextHopType" {
  type    = "string"
  default = "virtualappliance"
}

#The address of the virtual appliance
variable "NextHopIPAddress" {
  type    = "string"

}

#The name of the route table in which the route is defined
variable "RouteTableName" {
  type    = "string"

}



#Creating a Route Table

resource "azurerm_route" "Terra-route" {

    name                        = "${var.RouteName}"
    resource_group_name         = "${var.RGName}"
    route_table_name            = "${var.RouteTableLocation}"
    address_prefix              = "${var.AddressPrefix}"
    next_hop_type               = "${var.NextHopType}"
    next_hop_in_ip_address      = "${var.NextHopIPAddress}"

}


#Output for the Route module

output "Name" {

  value = "${azurerm_route.Terra-route.name}"
}

output "Id" {

  value = "${azurerm_route.Terra-route.id}"
}