###################################################################################
############################## Application Gateway ################################
###################################################################################

###################################################################################
#Creating AG User Assigned Managed identity

resource "azurerm_user_assigned_identity" "AppGatewayManagedId" {
  resource_group_name                   = var.TargetRG
  location                              = var.TargetLocation
  name                                  = "uai-agw${var.AGWSuffix}"

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Project                             = var.Project
    Environment                         = var.Environment
    ManagedBy                           = "Terraform"
  }
}

###################################################################################
#Creating access policy for uai

resource "azurerm_key_vault_access_policy" "KeyVaultAccessPolicy01" {
   key_vault_id                        = var.KVId
   tenant_id                           = data.azurerm_subscription.current.tenant_id
   object_id                           = azurerm_user_assigned_identity.AppGatewayManagedId.principal_id
   certificate_permissions             = [
       "Get",
       "List",
   ]
   key_permissions                     = []
   secret_permissions                  = [
       "Get",
       "List",
     ]   
}

###################################################################################
# Public Ip for Application Gateway

resource "azurerm_public_ip" "AppGWPIP" {
  name                                  = "pubip-agw${var.AGWSuffix}"
  location                              = var.TargetLocation
  resource_group_name                   = var.TargetRG
  allocation_method                     = "Static"
  sku                                   = "standard"
  domain_name_label                     = "pubip-agw${lower(var.AGWSuffix)}"


  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Project                             = var.Project
    Environment                         = var.Environment
    ManagedBy                           = "Terraform"
  }
}

#Diagnostic settings on the AppGW pip

resource "azurerm_monitor_diagnostic_setting" "AppGWPIPDiag" {
  name                                  = "${azurerm_public_ip.AppGWPIP.name}diag"
  target_resource_id                    = azurerm_public_ip.AppGWPIP.id
  storage_account_id                    = var.STASubLogId
  log_analytics_workspace_id            = var.LawSubLogId

  log {
    category                            = "DDoSProtectionNotifications"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "DDoSMitigationFlowLogs"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "DDoSMitigationReports"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  metric {
    category                            = "AllMetrics"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    }    

  }
}


# Creating Azure Application Gateway

resource "azurerm_application_gateway" "AGW" {

  lifecycle {
    ignore_changes                        = [
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

  name                                  = "agw${var.AGWSuffix}"
  resource_group_name                   = var.TargetRG
  location                              = var.TargetLocation
  zones                                 = var.AZList

  sku {
    name                                = var.AppGatewaySkuName
    tier                                = var.AppGatewaySkuTier
  }

  autoscale_configuration {
    min_capacity                        = 1
    max_capacity                        = 10
  }

  gateway_ip_configuration {
    name                                = "agw-ipcfg${var.AGWSuffix}"
    subnet_id                           = var.TargetSubnetId
  }

# Front End IP Configruration

  frontend_ip_configuration {
    name                                = "agw-fip-pub${var.AGWSuffix}"
    public_ip_address_id                = azurerm_public_ip.AppGWPIP.id
  }

# settings for front end
/*
  dynamic "frontend_port" {
    for_each = var.FrontEndPorts
    iterator = each
    content {
      name                              = "agw-fpt-pub-${each.value.FrontEndPort}${var.AGWSuffix}"
      port                              = each.value.FrontEndPort
    }
  }
*/

  frontend_port {
    name                                = "agw-fpt-pub-${var.FrontEndPort}${var.AGWSuffix}"
    port                                = var.FrontEndPort
  }

#################################
# settings for back end pool

  dynamic "backend_address_pool" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                              = "agw-bck-${var.AGWSuffix}${each.value.SiteIdentifier}"
    }
  }


# settings for probe

  dynamic "probe" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                                = "agw-prb-pub-${var.ProbePort}${each.value.SiteIdentifier}"
      host                                = var.ProbeHost
      interval                            = var.ProbeInterval
      protocol                            = var.ProbeProtocol
      path                                = var.ProbePath
      timeout                             = var.ProbeTimeOut
      unhealthy_threshold                 = var.ProbeUnhealthyThreshold
      port                                = var.ProbePort      
    }    
  }

# settings for backend http settings

  dynamic "backend_http_settings" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                                = "agw-bhs-pub-${var.BHSPort}${each.value.SiteIdentifier}"
      cookie_based_affinity               = var.BHSCookieConfig
      port                                = var.BHSPort
      protocol                            = var.BHSProtocol
      request_timeout                     = var.BEHTTPSettingsRequestTimeOut
      probe_name                          = "agw-prb-pub-${var.ProbePort}${each.value.SiteIdentifier}"      
    }    
  }

# settings for ssl certificate

  dynamic "ssl_certificate" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                                = each.value.AppGWSSLCertNameSite
      key_vault_secret_id                 = each.value.AppGwPublicCertificateSecretIdentifierSite
  
    }
  }


# settings for http listener
  dynamic "http_listener" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                                = "agw-lsn-pub-${var.FrontEndPort}${var.AGWSuffix}${each.value.SiteIdentifier}"
      frontend_ip_configuration_name      = "agw-fip-pub${var.AGWSuffix}"
      frontend_port_name                  = "agw-fpt-pub-${var.FrontEndPort}${var.AGWSuffix}"
      protocol                            = "Https"
      ssl_certificate_name                = each.value.AppGWSSLCertNameSite
      host_name                           = each.value.HostnameSite      
    } 
  }

# settings for request routing rule

  dynamic "request_routing_rule" {
    for_each = var.SitesConf
    iterator = each
    content {
      name                                = "agw-rul-pub${var.AGWSuffix}${each.value.SiteIdentifier}"
      rule_type                           = "Basic"
      http_listener_name                  = "agw-lsn-pub-${var.FrontEndPort}${var.AGWSuffix}${each.value.SiteIdentifier}"
      backend_address_pool_name           = "agw-bck-${var.AGWSuffix}${each.value.SiteIdentifier}"
      backend_http_settings_name          = "agw-bhs-pub-${var.BHSPort}${each.value.SiteIdentifier}"      
    }    
  }

# agw identity

  identity {
    identity_ids                        = [azurerm_user_assigned_identity.AppGatewayManagedId.id]
  }

# Waf Config

  waf_configuration {
    enabled                             = true
    firewall_mode                       = var.WafMode #"Prevention"
    rule_set_type                       = "OWASP"
    rule_set_version                    = var.WafRuleSetVersions #3.1

  }

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Project                             = var.Project
    Environment                         = var.Environment
    ManagedBy                           = "Terraform"
  }

}

# Diagnostic settings for app gw


resource "azurerm_monitor_diagnostic_setting" "AppGWDiag" {
  name                                  = "${azurerm_application_gateway.AGW.name}diag"
  target_resource_id                    = azurerm_application_gateway.AGW.id
  storage_account_id                    = var.STASubLogId
  log_analytics_workspace_id            = var.LawSubLogId

  log {
    category                            = "ApplicationGatewayAccessLog"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "ApplicationGatewayPerformanceLog"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "ApplicationGatewayFirewallLog"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  metric {
    category                            = "AllMetrics"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    }    

  }

}
