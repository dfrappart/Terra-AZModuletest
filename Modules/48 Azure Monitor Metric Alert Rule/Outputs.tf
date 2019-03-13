##############################################################
#This module allows the creation of a vNEt
##############################################################


#Output for the module

output "Name" {
  value = "${azurerm_monitor_metric_alertrule.TerraMetricAlertRule.name}"
}


output "RGName" {
  value = "${azurerm_monitor_metric_alertrule.TerraMetricAlertRule.resource_group_name}"
}


output "IsEnabled" {
  value = "${azurerm_monitor_metric_alertrule.TerraMetricAlertRule.enabled}"
}

output "Id" {
  value = "${azurerm_monitor_metric_alertrule.TerraMetricAlertRule.id}"
}


