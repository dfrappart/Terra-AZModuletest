
resource "azurerm_monitor_metric_alert" "AppSvcPlanMonitorAlert" {


  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  for_each = var.AlertingEnabled ? var.AppSvcPlanAlerts : {}

  name                = "malt-${each.value.AlertName}-${azurerm_service_plan.AppSvcPlan.name}"
  resource_group_name = local.RgAppSvc
  scopes              = [azurerm_service_plan.AppSvcPlan.id]
  description         = "${azurerm_service_plan.AppSvcPlan.name}-${each.value.AlertName}"
  severity            = each.value.AlertSeverity

  criteria {
    metric_namespace = each.value.MetricNameSpace
    metric_name      = each.value.MetricName
    aggregation      = each.value.MetricAggregation
    operator         = each.value.MetricOperator
    threshold        = each.value.MetricThreshold


  }


  dynamic "action" {
    for_each = toset(var.ACGIds)
    iterator = each

    content {
      action_group_id = each.key
    }

  }


  frequency   = each.value.AlertFrequency
  window_size = each.value.AlertWindow




  tags = {}

}

resource "azurerm_monitor_metric_alert" "AppSvcMonitorAlerts" {


  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  for_each = var.AlertingEnabled ? local.AppSvcAlertsMap : {}

  name                = "malt-${each.value.AlertName}-${azurerm_service_plan.AppSvcPlan.name}"
  resource_group_name = local.RgAppSvc
  scopes              = [each.value.AppSvcId]
  description         = "${azurerm_service_plan.AppSvcPlan.name}-${each.value.AlertName}"
  severity            = each.value.AlertSeverity

  criteria {
    metric_namespace = each.value.MetricNameSpace
    metric_name      = each.value.MetricName
    aggregation      = each.value.MetricAggregation
    operator         = each.value.MetricOperator
    threshold        = each.value.MetricThreshold


  }


  dynamic "action" {
    for_each = toset(var.ACGIds)
    iterator = each

    content {
      action_group_id = each.key
    }

  }


  frequency   = each.value.AlertFrequency
  window_size = each.value.AlertWindow




  tags = {}

}