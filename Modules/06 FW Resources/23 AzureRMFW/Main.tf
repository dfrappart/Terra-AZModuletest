##############################################################
#This module allows the creation of an AzureRM FW
##############################################################


# FW creation

resource "azurerm_firewall" "TerraFirewall" {
  name                          = "${var.FWName}"
  location                      = "${var.FWLocation}"
  resource_group_name           = "${var.RGName}"

  ip_configuration {
    name                          = "${var.FWName}${var.FWIPConfigName}"
    subnet_id                     = "${var.FWSubnetId}"
    internal_public_ip_address_id = "${var.FWPIPId}"
  }

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

