######################################################################
# Requirement for monitoring
######################################################################

######################################################################
# Mapping OMS UAI to Azure monitor publisher role

resource "azurerm_role_assignment" "MSToMonitorPublisher" {
  count = local.IsOMSAgentEnabled ? 1 : 0

  scope                = azurerm_kubernetes_cluster.AKS.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_kubernetes_cluster.AKS.oms_agent[0].oms_agent_identity[0].object_id
}


################################################################
# AKS Alert



resource "azurerm_monitor_activity_log_alert" "AksActivityLogAlert" {

  for_each = var.ActivityLogAlertEnabled ? var.AksActivityLogAlert : {}
  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  name                = "malt-${each.key}-${azurerm_kubernetes_cluster.AKS.name}"
  resource_group_name = local.RgName
  scopes              = [azurerm_kubernetes_cluster.AKS.id]
  description         = "${azurerm_kubernetes_cluster.AKS.name}-${each.key}"
  location            = "global"

  criteria {
    resource_id    = azurerm_kubernetes_cluster.AKS.id
    operation_name = each.value.OperationName
    category       = each.value.Category

  }


  dynamic "action" {
    for_each = toset(var.ACGIds)
    iterator = each

    content {
      action_group_id = each.key
    }

  }




  tags = local.Tags

}

resource "azurerm_monitor_metric_alert" "AksMonitorAlert" {


  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  for_each = var.AlertingEnabled ? var.AksAlerts : {}

  name                = "malt-${each.value.AlertName}-${azurerm_kubernetes_cluster.AKS.name}"
  resource_group_name = local.RgName
  scopes              = [azurerm_kubernetes_cluster.AKS.id]
  description         = "${azurerm_kubernetes_cluster.AKS.name}-${each.value.AlertName}"
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




  tags = local.Tags

}