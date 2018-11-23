######################################################################
# This module creates an external load balancer
######################################################################


output "TerraLBRuleName" {
    value = "${azurerm_lb_rule.TerraLBProbe.name}"
}

output "TerraLBRuleId" {
    value = "${azurerm_lb_rule.TerraLBProbe.id}"
}