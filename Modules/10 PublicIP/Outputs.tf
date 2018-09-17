######################################################################
# This module allows the creation of a Public IP Address
######################################################################


#Module output

output "Names" {
  value = ["${azurerm_public_ip.TerraPublicIP.*.name}"]
}

output "Ids" {
  value = ["${azurerm_public_ip.TerraPublicIP.*.id}"]
}

/*
output "IPAddresses" {

  value = ["${azurerm_public_ip.TerraPublicIP.*.ip_address}"]
}
*/
output "fqdns" {
  value = ["${azurerm_public_ip.TerraPublicIP.*.fqdn}"]
}

output "RGName" {
  value = "${var.RGName}"
}
