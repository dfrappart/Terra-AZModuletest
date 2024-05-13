

###################################################################################
# Public Ip for Application Gateway

resource "azurerm_public_ip" "AppGWPIP" {
  name                = "pubip-agw${var.AGWSuffix}"
  location            = var.TargetLocation
  resource_group_name = local.RgName
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "pubip-agw${lower(var.AGWSuffix)}"
  zones               = var.AZList


  tags = local.Tags
}

#Diagnostic settings on the AppGW pip

resource "azurerm_monitor_diagnostic_setting" "PubIpAgwDiagSettings" {
  count                      = var.EnabledDiagSettings ? 1 : 0
  name                       = format("%s-%s", "diag", azurerm_public_ip.AppGWPIP.name)
  storage_account_id         = local.StaLogId
  log_analytics_workspace_id = local.LawLogId
  target_resource_id         = azurerm_public_ip.AppGWPIP.id


  dynamic "enabled_log" {
    for_each = local.PubIpLogCategories
    content {
      category = enabled_log.value

      #retention_policy {
      #  enabled = true
      #}
    }
  }

  dynamic "metric" {
    for_each = local.PubIpMetricCategories
    content {
      category = metric.value

      #retention_policy {
      #  enabled = true
      #}
    }
  }

}
