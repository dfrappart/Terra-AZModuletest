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
  value     = azurerm_virtual_network.Vnet
  sensitive = true
}

output "subprefix" {
  value = local.SubnetPrefixes
}


output "Subnets" {
  value = local.Subnets
}

output "subnetIpGroups" {
  value = azurerm_ip_group.SubnetsCidr
}

output "VnetIpGroup" {
  value = azurerm_ip_group.VnetCidr
}

output "LocalNsgRules" {
  value = local.NsgRules
}

output "NsgResources" {
  value = azurerm_network_security_group.Nsgs
}
/*
output "NsgRulesResources" {
  value = azurerm_network_security_rule.nsg_spoke_rules
}
*/
output "LocalSubnets" {
  value = local.Subnets
}
/*
output "DefaultNsgRules" {
  value = local.DefaultNsgRules
}*/