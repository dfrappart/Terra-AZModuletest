

resource "azurerm_monitor_diagnostic_setting" "PubIpDiagSettings" {
  count = local.EnablePubIpDiagSettings ? 1 : 0
  name                       = format("%s-%s", "diag", azurerm_public_ip.LbPubIp[0].name)
  storage_account_id         = var.StaLogId
  log_analytics_workspace_id = var.LawLogId
  target_resource_id         = azurerm_public_ip.LbPubIp[0].id


  dynamic "enabled_log" {
    for_each = local.PubIpLogCategories
    content {
      category = enabled_log.value

    }
  }

  dynamic "enabled_metric" {
    for_each = var.PubIpMetricsEnabled ? var.PubIpMetricCategories : []

    content {
      category = enabled_metric.value

    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "LbDiagSettings" {
  count = local.EnableLbDiagSettings ? 1 : 0
  name                       = format("%s-%s", "diag", azurerm_lb.Lb.name)
  storage_account_id         = var.StaLogId
  log_analytics_workspace_id = var.LawLogId
  target_resource_id         = azurerm_lb.Lb.id


  dynamic "enabled_log" {
    for_each = local.LbLogCategories
    content {
      category = enabled_log.value

    }
  }

  dynamic "enabled_metric" {
    for_each = var.LbMetricsEnabled ? var.PubIpMetricCategories : []

    content {
      category = enabled_metric.value

    }
  }

}



resource "azurerm_monitor_metric_alert" "PubIpAlerts" {


  lifecycle {
    ignore_changes = [
      
    ]
  }

  for_each = local.PubIpAlertingEnabled ? var.PubIpAlerts : {}

  name                = "malt-${each.value.AlertName}-${azurerm_public_ip.LbPubIp[0].name}"
  resource_group_name = local.RgName
  scopes              = toset([azurerm_public_ip.LbPubIp[0].id])
  description         = each.value.AlertDescription
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


resource "azurerm_monitor_metric_alert" "LbAlerts" {


  lifecycle {
    ignore_changes = [
      
    ]
  }

  for_each = local.LbAlertingEnabled ? var.LbAlerts : {}

  name                = "malt-${each.value.AlertName}-${azurerm_lb.Lb.name}"
  resource_group_name = local.RgName
  scopes              = toset([azurerm_lb.Lb.id])
  description         = each.value.AlertDescription
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