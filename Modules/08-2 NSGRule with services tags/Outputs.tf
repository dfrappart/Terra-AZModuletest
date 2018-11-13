##############################################################
#This module allows the creation of a Netsork Security Group Rule
##############################################################


# Module output

output "Name" {
  value = "${azurerm_network_security_rule.Terra-NSGRulewSTags.name}"
}

output "Id" {
  value = "${azurerm_network_security_rule.Terra-NSGRulewSTags.id}"
}
