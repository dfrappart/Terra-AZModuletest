######################################################################
# This module creates an external load balancer
######################################################################


output "TerraLBBackEndPoolName" {
    value = "${azurerm_lb_backend_address_pool.TerraLBBackEndPool.name}"
}

output "TerraLBBackEndPoolId" {
    value = "${azurerm_lb_backend_address_pool.TerraLBBackEndPool.id}"
}