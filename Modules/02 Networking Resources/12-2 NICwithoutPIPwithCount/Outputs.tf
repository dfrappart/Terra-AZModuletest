##############################################################
#This module allows the creation of VMs NICs without Public IP
##############################################################


output "LBNames" {
  value = ["${azurerm_network_interface.TerraNICnopipwithcountLoadBalanced.*.name}"]
}

output "LBIds" {
  value = ["${azurerm_network_interface.TerraNICnopipwithcountLoadBalanced.*.id}"]
}

output "LBPrivateIPs" {
  value = ["${azurerm_network_interface.TerraNICnopipwithcountLoadBalanced.*.private_ip_address}"]
}

output "Names" {
  value = ["${azurerm_network_interface.TerraNICnopipwithcountLoadBalanced.*.name}"]
}

output "Ids" {
  value = ["${azurerm_network_interface.TerraNICnopipwithcountNotLoadBalanced.*.id}"]
}

output "PrivateIPs" {
  value = ["${azurerm_network_interface.TerraNICnopipwithcountNotLoadBalanced.*.private_ip_address}"]
}

output "RGName" {
  value = "${var.RGName}"
}
