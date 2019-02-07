##############################################################
#This module allows the creation of logic app workflow 
##############################################################


# Logic App workflow creation

resource "azurerm_logic_app_workflow" "TerraLogicAppWorkflow" {
  name                          = "${var.LogicAppName}"
  resource_group_name           = "${var.RGName}"
  location                      = "${var.Location}"

    tags {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}


