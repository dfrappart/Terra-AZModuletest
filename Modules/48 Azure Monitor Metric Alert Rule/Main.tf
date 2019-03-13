##############################################################
#This module allows the creation of an metric alert rule
##############################################################


#Creating a vNet

resource "azurerm_monitor_metric_alertrule" "TerraMetricAlertRule" {
  count                   = "${var.MatricARCount}"
  name                    = "${var.MetricARName}"
  resource_group_name     = "${var.MetricARRGName}"
  location                = "${var.MetricARLocation}"
  description             = "${var.MetricARDesc}"
  enabled                 = "${var.IsMetricAREnabled}"
  resource_id             = "${var.MetricARResourceId}"
  #Check https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported for supported metrics
  metric_name             = "${var.MetricARMetricName}"
  operator                = "${var.MetricAROperator}"
  threshold               = "${var.MetricARThreshold}"
  period                  = "${var.MetricARPeriod}"
  aggregation             = "${var.MetricARAggreg}"


  tags {
    Environment       = "${var.EnvironmentTag}"
    Usage             = "${var.EnvironmentUsageTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
  }
}

