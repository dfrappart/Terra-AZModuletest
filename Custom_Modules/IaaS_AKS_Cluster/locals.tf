

locals {


  AKSClusterName         = "aks-${lower(var.AKSClusSuffix)}"
  AKSDefaultNodePoolName = "aksnp0${lower(var.AKSClusSuffix)}"
  DNSPrefix              = "aks${lower(var.AKSClusSuffix)}"
  CustomNodeRGName       = var.AKSNodesRG != "unspecified" ? var.AKSNodesRG : "rsg-aksobjects${lower(var.AKSClusSuffix)}"
  DefaultNodeRGName      = null

  CreateLocalLaw = var.LawLogId == "unspecified" && var.EnableDiagSettings ? true : false

  CreateLocalSta = var.StaLogId == "unspecified" && var.EnableDiagSettings ? true : false

  StaLogId = var.StaLogId == "unspecified" && local.CreateLocalSta ? azurerm_storage_account.StaMonitor[0].id : var.StaLogId

  LawLogId = var.LawLogId == "unspecified" && local.CreateLocalLaw ? azurerm_log_analytics_workspace.LawMonitor[0].id : var.LawLogId

  LawOMSId          = var.LawOMSId != "unspecified" ? var.LawOMSId : var.LawLogId
  IsOMSAgentEnabled = var.IsOMSAgentEnabled && local.LawOMSId != "unspecified" ? true : false

  LawDefenderId     = var.LawDefenderId != "unspecified" ? var.LawDefenderId : var.LawLogId
  IsDefenderEnabled = var.IsDefenderEnabled && local.LawDefenderId != "unspecified" ? true : false


  AGIC = {
    Enabled    = var.IsAGICEnabled
    Id         = var.AGWId
    Name       = var.AGWName
    SubnetCidr = var.AGWSubnetCidr
    SubnetId   = var.AGWSubnetId
  }

  Tags = merge(var.DefaultTags, var.extra_tags, { ManagedBy = "Terraform" })

  PrivateClusterPublicFqdn = var.IsAKSPrivate ? var.PrivateClusterPublicFqdn : false
  PrivateDNSZoneId         = local.PrivateClusterPublicFqdn ? "None" : var.PrivateDNSZoneId
  IsBYOPrivateDNSZone      = local.PrivateClusterPublicFqdn || !var.IsAKSPrivate ? false : var.IsBYOPrivateDNSZone


  AksLogCategories    = var.AksLogCategories != null ? toset(sort(var.AksLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Aks.log_category_types)
  AksMetricCategories = var.AksMetricCategories != null ? toset(sort(var.AksMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Aks.metrics)

  RgName = var.AKSRGName == "unspecified" ? format("%s-%s", "rg", var.AKSClusSuffix) : var.AKSRGName

}

output "LawOMSId" {
  value = local.LawOMSId
}

output "LawLogId" {
  value = local.LawLogId
}

output "LawDefenderId" {
  value = local.LawDefenderId
}

output "IsOMSAgentEnabled" {
  value = local.IsOMSAgentEnabled
}

output "IsDefenderEnabled" {
  value = local.IsDefenderEnabled
}

output "CreateLocalLaw" {
  value = local.CreateLocalLaw
}