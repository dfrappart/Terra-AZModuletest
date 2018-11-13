##############################################################
#This module allows the creation of an autmation account
##############################################################


#Output

output "Name" {
  value = "${azurerm_automation_schedule.TerraAutomationSchedule.name}"
}

output "Id" {
  value = "${azurerm_automation_schedule.TerraAutomationSchedule.id}"
}

output "RGName" {
  value = "${azurerm_automation_schedule.TerraAutomationSchedule.resource_group_name}"
}

output "AutomationAccountName" {
  value = "${azurerm_automation_schedule.TerraAutomationSchedule.automation_account_name}"
}
