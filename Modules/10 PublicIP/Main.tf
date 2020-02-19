######################################################################
# This module allows the creation of a Public IP Address
######################################################################


/*
resource "azurerm_public_ip" "TerraPublicIP" {
  count                        = "${var.IsZoneRedundant == "false" ? var.PublicIPCount : 0}"
  name                         = "${var.PublicIPName}${count.index+1}"
  location                     = "${var.PublicIPLocation}"
  resource_group_name          = "${var.RGName}"
  #public_ip_address_allocation = "${var.PIPAddressAllocation}" changed for allocation_method
  allocation_method            = "${var.PIPAddressAllocation}"
  sku                          = "${var.PIPAddressSku}"
  domain_name_label            = "${lower(var.EnvironmentTag)}${lower(var.PublicIPName)}${count.index+1}"

  tags {
    Environment       = "${var.EnvironmentTag}"
    Usage             = "${var.EnvironmentUsageTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
  }
}
*/


resource "azurerm_public_ip" "TerraPublicIPZoneRedundant" {
  name                         = var.PublicIPName
  location                     = var.PublicIPLocation
  resource_group_name          = var.RGName
  #public_ip_address_allocation = "static" changed for allocation_method
  allocation_method            = "Static"
  sku                          = "standard"
  domain_name_label            = "${lower(var.EnvironmentTag)}${lower(var.PublicIPName)}"
  zones                        = var.PIPZones


  tags {
    Environment       = var.EnvironmentTag
    Usage             = var.EnvironmentUsageTag
    Owner             = var.OwnerTag
    ProvisioningDate  = var.ProvisioningDateTag
  }
}