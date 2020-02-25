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
#Databricks workspace ouputs

output "DTBSWId" {
    value = azurerm_databricks_workspace.Terra_DTBWS.id
}

output "DTBSWManagedRGId" {
    value = azurerm_databricks_workspace.Terra_DTBWS.managed_resource_group_id
}