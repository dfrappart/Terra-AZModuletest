
################################################################
# Diagnostic settings resources

# Diag settings on Vnet

resource "azurerm_monitor_diagnostic_setting" "VnetDiagSettings" {
  count                      = var.EnableVnetDiagSettings ? 1 : 0
  name                       = format("%s-%s", "diag", azurerm_virtual_network.Vnet.name)
  storage_account_id         = local.StaLogId
  log_analytics_workspace_id = local.LawLogId
  target_resource_id         = azurerm_virtual_network.Vnet.id


  dynamic "enabled_log" {
    for_each = local.VnetLogCategories
    content {
      category = enabled_log.value

    }
  }

  dynamic "metric" {
    for_each = local.VnetMetricCategories
    content {
      category = metric.value

    }
  }

}

# Diag settings on Nsgs

resource "azurerm_monitor_diagnostic_setting" "NsgDiagSettings" {
  for_each                   = local.Subnets
  name                       = format("%s-%s", "diag", azurerm_network_security_group.Nsgs[each.key].name)
  storage_account_id         = local.StaLogId
  log_analytics_workspace_id = local.LawLogId
  target_resource_id         = azurerm_network_security_group.Nsgs[each.key].id

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.Nsg[each.key].log_category_types
    content {
      category = enabled_log.value

    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.Nsg[each.key].metrics
    content {
      category = metric.value

    }
  }
}
