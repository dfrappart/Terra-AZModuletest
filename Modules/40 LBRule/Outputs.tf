######################################################################
# This module creates an external load balancer
######################################################################


output "Name" {
    value = "${azurerm_lb_rule.TerraLBFrondEndrule.name}"
}

output "Id" {
    value = "${azurerm_lb_rule.TerraLBFrondEndrule.id}"
}