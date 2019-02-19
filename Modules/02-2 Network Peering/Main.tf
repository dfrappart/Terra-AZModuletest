##############################################################
#This module allows the creation of VNet Peering
##############################################################


#Creating VNet Peering between 2 VNet

resource "azurerm_virtual_network_peering" "TerraVNetPeering" {
  name                          = "${var.VNetPeeringName}"
  resource_group_name           = "${var.RGName}"
  virtual_network_name          = "${var.LocalVNetName}"
  remote_virtual_network_id     = "${var.RemoteVNetId}"
  allow_virtual_network_access  = "${var.IsVirtualNetworkAcccessAllowed}"
  allow_forwarded_traffic       = "${var.IsForwardedTrafficAllowed}"
  allow_gateway_transit         = "${var.IsGWTransitAllowed}"
  use_remote_gateways           = "${var.UseRemoteGW}"

}

