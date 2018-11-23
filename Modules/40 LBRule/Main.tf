######################################################################
# This module creates an external load balancer Rule
######################################################################


# Creating Load Balancer rules

resource "azurerm_lb_rule" "TerraLBFrondEndrule" {
  name                           = "${var.FERuleName}"
  resource_group_name            = "${var.RGName}"
  loadbalancer_id                = "${var.LBIdList}"
  protocol                       = "${var.FERuleProtocol}"
  probe_id                       = "${var.LBProbIdList}"
  frontend_port                  = "${var.FERuleFEPort}"
  frontend_ip_configuration_name = "${var.FEConfigName}"
  backend_port                   = "${var.FERuleBEPort}"
  backend_address_pool_id        = "${var.BEPoolId}"
}