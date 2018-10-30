##############################################################
#This module allows the creation of logic app workflow 
##############################################################


#Output

output "Name" {
  value = "${azurerm_logic_app_workflow.TerraLogicAppWorkflow.name}"
}

output "Id" {
  value = "${azurerm_logic_app_workflow.TerraLogicAppWorkflow.id}"
}

output "RGName" {
  value = "${azurerm_logic_app_workflow.TerraLogicAppWorkflow.resource_group_name}"
}

output "AccessEP" {
  value = "${azurerm_logic_app_workflow.TerraLogicAppWorkflow.access_endpoint}"
}
