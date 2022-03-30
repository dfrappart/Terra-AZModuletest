##############################################################
#This module allows the creation of observability basics
##############################################################

output "DeploymentType" {

  value = var.IsDeploymentTypeGreenField ? "GreenField" : "BrownField"
}

##############################################################
#Output NetworkWatcher


output "NetworkWatcherName" {

  value = var.IsDeploymentTypeGreenField ? azurerm_network_watcher.TerraNWW.*.name : ["NotGreenFieldDeployment"]
}

output "NetworkWatcherId" {

  value = var.IsDeploymentTypeGreenField ? azurerm_network_watcher.TerraNWW.*.id : ["NotGreenFieldDeployment"]
}

output "NetworkWatcherRGName" {

  value = var.IsDeploymentTypeGreenField ? element(azurerm_resource_group.RGNW.*.name,0) : "NotGreenFieldDeployment"
}

##############################################################
#Azure Security Center Output

output "ASCTier" {

  value = azurerm_security_center_subscription_pricing.ASCSubTier.tier
}

output "ASCId" {

  value = azurerm_security_center_subscription_pricing.ASCSubTier.id
}
/*
output "ASCContact" {

  value = azurerm_security_center_contact.ASCContact.email
}
*/
##############################################################
#Action Group Output

output "DefaultSubActionGroupId" {

  value = azurerm_monitor_action_group.DefaultSubActionGroup.id
}

output "DefaultSubActionGroupName" {

  value = azurerm_monitor_action_group.DefaultSubActionGroup.name
}

output "DefaultSubActionGroupEmailReceiver" {

  value = azurerm_monitor_action_group.DefaultSubActionGroup.email_receiver
}

##############################################################
#Service health Alerts Output

output "ServiceHealthAlertName" {

  value = azurerm_monitor_activity_log_alert.SubSVCHealth.name
}

output "ServiceHealthAlertId" {

  value = azurerm_monitor_activity_log_alert.SubSVCHealth.id
}

output "ServiceHealthAlertCriteria" {

  value = azurerm_monitor_activity_log_alert.SubSVCHealth.criteria
}

##############################################################
#Resources health Alerts Output
/*
output "ResourcesHealthAlertName" {

  value = azurerm_monitor_activity_log_alert.SubRSCHealthUnavailable.name
}

output "ResourcesHealthAlertId" {

  value = azurerm_monitor_activity_log_alert.SubRSCHealthUnavailable.id
}

output "ResourcesHealthAlertCriteria" {

  value = azurerm_monitor_activity_log_alert.SubRSCHealthUnavailable.criteria
}
*/