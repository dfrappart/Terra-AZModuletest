######################################################################
# This module creates an external load balancer
######################################################################


output "TerraLBProbeName" {
    value = "${azurerm_lb_probe.TerraLBProbe.name}"
}

output "TerraLBProbeId" {
    value = "${azurerm_lb_probe.TerraLBProbe.id}"
}