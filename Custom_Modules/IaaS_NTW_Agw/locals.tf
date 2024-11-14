locals {

  Tags = merge(var.DefaultTags, var.extra_tags, { ManagedBy = "Terraform" })

  # Locals for RG creation


  RgName = var.TargetRG == "unspecified" ? format("%s-%s", "rg", var.AGWSuffix) : var.TargetRG

  # Locals for Storage account log creation

  CreateLocalLaw = var.LawLogId == "unspecified" && var.EnabledDiagSettings ? true : false
  CreateLocalSta = var.StaLogId == "unspecified" && var.EnabledDiagSettings ? true : false
  StaLogId       = var.StaLogId == "unspecified" && local.CreateLocalSta ? azurerm_storage_account.StaMonitor[0].id : var.StaLogId
  LawLogId       = var.LawLogId == "unspecified" && local.CreateLocalLaw ? azurerm_log_analytics_workspace.LawMonitor[0].id : var.LawLogId


  #StaLogId = var.StaLogId == "unspecified" ? azurerm_storage_account.StaMonitor[0].id : var.StaLogId
  #LawLogId = var.LawLogId == "unspecified" ? azurerm_log_analytics_workspace.LawMonitor[0].id : var.LawLogId

  PubIpLogCategories    = var.PubIpLogCategories != null ? toset(sort(var.PubIpLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.AgwPubIP.log_category_types)
  PubIpMetricCategories = var.PubIpMetricCategories != null ? toset(sort(var.PubIpMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.AgwPubIP.metrics)
  AgwLogCategories      = var.AgwLogCategories != null ? toset(sort(var.AgwLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Agw.log_category_types)
  AgwMetricCategories   = var.AgwMetricCategories != null ? toset(sort(var.PubIpMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Agw.metrics)

  KvRoles = [
    "Key Vault Secrets Officer",
    "Key Vault Certificates Officer"
  ]

  DefaultAgwConfig = {
    DefaultAgwBePool = "agw-bck-default-bepool"
    DefaultAgwBhs    = "agw-bhs-default"
    DefaultAgwLst    = "agw-lst-default"
    DefaultAgwrule   = "agw-rul-default"
  }

}

