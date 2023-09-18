

###################################################################################
# Public Ip for Application Gateway

resource "azurerm_public_ip" "AppGWPIP" {
  name                                  = "pubip-agw${var.AGWSuffix}"
  location                              = var.TargetLocation
  resource_group_name                   = var.TargetRG
  allocation_method                     = "Static"
  sku                                   = "Standard"
  domain_name_label                     = "pubip-agw${lower(var.AGWSuffix)}"
  zones                                 = var.AZList


  tags = local.Tags
}

#Diagnostic settings on the AppGW pip

resource "azurerm_monitor_diagnostic_setting" "PubIpAgwDiagSettings" {
  name                                  = format("%s-%s", "diag",azurerm_public_ip.AppGWPIP.name)
  storage_account_id                    = var.STASubLogId
  log_analytics_workspace_id            = var.LawSubLogId
  target_resource_id                    = azurerm_public_ip.AppGWPIP.id


  dynamic "enabled_log" {
    for_each = local.PubIpLogCategories
    content {
      category = enabled_log.value
      #enabled  = true #length(var.logs) == 0 ? true : (contains(var.logs, log.value) ? true : false)

      retention_policy {
        enabled = true
      }
    }
  }

  dynamic "metric" {
    for_each = local.PubIpMetricCategories
    content {
      category = metric.value
      #enabled  = true #length(var.metrics) == 0 ? true : (contains(var.metrics, metric.value) ? true : false)

      retention_policy {
        enabled = true
      }
    }
  }

}
