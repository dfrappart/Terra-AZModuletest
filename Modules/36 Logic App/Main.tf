##############################################################
#This module allows the creation of Automation DSC Config node 
##############################################################

#Template for the DSC config file
data "template_file" "DSCConfignodeTemplate" {
  template = "${file("${path.root}${var.SettingsTemplatePath}")}"
}

# Automation Credentials Creation

resource "azurerm_automation_dsc_nodeconfiguration" "TerraAutomationDSCConfigNode" {
  name                          = "${var.AutomationDSCConfigNodeName}"
  resource_group_name           = "${var.RGName}"
  automation_account_name       = "${var.AutomationAccountName}"
  location                      = "${var.Location}"
  content_embedded              = "${data.template_file.DSCConfignodeTemplate.rendered}"

}


