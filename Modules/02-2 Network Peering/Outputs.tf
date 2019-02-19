##############################################################
#This module allows the creation of a vNEt
##############################################################


#Output for the vNET module

output "Name" {
  value = "${azurerm_virtual_network_peering.TerraVNetPeering.name}"
}

output "PeeringId" {
  value = "${azurerm_virtual_network_peering.TerraVNetPeering.id}"
}

output "LocalVNetName" {
  value = "${azurerm_virtual_network_peering.TerraVNetPeering.virtual_network_name}"
}

output "RemoteVNetId" {
  value = "${azurerm_virtual_network_peering.TerraVNetPeering.remote_virtual_network_id}"
}

output "IsVirtualNetworkAcccessAllowed" {
  value = "${azurerm_virtual_network_peering.TerraVNetPeering.allow_virtual_network_access}"
}

output "IsForwardedTrafficAllowed" {
  value = "${azurerm_virtual_network_peering.TerraVNetPeering.allow_forwarded_traffic}"
}

output "IsGWTransitAllowed" {
  value = "${azurerm_virtual_network_peering.TerraVNetPeering.allow_gateway_transit}"
}