##############################################################
#This module allows the creation of a Network Security 
#Group Rule with source and destination ASG
##############################################################


# Module output

output "Name" {
  value = "${azurerm_network_security_rule.Terra-NSGRulewSRCandDestASG.name}"
}

output "Id" {
  value = "${azurerm_network_security_rule.Terra-NSGRulewSRCandDestASG.id}"
}
