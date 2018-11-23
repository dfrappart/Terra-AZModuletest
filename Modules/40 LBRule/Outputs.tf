######################################################################
# This module creates an external load balancer
######################################################################


output "Name" {
    value = "${azurerm_lb_rule.TerraLBProbe.name}"
}

output "Id" {
    value = "${azurerm_lb_rule.TerraLBProbe.id}"
}