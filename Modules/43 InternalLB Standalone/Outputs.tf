######################################################################
# This module creates an external load balancer
######################################################################


output "Name" {
    value = azurerm_lb.TerraIntLB.name
}

output "Id" {
    value = azurerm_lb.TerraIntLB.id
}