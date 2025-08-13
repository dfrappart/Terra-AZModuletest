locals {

  RgLbTags                          = merge(var.MandatoryTags, var.ExtraTags, var.OptionalTags, { ManagedBy = "Terraform" })
  RgName                            = var.TargetRG == "unspecified" ? format("%s-%s", "rsg", var.RgSuffix) : var.TargetRG
  RgLbName                          = var.TargetRG == "unspecified" ? azurerm_resource_group.Rg[0].name : var.TargetRG
  LbPubIpName                       = format("pubip-%s", local.LbName)
  LbName                            = format("lb-%s-%s", var.LbConfig.Suffix, var.LbConfig.Index)
  LbLocation                        = var.LbConfig.Location == "" ? var.TargetLocation : var.LbConfig.Location
  LbFrontendIpConfigurationName     = var.LbConfig.IsLbPublic ? "PublicIPAddress" : "InternalIPAddress"
  LbFrontendIpConfigurationPubIpId  = var.LbConfig.IsLbPublic ? azurerm_public_ip.LbPubIp[0].id : null
  LbFrontendIpConfigurationSubnetId = var.LbConfig.IsLbPublic ? null : var.LbConfig.InternalLbSubnetId
  LbZones                           = var.LbConfig.IsLbPublic ? null : var.LbConfig.Zones

  LbTags = merge(var.MandatoryTags, var.ExtraTags, var.OptionalTags, { ManagedBy = "Terraform" }, var.LbConfig.Tags)

  EnablePubIpDiagSettings = var.LbConfig.IsLbPublic && var.PubIpDiagnosticSettingsEnabled ? true : false
  PubIpLogCategories      = var.PubIpLogCategories != null ? toset(sort(var.PubIpLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.PubIps[0].log_category_types)
  PubIpAlertingEnabled    = var.LbConfig.IsLbPublic && var.PubIpAlertingEnabled ? true : false

  EnableLbDiagSettings = var.LbDiagnosticSettingsEnabled ? true : false
  LbLogCategories      = var.LbLogCategories != null ? toset(sort(var.LbLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Lb[0].log_category_types)
  LbAlertingEnabled    = var.LbAlertingEnabled ? true : false





  /*
  CreateLocalLaw = var.LawLogId == "unspecified" && var.EnableLocalLogSink ? true : false

  CreateLocalSta = var.StaLogId == "unspecified" && var.EnableLocalLogSink ? true : false

  StaLogId = var.StaLogId == "unspecified" && local.CreateLocalSta ? azurerm_storage_account.StaMonitor[0].id : var.StaLogId

  LawLogId = var.LawLogId == "unspecified" && local.CreateLocalLaw ? azurerm_log_analytics_workspace.LawMonitor[0].id : var.LawLogId
*/
}

