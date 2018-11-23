######################################################################
# This module creates an external load balancer be
######################################################################


# Creating Azure Load Balancer BE Pool

resource "azurerm_lb_backend_address_pool" "TerraLBBackEndPool" {
  name                = "${var.LBBackEndPoolName}"
  resource_group_name = "${var.RGName}"
  loadbalancer_id     = "${var.LBId}"
}