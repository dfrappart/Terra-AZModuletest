##############################################################
#This module allows the creation of Automation Account 
#credentials
##############################################################


# Automation Credentials Creation

resource "azurerm_automation_credential" "TerraAutomationAccount" {
  name                          = "${var.AutomationCredsName}"
  resource_group_name           = "${var.RGName}"
  account_name                  = "${var.AutomationAccountName}"
  username                      = "${var.AutoCredsUserName}"
  password                      = "${var.AutoCredsPwd}"
  description                   = "${var.AutoCredsDescription}"

}

