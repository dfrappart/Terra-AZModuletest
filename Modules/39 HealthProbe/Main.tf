######################################################################
# This module creates an external load balancer health probe
######################################################################


# Creating Health Probe

resource "azurerm_lb_probe" "TerraLBProbe" {
  name                = "${var.LBProbeName}"
  resource_group_name = "${var.RGName}"
  loadbalancer_id     = "${var.LBId}"
  port                = "${var.LBProbePort}"
}
