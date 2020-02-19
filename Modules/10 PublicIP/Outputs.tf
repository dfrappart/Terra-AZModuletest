######################################################################
# This module allows the creation of a Public IP Address
######################################################################

/*

#Module output without zones

output "Names" {
  value = ["${azurerm_public_ip.TerraPublicIP.*.name}"]
}

output "Ids" {
  value = ["${azurerm_public_ip.TerraPublicIP.*.id}"]
}


output "IPAddresses" {

  value = ["${azurerm_public_ip.TerraPublicIP.*.ip_address}"]
}

output "fqdns" {
  value = ["${azurerm_public_ip.TerraPublicIP.*.fqdn}"]
}
*/

#Module outputs with zones

output "ZRIPName" {
  value = azurerm_public_ip.TerraPublicIPZoneRedundant.name
}

output "ZRIPId" {
  value = azurerm_public_ip.TerraPublicIPZoneRedundant.id
}

/*
output "IPAddresses" {

  value = ["${azurerm_public_ip.TerraPublicIPZoneRedundant.*.ip_address}"]
}
*/
output "ZRIPfqdns" {
  value = azurerm_public_ip.TerraPublicIPZoneRedundant.fqdn
}

output "RGName" {
  value = azurerm_public_ip.TerraPublicIPZoneRedundant.resource_group_name
}
