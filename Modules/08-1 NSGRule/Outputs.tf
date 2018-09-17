
# Module output

output "Name" {
  value = "${azurerm_network_security_rule.Terra-NSGRule.name}"
}

output "Id" {
  value = "${azurerm_network_security_rule.Terra-NSGRule.id}"
}
