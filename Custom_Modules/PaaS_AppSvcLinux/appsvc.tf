##################################################################################
# App service


resource "azurerm_linux_web_app" "App" {

  for_each = var.AppSvc

  name                          = each.value.Name
  location                      = var.AppSvcPlan.Location
  resource_group_name           = local.RgAppSvc
  service_plan_id               = azurerm_service_plan.AppSvcPlan.id
  public_network_access_enabled = each.value.PublicNetworkAccessEnabled
  virtual_network_subnet_id     = each.value.EnableVnetIntegration ? each.value.VnetSubnetId : null
  https_only                    = each.value.HttpsOnly




  site_config {
    always_on             = each.value.SiteConfigAlwaysOn
    api_definition_url    = null
    api_management_api_id = each.value.SiteConfigApiMgmtApiId
    app_command_line      = each.value.SiteConfigAppCommandLine

    application_stack {
      docker_image_name        = each.value.SiteConfigAppStackDockerImageName
      docker_registry_url      = each.value.SiteConfigAppStackDockerRegistryUrl
      docker_registry_username = each.value.SiteConfigAppStackDockerRegistryUsername
      docker_registry_password = each.value.SiteConfigAppStackDockerRegistryPassword
    }

    #auto_heal_setting {}

    container_registry_managed_identity_client_id = each.value.SiteConfigContainerRegistryManagedIdentityClientId
    container_registry_use_managed_identity       = each.value.SiteConfigContainerRegistryUseManagedIdentity

    #cors {}

    default_documents                 = []
    ftps_state                        = each.value.SiteConfigFtpsState
    health_check_path                 = each.value.SiteConfigHealthCheckPath
    health_check_eviction_time_in_min = each.value.SiteConfigHealthCheckEvictionTimeInMinutes
    http2_enabled                     = each.value.SiteConfigHttp2Enabled

    dynamic "ip_restriction" {
      for_each = toset(each.value.SiteConfigAllowedIps)

      iterator = each

      content {
        action     = "Allow"
        ip_address = each.key

      }
    }

    ip_restriction_default_action = each.value.SiteConfigIpRestrictionDefaultAction
    load_balancing_mode           = each.value.SiteConfigLoadBalancingMode
    local_mysql_enabled           = each.value.SiteConfigLocalMySqlEnabled
    managed_pipeline_mode         = each.value.SiteConfigManagedPipelineMode
    minimum_tls_version           = each.value.SiteConfigMinTlsVersion
    #remote_debugging_enabled      = each.value.SiteConfigRemoteDebuggingEnabled
    #remote_debugging_version      = each.value.SiteConfigRemoteDebuggingVersion

    dynamic "scm_ip_restriction" {
      for_each = toset(each.value.SiteConfigScmAllowedIps)

      iterator = each

      content {
        action     = "Allow"
        ip_address = each.key
      }
    }

    scm_ip_restriction_default_action = each.value.SiteConfigScmIpRestrictionDefaultAction
    scm_use_main_ip_restriction       = each.value.SiteConfigScmUseMainIpRestriction
    use_32_bit_worker                 = each.value.SiteConfigUse32BitWorker
    vnet_route_all_enabled            = each.value.SiteConfigVnetRouteAllEnabled
    websockets_enabled                = each.value.SiteConfigWebSocketsEnabled
    worker_count                      = each.value.SiteConfigWorkerCount


  }
}