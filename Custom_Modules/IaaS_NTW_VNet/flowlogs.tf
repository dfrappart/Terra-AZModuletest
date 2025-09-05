# Flow Logs on Nsgs

resource "azurerm_network_watcher_flow_log" "Flowlogs" {

  #for_each = { for k, v in local.Subnets : k => v if v.EnableFlowlogs == true }

  count = var.Vnet.EnableFlowlogs ? 1 : 0


  network_watcher_name      = local.NetworkWatcherName
  name                      = local.VnetFlowLogName
  location                  = var.Location
  resource_group_name       = local.NetworkWatcherRGName
  #network_security_group_id = azurerm_network_security_group.Nsgs[each.key].id
  target_resource_id = azurerm_virtual_network.Vnet.id
  storage_account_id        = local.StaLogId
  enabled                   = true
  version                   = 2

  retention_policy {
    enabled = true
    days    = 365
  }

  traffic_analytics {
    enabled               = var.IsTrafficAnalyticsEnabled #true
    workspace_id          = data.azurerm_log_analytics_workspace.LawLog[0].workspace_id
    workspace_region      = data.azurerm_log_analytics_workspace.LawLog[0].location
    workspace_resource_id = data.azurerm_log_analytics_workspace.LawLog[0].id
    interval_in_minutes   = 10
  }
}

