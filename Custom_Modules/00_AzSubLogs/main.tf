###################################################################
#This module creates the basic resources for logging and monitoring
###################################################################

locals {

  STAPrefix                           = "st${lower(var.Company)}${lower(var.CountryTag)}${lower(var.Environment)}${substr(var.SubId, 0, 8)}"
  ResourcePrefix                      = "${lower(var.Company)}${lower(var.CountryTag)}-${lower(var.Environment)}-${lower(var.Project)}"
}

#Resource Group creation


resource "azurerm_resource_group" "RGLogs" {

    
  name                                = "rsg-${local.ResourcePrefix}${lower(var.SubLogSuffix)}"
  location                            = var.RGLogLocation

  tags = {
    ResourceOwner                 = var.ResourceOwnerTag
    Country                       = var.CountryTag
    CostCenter                    = var.CostCenterTag
    ManagedBy                     = "Terraform"
  }

}

#Storage account creation for Diagnostic logs

resource "azurerm_storage_account" "STALog" {
  name                                = "${local.STAPrefix}${lower(var.SubLogSuffix)}"
  resource_group_name                 = azurerm_resource_group.RGLogs.name
  location                            = azurerm_resource_group.RGLogs.location
  account_tier                        = "Standard"
  account_replication_type            = "LRS"
  account_kind                        = "StorageV2"
  enable_https_traffic_only           = true

  tags = {
    ResourceOwner                 = var.ResourceOwnerTag
    Country                       = var.CountryTag
    CostCenter                    = var.CostCenterTag
    ManagedBy                     = "Terraform"
  }
}

#Log analytics workspace

resource "azurerm_log_analytics_workspace" "SubLogAnalyticsWS" {
  name                = "law-${local.ResourcePrefix}${lower(var.SubLogSuffix)}${substr(var.SubId, 0, 8)}"
  location            = azurerm_resource_group.RGLogs.location
  resource_group_name = azurerm_resource_group.RGLogs.name
  sku                 = var.LAWSku
  retention_in_days   = var.LAWRetention
  


  tags = {
    ResourceOwner                 = var.ResourceOwnerTag
    Country                       = var.CountryTag
    CostCenter                    = var.CostCenterTag
    ManagedBy                     = "Terraform"
  }
}

# Diag settings for subscription 
#Will probably replace the activity logs with powershell script

#Diagnostic settings on the Automation account

data "azurerm_subscription" "TargetSub" {
  subscription_id                     = var.SubId
}

resource "azurerm_monitor_diagnostic_setting" "AZSubDiag" {
  name                                = "${data.azurerm_subscription.TargetSub.subscription_id}diag"
  target_resource_id                  = data.azurerm_subscription.TargetSub.id
  storage_account_id                  = azurerm_storage_account.STALog.id
  log_analytics_workspace_id          = azurerm_log_analytics_workspace.SubLogAnalyticsWS.id


  log {
    category                          = "Administrative"
    enabled                           = true
    retention_policy {
      enabled                         = true
      days                            = 365
    } 
  }

  log {
    category                          = "Security"
    enabled                           = true
    retention_policy {
      enabled                         = true
      days                            = 365
    } 
  }

  log {
    category                          = "ServiceHealth"
    enabled                           = true
    retention_policy {
      enabled                         = true
      days                            = 365
    } 
  }

  log {
    category                          = "Alert"
    enabled                           = true
    retention_policy {
      enabled                         = true
      days                            = 365
    } 
  }

  log {
    category                          = "Recommendation"
    enabled                           = true
    retention_policy {
      enabled                         = true
      days                            = 365
    } 
  }

  log {
    category                          = "Policy"
    enabled                           = true
    retention_policy {
      enabled                         = true
      days                            = 365
    } 
  }

  log {
    category                          = "Autoscale"
    enabled                           = true
    retention_policy {
      enabled                         = true
      days                            = 365
    } 
  }

  log {
    category                          = "ResourceHealth"
    enabled                           = true
    retention_policy {
      enabled                         = true
      days                            = 365
    } 
  }



}