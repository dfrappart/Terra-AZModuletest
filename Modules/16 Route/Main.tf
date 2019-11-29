##############################################################
#This module allows the creation of Route 
##############################################################



# Route table creation

resource "azurerm_route" "TerraRoute" {
  name                   = var.RouteName
  route_table_name       = var.RTName
  resource_group_name    = var.RGName
  address_prefix         = var.DestinationCIDR
  next_hop_type          = var.NextHop
  next_hop_in_ip_address = var.NextHopinIPAddress
}

