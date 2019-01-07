##############################################################
#This module allows the creation of an Azure VPN Gateway
##############################################################



#Creation of the VPN Gateway

resource "azurerm_virtual_network_gateway" "TerraVirtualNetworkGW" {
  #count                       = "${var.count}"
  name                = "${var.AGWName}"
  resource_group_name = "${var.AGWRGName}"
  location            = "${var.AGWLocation}"
  type                = "${var.AGWType}"
  vpn_type            = "${var.AGWVpnType}"
  enable_bgp          = "${var.EnableBGP}"
  active_active       = "${var.FTOption}"
  sku                 = "${var.AGWsku}"

  ip_configuration {
    name                          = "${var.AGWIPConfName}"
    private_ip_address_allocation = "${var.AGWPRivateIPAlloc}"
    subnet_id                     = "${var.AGWSubnetId}"

    #public_ip_address_id            = "${element(var.GWPIPId,count.index)}"
    public_ip_address_id = "${var.AGWPIPId}"
  }

  tags {
    Environment      = "${var.EnvironmentTag}"
    Usage            = "${var.EnvironmentUsageTag}"
    Owner            = "${var.OwnerTag}"
    ProvisioningDate = "${var.ProvisioningDateTag}"
  }
}

