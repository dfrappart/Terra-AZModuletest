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
      #backend_address_pool,
      #backend_http_settings,
      #frontend_port,
      #http_listener,
      #probe,
      #request_routing_rule

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

  #################################
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

  frontend_port {
    name = "agw-fpt-pub-80${var.AGWSuffix}"
    port = 80
  }

  frontend_port {
    name = "agw-fpt-priv-80${var.AGWSuffix}"
    port = 81
  }

  #################################
  # Default BE config

  backend_address_pool {
    name = local.DefaultAgwConfig.DefaultAgwBePool

  }

  backend_http_settings {
    name                  = local.DefaultAgwConfig.DefaultAgwBhs
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"

  }

  http_listener {
    name                           = local.DefaultAgwConfig.DefaultAgwLst
    frontend_ip_configuration_name = "agw-fip-prv-${var.AGWSuffix}"
    frontend_port_name             = "agw-fpt-priv-80${var.AGWSuffix}"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.DefaultAgwConfig.DefaultAgwrule
    rule_type                  = "Basic"
    http_listener_name         = local.DefaultAgwConfig.DefaultAgwLst
    backend_address_pool_name  = local.DefaultAgwConfig.DefaultAgwBePool
    backend_http_settings_name = local.DefaultAgwConfig.DefaultAgwBhs
    priority                   = 1000

  }

  #################################
  # settings for ssl certificate

  dynamic "trusted_root_certificate" {
    for_each = var.TrustedRootCertificates

    content {
      name                = trusted_root_certificate.value.CertName
      key_vault_secret_id = trusted_root_certificate.value.CertKvSecretId
      data                = trusted_root_certificate.value.CertData

    }
  }

  #################################
  # settings for back end pool

  dynamic "backend_address_pool" {
    for_each = var.SitesConf
    iterator = each
    content {
      name         = each.value.BePoolName == "" ? "be-pool-${each.value.HostName}" : each.value.BePoolName
      fqdns        = each.value.BePoolInternalFqdns
      ip_addresses = each.value.BePoolIps
    }
  }




  # settings for backend http settings

  dynamic "backend_http_settings" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                           = each.value.BhsName == "" ? "bhs-${each.value.HostName}" : each.value.BhsName
      cookie_based_affinity          = each.value.BhsCookieBasedAffinityConfig
      affinity_cookie_name           = each.value.BhsAffinityCookieName
      port                           = each.value.BhsPort
      protocol                       = each.value.BhsProtocol
      request_timeout                = each.value.BhsRequestTimeOut
      probe_name                     = each.value.EnableProbe ? (each.value.ProbeName == "" ? "probe-${each.value.HostName}" : each.value.ProbeName) : null
      trusted_root_certificate_names = each.value.BhsTrustedRootCert
      host_name                      = each.value.BhsHostName == "" ? each.value.HostName : each.value.BhsHostName
    }
  }

  # settings for http listener
  dynamic "http_listener" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                           = each.value.LstName == "" ? "lsn-${each.value.HostName}" : each.value.LstName
      frontend_ip_configuration_name = "agw-fip-pub${var.AGWSuffix}"
      frontend_port_name             = each.value.LstProtocol == "Http" ? "agw-fpt-pub-80${var.AGWSuffix}" : "agw-fpt-pub-${var.FrontEndPort}${var.AGWSuffix}"
      protocol                       = each.value.LstProtocol
      ssl_certificate_name           = each.value.LstProtocol == "Http" ? null : each.value.SslCertName
      host_name                      = each.value.HostName
      firewall_policy_id             = each.value.LstFirewallPolicyId
    }
  }

  # settings for request routing rule

  dynamic "request_routing_rule" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                       = each.value.ReqRuleName == "" ? "rule-${each.value.HostName}" : each.value.ReqRuleName
      rule_type                  = "Basic"
      http_listener_name         = each.value.LstName == "" ? "lsn-${each.value.HostName}" : each.value.LstName
      backend_address_pool_name  = each.value.BePoolName == "" ? "be-pool-${each.value.HostName}" : each.value.BePoolName
      backend_http_settings_name = each.value.BhsName == "" ? "bhs-${each.value.HostName}" : each.value.BhsName
      priority                   = each.value.ReqRulePriority
    }
  }

  # settings for probe
  /*
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

*/




  dynamic "ssl_certificate" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                = each.value.SslCertName
      key_vault_secret_id = each.value.SslKvSecretId

    }
  }




  # agw identity

  identity {
    identity_ids = [azurerm_user_assigned_identity.AppGatewayManagedId.id]
    type         = "UserAssigned"
  }

  # Waf Config
  /*
  waf_configuration {
    enabled          = true
    firewall_mode    = var.WafMode #"Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = var.WafRuleSetVersions #3.1

  }
*/
  firewall_policy_id = var.FirewallPolicyId

  tags = local.Tags

  depends_on = [
    azurerm_role_assignment.kvRoleAssignment,
    azurerm_user_assigned_identity.AppGatewayManagedId
  ]

}

# Diagnostic settings for app gw

resource "azurerm_monitor_diagnostic_setting" "AgwDiagSettings" {
  count                      = var.EnabledDiagSettings ? 1 : 0
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