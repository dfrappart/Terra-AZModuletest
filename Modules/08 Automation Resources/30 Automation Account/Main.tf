##############################################################
#This module allows the creation of an Automation Account
##############################################################


# Automation Account creation

resource "azurerm_automation_account" "TerraAutomationAccount" {
  name                          = "${var.AutomationAccountName}"
  location                      = "${var.AutomationAccountLocation}"
  resource_group_name           = "${var.RGName}"
  sku {
    name = "Basic"
  }

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

