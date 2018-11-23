######################################################################
# This module creates an external load balancer
######################################################################


output "Name" {
    value = "${azurerm_lb_backend_address_pool.TerraLBBackEndPool.name}"
}

output "Id" {
    value = "${azurerm_lb_backend_address_pool.TerraLBBackEndPool.id}"
}