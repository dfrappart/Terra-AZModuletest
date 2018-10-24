##############################################################
#This module allows the creation of an autmation account
##############################################################


#Output

output "Name" {
  value = "${azurerm_automation_credential.TerraAutomationAccount.name}"
}

output "Id" {
  value = "${azurerm_automation_credential.TerraAutomationAccount.id}"
}

output "RGName" {
  value = "${azurerm_automation_credential.TerraAutomationAccount.resource_group_name}"
}

output "AutomationAccountName" {
  value = "${azurerm_automation_credential.TerraAutomationAccount.account_name}"
}
