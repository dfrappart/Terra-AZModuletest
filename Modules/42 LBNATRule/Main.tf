######################################################################
# This module creates an Load Balancer NAT Pool
######################################################################


# Creating Load Balancer NAT Pool

resource "azurerm_lb_nat_rule" "TerraLBNATrule" {
  name                           = "${var.NATRuleName}"
  resource_group_name            = "${var.RGName}"
  loadbalancer_id                = "${var.LBId}"
  protocol                       = "${var.NATRuleProtocol}"
  frontend_port                  = "${var.NATRuleFEPort}"
  frontend_ip_configuration_name = "${var.FEConfigName}"
  backend_port                   = "${var.NATRuleBEPort}"

}

