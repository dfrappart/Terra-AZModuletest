##############################################################
#This module allows the creation of an Azure VPN Gateway
##############################################################



#Creation of the VPN Gateway, no AZ

resource "azurerm_virtual_network_gateway" "TerraVirtualNetworkGW" {
  count               = "${FTOption == "false" ? 1 : 0}"
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

#Creation of the VPN Gateway Active Active, no AZ

resource "azurerm_virtual_network_gateway" "TerraVirtualNetworkGWAA" {
  count               = "${FTOption == "true" ? 1 : 0}"
  name                = "${var.AGWName}"
  resource_group_name = "${var.AGWRGName}"
  location            = "${var.AGWLocation}"
  type                = "${var.AGWType}"
  vpn_type            = "${var.AGWVpnType}"
  enable_bgp          = "${var.EnableBGP}"
  active_active       = "${var.FTOption}"
  sku                 = "${var.AGWsku}"

  ip_configuration {
    name                          = "${var.AGWIPConfName}1"
    private_ip_address_allocation = "${var.AGWPRivateIPAlloc}"
    subnet_id                     = "${var.AGWSubnetId}"

    #public_ip_address_id            = "${element(var.GWPIPId,count.index)}"
    public_ip_address_id = "${var.AGWPIPId}"
  }

  ip_configuration {
    name                          = "${var.AGWIPConfName}2"
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
