######################################################################
# This module creates an external load balancer
######################################################################



output "LBBackendPoolIds" {
  value = ["${azurerm_lb_backend_address_pool.TerraLBBackEndPool.*.id}"]
}

output "RGName" {
  value = "${var.RGName}"
}
