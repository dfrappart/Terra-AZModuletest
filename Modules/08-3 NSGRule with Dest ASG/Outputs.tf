##############################################################
#This module allows the creation of a Network Security 
#Group Rule with source service tags and dest ASG
##############################################################


# Module output

output "Name" {
  value = "${azurerm_network_security_rule.Terra-NSGRulewDestASG.name}"
}

output "Id" {
  value = "${azurerm_network_security_rule.Terra-NSGRulewDestASG.id}"
}
