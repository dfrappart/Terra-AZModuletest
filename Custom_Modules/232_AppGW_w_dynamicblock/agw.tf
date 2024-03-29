###################################################################################
############################## Application Gateway ################################
###################################################################################



###################################################################################
# Creating Azure Application Gateway

resource "azurerm_application_gateway" "AGW" {

  lifecycle {
    ignore_changes = [
      #Ignore change for node count since it is autoscaling
      tags,
      backend_address_pool,
      backend_http_settings,
      frontend_port,
      http_listener,
      probe,
      request_routing_rule

    ]
  }

  name                = "agw${var.AGWSuffix}"
  resource_group_name = local.RgName
  location            = var.TargetLocation
  zones               = var.AZList

  sku {
    name = var.AppGatewaySkuName
    tier = var.AppGatewaySkuTier
  }

  autoscale_configuration {
    min_capacity = 1
    max_capacity = 10
  }

  gateway_ip_configuration {
    name      = "agw-ipcfg${var.AGWSuffix}"
    subnet_id = var.TargetSubnetId
  }

  # Front End IP Configruration

  frontend_ip_configuration {
    name                 = "agw-fip-pub${var.AGWSuffix}"
    public_ip_address_id = azurerm_public_ip.AppGWPIP.id
  }

  frontend_ip_configuration {
    name                          = "agw-fip-prv-${var.AGWSuffix}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.TargetSubnetAddressPrefix, var.AppGwPrivateFrontendIpAddressHostnum)
    subnet_id                     = var.TargetSubnetId
  }

  frontend_port {
    name = "agw-fpt-pub-${var.FrontEndPort}${var.AGWSuffix}"
    port = var.FrontEndPort
  }

  #################################
  # settings for back end pool

  dynamic "backend_address_pool" {
    for_each = var.SitesConf
    iterator = each
    content {
      name = "agw-bck-${var.AGWSuffix}${each.value.SiteIdentifier}"
    }
  }


  # settings for probe

  dynamic "probe" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                = "agw-prb-pub-${var.ProbePort}${each.value.SiteIdentifier}"
      host                = var.ProbeHost
      interval            = var.ProbeInterval
      protocol            = var.ProbeProtocol
      path                = var.ProbePath
      timeout             = var.ProbeTimeOut
      unhealthy_threshold = var.ProbeUnhealthyThreshold
      port                = var.ProbePort
    }
  }

  # settings for backend http settings

  dynamic "backend_http_settings" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                  = "agw-bhs-pub-${var.BHSPort}${each.value.SiteIdentifier}"
      cookie_based_affinity = var.BHSCookieConfig
      port                  = var.BHSPort
      protocol              = var.BHSProtocol
      request_timeout       = var.BEHTTPSettingsRequestTimeOut
      probe_name            = "agw-prb-pub-${var.ProbePort}${each.value.SiteIdentifier}"
    }
  }

  # settings for ssl certificate

  dynamic "ssl_certificate" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                = each.value.AppGWSSLCertNameSite
      key_vault_secret_id = each.value.AppGwPublicCertificateSecretIdentifierSite

    }
  }


  # settings for http listener
  dynamic "http_listener" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                           = "agw-lsn-pub-${var.FrontEndPort}${var.AGWSuffix}${each.value.SiteIdentifier}"
      frontend_ip_configuration_name = "agw-fip-pub${var.AGWSuffix}"
      frontend_port_name             = "agw-fpt-pub-${var.FrontEndPort}${var.AGWSuffix}"
      protocol                       = "Https"
      ssl_certificate_name           = each.value.AppGWSSLCertNameSite
      host_name                      = each.value.HostnameSite
    }
  }

  # settings for request routing rule

  dynamic "request_routing_rule" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                       = "agw-rul-pub${var.AGWSuffix}${each.value.SiteIdentifier}"
      rule_type                  = "Basic"
      http_listener_name         = "agw-lsn-pub-${var.FrontEndPort}${var.AGWSuffix}${each.value.SiteIdentifier}"
      backend_address_pool_name  = "agw-bck-${var.AGWSuffix}${each.value.SiteIdentifier}"
      backend_http_settings_name = "agw-bhs-pub-${var.BHSPort}${each.value.SiteIdentifier}"
      priority                   = each.value.RoutingRulePriority
    }
  }

  # agw identity

  identity {
    identity_ids = [azurerm_user_assigned_identity.AppGatewayManagedId.id]
    type         = "UserAssigned"
  }

  # Waf Config

  waf_configuration {
    enabled          = true
    firewall_mode    = var.WafMode #"Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = var.WafRuleSetVersions #3.1

  }

  tags = local.Tags

  depends_on = [
    azurerm_key_vault_access_policy.KeyVaultAccessPolicy01,
    azurerm_user_assigned_identity.AppGatewayManagedId
  ]

}

# Diagnostic settings for app gw

resource "azurerm_monitor_diagnostic_setting" "AgwDiagSettings" {
  count = var.EnabledDiagSettings ? 1 : 0
  name                       = format("diag-%s", azurerm_application_gateway.AGW.name)
  storage_account_id         = local.StaLogId
  log_analytics_workspace_id = local.LawLogId
  target_resource_id         = azurerm_application_gateway.AGW.id


  dynamic "enabled_log" {
    for_each = local.AgwLogCategories
    content {
      category = enabled_log.value

      #retention_policy {
      #  enabled = true
      #}
    }
  }

  dynamic "metric" {
    for_each = local.AgwMetricCategories
    content {
      category = metric.value

      #retention_policy {
      #  enabled = true
      #}
    }
  }

}