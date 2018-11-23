######################################################################
# This module creates an external load balancer
######################################################################


output "Name" {
    value = "${azurerm_lb.TerraExtLB.name}"
}

output "Id" {
    value = "${azurerm_lb.TerraExtLB.id}"
}