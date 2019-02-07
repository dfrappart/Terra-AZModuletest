##############################################################
#This module allows the creation of Route table
##############################################################


# Route table creation

resource "azurerm_route_table" "TerraRouteTable" {
  name                          = "${var.RouteTableName}"
  location                      = "${var.RTLocation}"
  resource_group_name           = "${var.RGName}"
  disable_bgp_route_propagation = "${var.BGPDisabled}"

    tags {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}

