######################################################
# Module DTBS Outputs
######################################################

######################################################
#VNet ouputs

output "VNetName" {
  value = azurerm_virtual_network.VNet.name
}

output "VNetId" {
  value     = azurerm_virtual_network.VNet.id
  sensitive = true
}

output "VNetAddressSpace" {
  value = azurerm_virtual_network.VNet.address_space
}

output "VNetRGName" {
  value = azurerm_virtual_network.VNet.resource_group_name
}

output "VNetLocation" {
  value = azurerm_virtual_network.VNet.location
}

output "VNetFull" {
  value     = azurerm_virtual_network.VNet
  sensitive = true
}

######################################################
#Subnet ouputs

output "SubnetNames" {
  value = azurerm_subnet.Subnet[*].name
}

output "SubnetIds" {
  value     = azurerm_subnet.Subnet[*].id
  sensitive = true
}

output "SubnetAddressPrefixes" {
  value = azurerm_subnet.Subnet[*].address_prefixes
}

output "SubnetFull" {
  value     = azurerm_subnet.Subnet[*]
  sensitive = true
}

######################################################
#NSG ouputs

output "NSGNames" {
  value = azurerm_network_security_group.NSG[*].name
}

output "NSGIds" {
  value = azurerm_network_security_group.NSG[*].id
}

output "NSGFull" {
  value     = azurerm_network_security_group.NSG[*]
  sensitive = true
}

######################################################
#Databricks workspace ouputs

output "DTBSWFull" {
  value     = azurerm_databricks_workspace.DTBWS
  sensitive = true

}

output "DTBSWId" {
  value     = azurerm_databricks_workspace.DTBWS.id
  sensitive = true
}

output "DTBSWManagedRGId" {
  value = azurerm_databricks_workspace.DTBWS.managed_resource_group_id
}

output "DTBSWName" {
  value = azurerm_databricks_workspace.DTBWS.name
}