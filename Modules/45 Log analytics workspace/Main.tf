##############################################################
#This module allows the creation of a log analytics workspace
##############################################################


#Creating a vNet

resource "azurerm_log_analytics_workspace" "TerraLogAnalyticsWS" {
  name                = "${var.LAWName}"
  location            = "${var.LAWLocation}"
  resource_group_name = "${var.LAWRGName}"
  sku                 = "${var.LAWSku}"
  


  tags = {
    Environment       = "${var.EnvironmentTag}"
    Usage             = "${var.EnvironmentUsageTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
  }
}

