##############################################################
#This module allows the creation of Route 
##############################################################



#Output

output "Name" {
  value = azurerm_route.TerraRoute.name
}

output "Id" {
  value = azurerm_route.TerraRoute.id
}

output "RGName" {
  value = azurerm_route.TerraRoute.resource_group_name
}
