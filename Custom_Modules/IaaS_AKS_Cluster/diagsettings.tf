
################################################################
# Diagnostic settings resource

resource "azurerm_monitor_diagnostic_setting" "AksDiagSettings" {
  count                      = var.EnableDiagSettings ? 1 : 0
  name                       = format("%s-%s", "diag", azurerm_kubernetes_cluster.AKS.name)
  storage_account_id         = local.StaLogId
  log_analytics_workspace_id = local.LawLogId
  target_resource_id         = azurerm_kubernetes_cluster.AKS.id


  dynamic "enabled_log" {
    for_each = local.AksLogCategories
    content {
      category = enabled_log.value

    }
  }

  dynamic "metric" {
    for_each = local.AksMetricCategories
    content {
      category = metric.value

    }
  }

}