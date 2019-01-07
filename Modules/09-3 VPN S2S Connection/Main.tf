##############################################################
#This module allows the creation of a Local VPN Gateway Object
##############################################################

#Variable declaration for Module



resource "azurerm_virtual_network_gateway_connection" "TerraS2SConnect" {
  name                       = "${var.S2SConnectName}"
  location                   = "${var.S2SConnectLocation}"
  resource_group_name        = "${var.S2SConnectRG}"
  type                       = "IPSec"
  virtual_network_gateway_id = "${var.S2SConnectGWId}"
  local_network_gateway_id   = "${var.S2SConnectLGWId}"
  shared_key                 = "${var.S2SConnectKey}"

  ipsec_policy {
    dh_group         = "${var.S2Sdh_group}"
    ike_encryption   = "${var.S2Sike_encryption}"
    ike_integrity    = "${var.S2Sike_integrity}"
    ipsec_encryption = "${var.S2Sipsec_encryption}"
    ipsec_integrity  = "${var.S2Sipsec_integrity}"
    pfs_group        = "${var.S2Spfs_group}"
    sa_datasize      ="${var.S2Ssa_datasize}"
    sa_lifetime      = "${var.S2Ssa_lifetime}"
  }

  tags {
    Environment       = "${var.EnvironmentTag}"
    Usage             = "${var.EnvironmentUsageTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
  }
}

