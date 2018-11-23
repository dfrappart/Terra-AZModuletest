######################################################################
# This module creates an external load balancer
######################################################################


# Creating Azure Load Balancer for front end http / https

resource "azurerm_lb" "TerraExtLB" {
  name                = "${var.ExtLBName}"
  location            = "${var.AzureRegion}"
  resource_group_name = "${var.RGName}"

  frontend_ip_configuration {
    name                 = "${var.FEConfigName}"
    public_ip_address_id = "${var.PublicIPId}"
  }

  tags {
    environment       = "${var.EnvironmentTag}"
    usage             = "${var.EnvironmentTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
  }
}