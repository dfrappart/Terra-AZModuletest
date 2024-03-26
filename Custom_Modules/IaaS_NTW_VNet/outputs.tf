##############################################################
# module outputs
##############################################################

##############################################################

# Output RG


output "RG" {
  value       = data.azurerm_resource_group.RgVnet
  sensitive   = false
  description = "Information on the Vnet RG"
}



##############################################################
#Output for the VNet

output "VNetFullOutput" {
  value                       = azurerm_virtual_network.Vnet
  sensitive                   = true
}

output "subprefix" {
  value = local.SubnetPrefixes
}


output "Subnets" {
  value = local.Subnets
}
/*
output "subnetIpGroups" {
  value = azurerm_ip_group.SubnetsCidr
}

output "VnetIpGroup" {
  value = azurerm_ip_group.VnetCidr
}
*/
output "keylocalsubnet" {
  value = keys(local.Subnets)
}