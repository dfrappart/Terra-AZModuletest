locals {

  Tags = merge(var.mandatory_tags, var.extra_tags, var.optional_tags,{ ManagedBy = "Terraform" })

  # Locals for RG creation


  RgName   = var.TargetRG == "unspecified" ? format("%s-%s", "rg", var.RgSuffix) : var.TargetRG
  RgAppSvc = var.TargetRG == "unspecified" ? azurerm_resource_group.Rg[0].name : var.TargetRG

  AppSvcPlanLocation = var.AppSvcPlan.Location == "unspecified" ? azurerm_resource_group.Rg[0].location : var.AppSvcPlan.Location

  # Locals for Storage account log creation
  /*
  CreateLocalLaw = var.LawLogId == "unspecified" && var.EnabledDiagSettings ? true : false
  CreateLocalSta = var.StaLogId == "unspecified" && var.EnabledDiagSettings ? true : false
  StaLogId       = var.StaLogId == "unspecified" && local.CreateLocalSta ? azurerm_storage_account.StaMonitor[0].id : var.StaLogId
  LawLogId       = var.LawLogId == "unspecified" && local.CreateLocalLaw ? azurerm_log_analytics_workspace.LawMonitor[0].id : var.LawLogId

*/


  #rg_vnet_name     = format("rg-%s-%s-%s-%s", var.perimeter.scope, var.perimeter.environment, var.rg_vnet.suffix, var.rg_vnet.index)
  #vnet_name        = format("vnet-%s-%s-%s-%s", var.perimeter.scope, var.perimeter.environment, var.rg_vnet.vnet_suffix, var.rg_vnet.index)
  #rg_appsvc_name   = format("rg-%s-%s-%s-%s", var.perimeter.scope, var.perimeter.environment, var.rg_appsvc.suffix, var.rg_appsvc.index)
  #appsvc_plan_name = format("asp-%s-%s-%s-%s", var.perimeter.scope, var.perimeter.environment, var.app_svc.app_svc_plan_suffix, var.app_svc.app_svc_plan_index)
  #app_svc_name     = format("app-%s-%s-%s-%s", var.perimeter.scope, var.perimeter.environment, var.app_svc.app_svc_suffix, var.app_svc.app_svc_index)
  #appsvc_subnet_id = var.app_svc.app_svc_integrated_subnet == "" ? null : data.azurerm_subnet.app_subnet[0].id
  
  #pe_name          = format("pe-%s", azurerm_linux_web_app.App.name)
  #psc_name         = format("psc-%s", azurerm_linux_web_app.App.name)




  DefaultAllowedAddressPrefixes = []

  AppSvcAllowedAddressesPrefixes = [] #toset(concat(var.app_svc.app_svc_allowed_ips, local.DefaultAllowedAddressPrefixes))

  #AppSvcName = { for k, v in var.AppSvc : k => format("%s-%s", v.AppSvcName, var.RgSuffix) }

  AppSvcAlertsList = flatten([ for AppSvc in azurerm_linux_web_app.App : 
    [for k,v in var.AppSvcAlerts : {
      AppSvcId = AppSvc.id
      AppSvcName = AppSvc.name
      AlertName = "${AppSvc.name}-${v.AlertName}"
      AlertDescription = "${v.AlertDescription} For ${AppSvc.name}"
      AlertSeverity = v.AlertSeverity
      MetricNameSpace = v.MetricNameSpace
      MetricName = v.MetricName
      MetricAggregation = v.MetricAggregation
      MetricOperator = v.MetricOperator
      MetricThreshold = v.MetricThreshold
      AlertFrequency = v.AlertFrequency
      AlertWindow = v.AlertWindow
      DimensionEnabled = v.DimensionEnabled
      DimensionName = v.DimensionName
      DimensionOperator = v.DimensionOperator
      DimensionValue = v.DimensionValue
      DimensionValue = v.DimensionValue

      }]
  ])

  AppSvcAlertsMap = { for i in local.AppSvcAlertsList : i.AlertName => {
    AppSvcId = i.AppSvcId
    AlertName = i.AlertName
    AlertDescription = i.AlertDescription
    AlertSeverity = i.AlertSeverity
    MetricNameSpace = i.MetricNameSpace
    MetricName = i.MetricName
    MetricAggregation = i.MetricAggregation
    MetricOperator = i.MetricOperator
    MetricThreshold = i.MetricThreshold
    AlertFrequency = i.AlertFrequency
    AlertWindow = i.AlertWindow
    DimensionEnabled = i.DimensionEnabled
    DimensionName = i.DimensionName
    DimensionOperator = i.DimensionOperator
    DimensionValue = i.DimensionValue

  } }

}

output "AppSvcAlertList" {
  value = local.AppSvcAlertsList
}

output "AppSvcAlertsMap" {
  value = local.AppSvcAlertsMap
}



