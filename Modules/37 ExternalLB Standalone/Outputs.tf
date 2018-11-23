######################################################################
# This module creates an external load balancer
######################################################################


output "TerraExtLBName" {
    value = "${azurerm_lb.TerraExtLB.name}"
}

output "TerraExtLBId" {
    value = "${azurerm_lb.TerraExtLB.id}"
}