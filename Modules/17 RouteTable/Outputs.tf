##############################################################
#This module allows the creation of Route table
##############################################################


#Output

output "Name" {
  value = "${azurerm_route_table.TerraRouteTable.name}"
}

output "Id" {
  value = "${azurerm_route_table.TerraRouteTable.id}"
}

output "RGName" {
  value = "${azurerm_route_table.TerraRouteTable.resource_group_name}"
}

output "Subnet" {
  value = "${azurerm_route_table.TerraRouteTable.subnets}"
}
