######################################################################
# This module creates an external load balancer
######################################################################


output "Name" {
    value = "${azurerm_lb_nat_pool.TerraLBNATPool.name}"
}

output "Id" {
    value = "${azurerm_lb_nat_pool.TerraLBNATPool.id}"
}