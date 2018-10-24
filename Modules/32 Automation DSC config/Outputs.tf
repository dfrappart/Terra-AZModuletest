##############################################################
#This module allows the creation of an autmation account
##############################################################


#Output

output "Name" {
  value = "${azurerm_automation_dsc_configuration.TerraAutomationDSCConfig.name}"
}

output "Id" {
  value = "${azurerm_automation_dsc_configuration.TerraAutomationDSCConfig.id}"
}

output "RGName" {
  value = "${azurerm_automation_dsc_configuration.TerraAutomationDSCConfig.resource_group_name}"
}

output "AutomationAccountName" {
  value = "${azurerm_automation_dsc_configuration.TerraAutomationDSCConfig.automation_account_name}"
}
