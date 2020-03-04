######################################################
# Module DTBS Outputs
######################################################

######################################################
#Resource Group ouputs

output "RGName" {

  value = azurerm_resource_group.Terra_RG.name
}

output "RGLocation" {

  value = azurerm_resource_group.Terra_RG.location
}

output "RGId" {

  value = azurerm_resource_group.Terra_RG.id
  sensitive = true
}

######################################################
#VNet ouputs

output "VNetName" {
  value = azurerm_virtual_network.Terra_VNet.name
}

output "VNetId" {
  value = azurerm_virtual_network.Terra_VNet.id
}

output "VNetAddressSpace" {
  value = azurerm_virtual_network.Terra_VNet.address_space
}

output "VNetRGName" {
  value = azurerm_virtual_network.Terra_VNet.resource_group_name
}

output "VNetLocation" {
  value = azurerm_virtual_network.Terra_VNet.location
}

######################################################
#Subnet ouputs

output "SubnetNames" {
  value = azurerm_subnet.Terra_Subnet.*.name
}

output "SubnetIds" {
  value = azurerm_subnet.Terra_Subnet.*.id
}

output "SubnetAddressPrefixes" {
  value = azurerm_subnet.Terra_Subnet.*.address_prefix
}

output "SubnetRGNames" {
  value = azurerm_subnet.Terra_Subnet.*.resource_group_name
}

######################################################
#NSG ouputs

output "NSGNames" {
  value = azurerm_network_security_group.Terra_NSG.*.name
}

output "NSGIds" {
  value = azurerm_network_security_group.Terra_NSG.*.id
}

output "NSGRGNames" {
  value = azurerm_network_security_group.Terra_NSG.*.resource_group_name
}


######################################################
#PIP ouputs

output "PIPName" {
  value = azurerm_public_ip.Terra_PIP.name
}

output "PIPId" {
  value = azurerm_public_ip.Terra_PIP.id
}

output "PIPfqdns" {
  value = azurerm_public_ip.Terra_PIP.fqdn
}

output "PIPRGName" {
  value = azurerm_public_ip.Terra_PIP.resource_group_name
}

######################################################
#LB ouputs

output "LBRGName" {
  value = azurerm_lb.Terra_ExtLB.resource_group_name
}

output "LBId" {
  value = azurerm_lb.Terra_ExtLB.id
}

output "LBPrivate_ip_address" {
  value = azurerm_lb.Terra_ExtLB.private_ip_address
}

output "LBFEConfigs" {
  value = azurerm_lb.Terra_ExtLB.frontend_ip_configuration
}

output "LBBEPoolId" {
  value = azurerm_lb_backend_address_pool.Terra_LBBackEndPool.id
}

output "LBBEPoolBEConfig" {
  value = azurerm_lb_backend_address_pool.Terra_LBBackEndPool.backend_ip_configurations 
}

output "LBBEPoolLBRules" {
  value = azurerm_lb_backend_address_pool.Terra_LBBackEndPool.load_balancing_rules 
}

