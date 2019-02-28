##############################################################
#This module allows the creation of a vNEt
##############################################################


#Output for the module

output "AGName" {
  value = "${azurerm_monitor_action_group.TerraLogTerraActionGroup.name}"
}


output "AGRGName" {
  value = "${azurerm_monitor_action_group.TerraLogTerraActionGroup.resource_group_name}"
}

output "AGSName" {
  value = "${azurerm_monitor_action_group.TerraLogTerraActionGroup.short_name}"
}


output "AGIsEnabled" {
  value = "${azurerm_monitor_action_group.TerraLogTerraActionGroup.enabled}"
}

output "AGId" {
  value = "${azurerm_monitor_action_group.TerraLogTerraActionGroup.id}"
}


