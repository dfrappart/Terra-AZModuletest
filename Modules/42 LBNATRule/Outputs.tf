######################################################################
# This module creates an external load balancer
######################################################################


output "Name" {
    value = "${azurerm_lb_nat_rule.TerraLBNATrule.name}"
}

output "Id" {
    value = "${azurerm_lb_nat_rule.TerraLBNATrule.id}"
}