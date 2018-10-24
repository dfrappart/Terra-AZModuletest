##############################################################
#This module allows the creation of an autmation account
##############################################################


#Output

output "Name" {
  value = "${azurerm_automation_dsc_nodeconfiguration.TerraAutomationDSCConfigNode.TerraAutomationDSCConfig.name}"
}

output "Id" {
  value = "${azurerm_automation_dsc_nodeconfiguration.TerraAutomationDSCConfigNode.TerraAutomationDSCConfig.id}"
}

output "RGName" {
  value = "${azurerm_automation_dsc_nodeconfiguration.TerraAutomationDSCConfigNode.TerraAutomationDSCConfig.resource_group_name}"
}

output "AutomationAccountName" {
  value = "${azurerazurerm_automation_dsc_nodeconfigurationm_automation_dsc_configuration.TerraAutomationDSCConfigNode.TerraAutomationDSCConfig.automation_account_name}"
}
