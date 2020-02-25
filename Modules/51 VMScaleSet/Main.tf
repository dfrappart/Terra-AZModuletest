######################################################################
# This module creates an external load balancer
######################################################################



# Creating Azure vmss

resource "azurerm_virtual_machine_scale_set" "TerraVMSS" {
  name                = var.VMSSName
  location            = var.VMSSRegion
  resource_group_name = var.VMSSRGName
  sku                 = var.LBSku

  frontend_ip_configuration {
    name                 = var.FEConfigName
    public_ip_address_id = var.PublicIPId
  }

    tags = {
    Environment         = var.EnvironmentTag
    Usage               = var.EnvironmentUsageTag
    Owner               = var.OwnerTag
    ProvisioningDate    = var.ProvisioningDateTag
    }
}

