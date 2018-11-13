##############################################################
#This module allows the creation of an autmation account
##############################################################


#Output

output "Name" {
  value = "${azurerm_automation_account.TerraAutomationAccount.name}"
}

output "Id" {
  value = "${azurerm_automation_account.TerraAutomationAccount.id}"
}

output "RGName" {
  value = "${azurerm_automation_account.TerraAutomationAccount.resource_group_name}"
}


