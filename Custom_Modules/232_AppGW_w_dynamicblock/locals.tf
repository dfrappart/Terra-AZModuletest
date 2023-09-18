locals {

  Tags = merge(var.DefaultTags, var.extra_tags, { ManagedBy = "Terraform" })

  PubIpLogCategories    = var.PubIpLogCategories != null ? toset(sort(var.PubIpLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.AgwPubIP.log_category_types)
  PubIpMetricCategories = var.PubIpMetricCategories != null ? toset(sort(var.PubIpMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.AgwPubIP.metrics)
  AgwLogCategories      = var.AgwLogCategories != null ? toset(sort(var.AgwLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Agw.log_category_types)
  AgwMetricCategories   = var.AgwMetricCategories != null ? toset(sort(var.PubIpMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Agw.metrics)

}

