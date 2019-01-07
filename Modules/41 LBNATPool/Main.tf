######################################################################
# This module creates an external load balancer NAT Pool
######################################################################


# Creating Load Balancer rules

resource "azurerm_lb_nat_pool" "TerraLBNATPool" {
  name                           = "${var.NATPoolName}"
  resource_group_name            = "${var.RGName}"
  loadbalancer_id                = "${var.LBId}"
  protocol                       = "${var.NATPoolProtocol}"
  frontend_port_start            = "${var.NATPoolFEPortStart}"
  frontend_port_end              = "${var.NATPoolFEEnd}"
  frontend_ip_configuration_name = "${var.FEConfigName}"
  backend_port                   = "${var.NATPoolBEPort}"

}

