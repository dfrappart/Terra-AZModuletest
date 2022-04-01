##############################################################
#This module allows the creation of a storage account
##############################################################

##############################################################
# STA Creation

resource "azurerm_storage_account" "STOA" {
  name                                  = "st${lower(var.STASuffix)}"
  resource_group_name                   = var.RGName
  location                              = var.StorageAccountLocation
  account_tier                          = var.StorageAccountTier
  account_replication_type              = var.StorageReplicationType
  account_kind                          = var.StorageAccoutKind
  access_tier                           = var.StorageAccessTier
  enable_https_traffic_only             = var.HTTPSSetting
  min_tls_version                       = var.TLSVer
  is_hns_enabled                        = var.IsHNSEnabled

  tags = merge(var.DefaultTags,var.ExtraTags)

}


##############################################################
# STA diag nostic settings Creation

resource "azurerm_monitor_diagnostic_setting" "STADiag_ToSTA" {
  count                                 = var.STALogId != "unspecified" ? 1: 0
  name                                  = "${azurerm_storage_account.STOA.name}diagto-sta"
  target_resource_id                    = azurerm_storage_account.STOA.id
  storage_account_id                    = var.STALogId
/*
  dynamic "log" {
    for_each                            = var.LogCategories

    content {
      category                              = log.value.LogCatName
      enabled                               = log.value.IsLogCatEnabledForSTA

      retention_policy {
        enabled                                 = log.value.IsRetentionEnabled
        days                                    = log.value.RetentionDaysValue
      }
    }
  }
*/
  dynamic "metric" {
    for_each                            = var.MetricCategories

    content {

    category                                = metric.value.MetricCatName
    enabled                                 = metric.value.IsMetricCatEnabledForSTA
      retention_policy {
        enabled                                 = metric.value.IsRetentionEnabled
        days                                    = metric.value.RetentionDaysValue
      }

    }
    

  }
}

resource "azurerm_monitor_diagnostic_setting" "STADiag_ToLAW" {
  count                                 = var.LawLogId != "unspecified" ? 1 : 0
  name                                  = "${azurerm_storage_account.STOA.name}diag-to-law"
  target_resource_id                    = azurerm_storage_account.STOA.id
  log_analytics_workspace_id            = var.LawLogId
/*
  dynamic "log" {
    for_each                            = var.LogCategories

    content {
      category                              = log.value.LogCatName
      enabled                               = log.value.IsLogCatEnabledForLAW

    }
  }
*/
  dynamic "metric" {
    for_each                            = {
      for k,v in var.MetricCategories : k=>v if v.IsMetricCatEnabledForLAW == true
    }

    content {

    category                                = metric.value.MetricCatName
    enabled                                 = metric.value.IsMetricCatEnabledForLAW

    }
    

  }
}

/*
resource "azurerm_monitor_diagnostic_setting" "STABlobDiag_ToLAW" {
  count                                 = var.LawLogId != "unspecified" ? 1 : 0
  name                                  = "${azurerm_storage_account.STOA.name}diag-to-law"
  target_resource_id                    = "${azurerm_storage_account.STOA.id}/blob"
  log_analytics_workspace_id            = var.LawLogId

  dynamic "log" {
    for_each                            = var.LogCategories

    content {
      category                              = log.value.LogCatName
      enabled                               = log.value.IsLogCatEnabledForLAW

    }
  }

  dynamic "metric" {
    for_each                            = {
      for k,v in var.MetricCategories : k=>v if v.IsMetricCatEnabledForLAW == true
    }

    content {

    category                                = metric.value.MetricCatName
    enabled                                 = metric.value.IsMetricCatEnabledForLAW

    }
    

  }
}
*/
##############################################################
# STA Network rules creation
resource "azurerm_storage_account_network_rules" "STANTWDefaultRule" {
  storage_account_id = azurerm_storage_account.STOA.id

  default_action                       = "Deny"
  ip_rules                             = var.AllowedIPList
  virtual_network_subnet_ids           = var.AllowedSubnetIdList
  bypass                               = var.ByPassConfig
}