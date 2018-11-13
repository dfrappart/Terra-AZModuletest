##############################################################
#This module allows the creation of Route table
##############################################################


#Output

output "Name" {
  value = "${azurerm_firewall.TerraFirewall.name}"
}

output "Id" {
  value = "${azurerm_firewall.TerraFirewall.id}"
}

output "RGName" {
  value = "${azurerm_firewall.TerraFirewall.resource_group_name}"
}

output "IPConfig" {
  value = "${azurerm_firewall.TerraFirewall.ip_configuration}"
}
