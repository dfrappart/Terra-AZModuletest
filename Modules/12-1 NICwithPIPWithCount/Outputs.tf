##############################################################
#This module allows the creation of VMs NICs with Public IP
##############################################################


output "Names" {
  value = ["${azurerm_network_interface.TerraNICwpip.*.name}"]
}

output "Ids" {
  value = ["${azurerm_network_interface.TerraNICwpip.*.id}"]
}

output "PrivateIPs" {
  value = ["${azurerm_network_interface.TerraNICwpip.*.private_ip_address}"]
}

output "RGName" {
  value = "${var.RGName}"
}

output "AppliedDNS" {
  value = ["${azurerm_network_interface.TerraNICwpip.*.applied_dns_servers}"]
}

output "InternalFQDNs" {
  value = ["${azurerm_network_interface.TerraNICwpip.*.internal_fqdn}"]
}

/*
output "VMIDs" {
  value = ["${azurerm_network_interface.TerraNICwpip.*.virtual_machine_id}"]
}
*/
output "MacAddresses" {
  value = ["${azurerm_network_interface.TerraNICwpip.*.mac_address}"]
}
