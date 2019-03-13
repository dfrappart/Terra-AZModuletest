##############################################################
#This module allows the creation of a vNEt
##############################################################


#Output for the module

output "AGName" {
  value = "${azurerm_monitor_action_group.TerraActionGroup.name}"
}


output "AGRGName" {
  value = "${azurerm_monitor_action_group.TerraActionGroup.resource_group_name}"
}

output "AGSName" {
  value = "${azurerm_monitor_action_group.TerraActionGroup.short_name}"
}


output "AGIsEnabled" {
  value = "${azurerm_monitor_action_group.TerraActionGroup.enabled}"
}

output "AGId" {
  value = "${azurerm_monitor_action_group.TerraActionGroup.id}"
}


