##############################################################
#This module allows the creation of Automation DSC Config 
##############################################################

#Template for the DSC config file
data "template_file" "DSCConfigTemplate" {
  template = "${file("${path.root}${var.SettingsTemplatePath}")}"
}

# Automation Credentials Creation

resource "azurerm_automation_dsc_configuration" "TerraAutomationDSCConfig" {
  name                          = "${var.AutomationDSCConfigName}"
  resource_group_name           = "${var.RGName}"
  automation_account_name       = "${var.AutomationAccountName}"
  location                      = "${var.Location}"
  content_embedded              = "${data.template_file.DSCConfigTemplate.rendered}"
  description                   = "${var.AutomationDSCConfigDescription}"
  log_verbose                   = "${var.LogverboseEnabledStatus}"

}

