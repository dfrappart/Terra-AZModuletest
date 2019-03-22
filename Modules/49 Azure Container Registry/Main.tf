##############################################################
#This module allows the creation of container registry
##############################################################


#Creating a vNet

resource "azurerm_container_registry" "TerraACR" {
  #count                         = "${var.MatricARCount}"
  name                          = "${var.ACRName}"
  resource_group_name           = "${var.ACRRG}"
  location                      = "${var.ACRLocation}"
  admin_enabled                 = "${var.IsAdminEnabled}"
  #storage_account_id            = "${var.ACRSTOAID}" only for classic sku
  sku                           = "${var.ACRSku}"
  georeplication_locations      = "${var.ACRReplList}"


  tags {
    Environment       = "${var.EnvironmentTag}"
    Usage             = "${var.EnvironmentUsageTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
  }
}

