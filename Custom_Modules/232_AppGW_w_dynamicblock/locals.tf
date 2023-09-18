locals {

  Tags = merge(var.DefaultTags, var.extra_tags, { ManagedBy = "Terraform" })

  # Locals for RG creation


  RgName = var.TargetRG == "unspecified" ? format("%s-%s", "rg", var.AGWSuffix) : var.TargetRG

  # Locals for Storage account log creation

  StaLogId = var.StaLogId == "unspecified" ? azurerm_storage_account.StaMonitor[0].id : var.StaLogId
  LawLogId = var.LawLogId == "unspecified" ? azurerm_log_analytics_workspace.LawMonitor[0].id : var.LawLogId

  PubIpLogCategories    = var.PubIpLogCategories != null ? toset(sort(var.PubIpLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.AgwPubIP.log_category_types)
  PubIpMetricCategories = var.PubIpMetricCategories != null ? toset(sort(var.PubIpMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.AgwPubIP.metrics)
  AgwLogCategories      = var.AgwLogCategories != null ? toset(sort(var.AgwLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Agw.log_category_types)
  AgwMetricCategories   = var.AgwMetricCategories != null ? toset(sort(var.PubIpMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Agw.metrics)

}

