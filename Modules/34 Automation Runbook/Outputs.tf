##############################################################
#This module allows the creation of an autmation account
##############################################################


#Output

output "Name" {
  value = "${azurerm_automation_runbook.TerraAutomationRunbook.name}"
}

output "Id" {
  value = "${azurerm_automation_runbook.TerraAutomationRunbook.id}"
}

output "RGName" {
  value = "${azurerm_automation_runbook.TerraAutomationRunbook.resource_group_name}"
}

output "AutomationAccountName" {
  value = "${azurerm_automation_runbook.TerraAutomationRunbook.account_name}"
}
