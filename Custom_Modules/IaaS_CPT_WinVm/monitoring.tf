


resource "azurerm_monitor_metric_alert" "VMMonitorAlert" {


  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  for_each = var.AlertingEnabled ? var.VmAlerts : {}

  name                = "malt-${each.value.AlertName}-${azurerm_windows_virtual_machine.VM.name}"
  resource_group_name = var.TargetRg
  scopes              = [azurerm_windows_virtual_machine.VM.id]
  description         = "${azurerm_windows_virtual_machine.VM.name}-${each.value.AlertName}"
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

resource "azurerm_monitor_data_collection_rule_association" "DcrAssociation" {
  for_each                = var.Dcr
  name                    = format("%s-to-%s", split("/", each.value.DcrId)[8], azurerm_windows_virtual_machine.VM.name)
  target_resource_id      = azurerm_windows_virtual_machine.VM.id
  data_collection_rule_id = each.value.DcrId
  description             = each.value.DcrDescription
}

resource "azurerm_user_assigned_identity" "AMAUai" {
  count    = var.AMAAMAUaiId == "" ? 1 : 0
  location = var.TargetLocation
  name     = "uai-ama-${azurerm_windows_virtual_machine.VM.name}"
  resource_group_name = var.TargetRg
  
}