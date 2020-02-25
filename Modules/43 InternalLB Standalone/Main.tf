######################################################################
# This module creates an external load balancer
######################################################################


# Creating Azure Load Balancer for front end http / https

resource "azurerm_lb" "TerraIntLB" {
  name                = var.IntLBName
  location            = var.AzureRegion
  resource_group_name = var.RGName
  sku                 = var.LBSku


  tags {
    Environment       = var.EnvironmentTag
    Usage             = var.EnvironmentTag
    Owner             = var.OwnerTag
    ProvisioningDate  = var.ProvisioningDateTag
  }
}