##############################################################
#This module allows the creation of an autmation account
##############################################################


#Output

output "Name" {
  value = "${azurerm_automation_credential.TerraAutomationCreds.name}"
}

output "Id" {
  value = "${azurerm_automation_credential.TerraAutomationCreds.id}"
}

output "RGName" {
  value = "${azurerm_automation_credential.TerraAutomationCreds.resource_group_name}"
}

output "AutomationAccountName" {
  value = "${azurerm_automation_credential.TerraAutomationCreds.account_name}"
}
