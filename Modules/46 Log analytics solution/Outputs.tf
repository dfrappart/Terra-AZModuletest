##############################################################
#This module allows the creation of a vNEt
##############################################################


#Output for the vNET module

output "SolutionName" {
  value = azurerm_log_analytics_solution.TerraLogAnalyticsSol.solution_name
}

output "Location" {
  value = azurerm_log_analytics_solution.TerraLogAnalyticsSol.location
}

output "RG" {
  value = azurerm_log_analytics_solution.TerraLogAnalyticsSol.resource_group_name
}

output "LAWId" {
  value = azurerm_log_analytics_solution.TerraLogAnalyticsSol.workspace_resource_id
}

output "LAWName" {
  value = azurerm_log_analytics_solution.TerraLogAnalyticsSol.workspace_name
}

output "Plan" {
  value = azurerm_log_analytics_solution.TerraLogAnalyticsSol.plan
}