#######################################################
# App service plan


resource "azurerm_service_plan" "AppSvcPlan" {
  name                            = var.AppSvcPlan.Name
  location                        = local.AppSvcPlanLocation
  resource_group_name             = local.RgAppSvc
  sku_name                        = var.AppSvcPlan.SkuName
  os_type                         = var.AppSvcPlan.OsType
  app_service_environment_id      = var.AppSvcPlan.AppServiceEnvironmentId
  premium_plan_auto_scale_enabled = var.AppSvcPlan.PremiumPlanAutoScaleEnabled
  per_site_scaling_enabled        = var.AppSvcPlan.PerSiteScalingEnabled
  maximum_elastic_worker_count    = var.AppSvcPlan.MaximumElasticWorkerCount
  worker_count                    = var.AppSvcPlan.WorkerCount
  zone_balancing_enabled          = var.AppSvcPlan.ZoneBalancingEnabled

  tags = merge(var.mandatory_tags, var.optional_tags, var.extra_tags)

}