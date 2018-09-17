######################################################################
# This module allows the creation of a Public IP Address
######################################################################



resource "azurerm_public_ip" "TerraPublicIP" {
  count                        = "${var.PublicIPCount}"
  name                         = "${var.PublicIPName}${count.index+1}"
  location                     = "${var.PublicIPLocation}"
  resource_group_name          = "${var.RGName}"
  public_ip_address_allocation = "${var.PIPAddressAllocation}"
  sku                          = "${var.PIPAddressSku}"
  domain_name_label            = "${lower(var.EnvironmentTag)}${lower(var.PublicIPName)}${count.index+1}"

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

