######################################################################
# Requirement for monitoring
######################################################################

######################################################################
# Mapping OMS UAI to Azure monitor publisher role

resource "azurerm_role_assignment" "MSToMonitorPublisher" {
  count = local.IsOMSAgentEnabled ? 1 : 0

  scope                = azurerm_kubernetes_cluster.AKS.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_kubernetes_cluster.AKS.oms_agent[0].oms_agent_identity[0].object_id
}


################################################################
# AKS Alert


resource "azurerm_monitor_metric_alert" "NodeCPUPercentageThreshold" {

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  name                = "malt-NodeCPUPercentageThreshold-${azurerm_kubernetes_cluster.AKS.name}"
  resource_group_name = var.AKSRGName
  scopes              = [azurerm_kubernetes_cluster.AKS.id]
  description         = "${azurerm_kubernetes_cluster.AKS.name}-NodeCPUPercentageThreshold"

  criteria {
    metric_namespace = "MICROSOFT.CONTAINERSERVICE/MANAGEDCLUSTERS"
    metric_name      = "node_cpu_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80



  }


  dynamic "action" {
    for_each = toset(var.ACGIds)
    iterator = each

    content {
      action_group_id = each.key
    }

  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = local.Tags

}

resource "azurerm_monitor_metric_alert" "NodeDiskPercentageThreshold" {
  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  name                = "malt-NodeDiskPercentageThreshold-${azurerm_kubernetes_cluster.AKS.name}"
  resource_group_name = var.AKSRGName
  scopes              = [azurerm_kubernetes_cluster.AKS.id]
  description         = "${azurerm_kubernetes_cluster.AKS.name}-NodeDiskPercentageThreshold"

  criteria {
    metric_namespace = "MICROSOFT.CONTAINERSERVICE/MANAGEDCLUSTERS"
    metric_name      = "node_disk_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80


  }


  dynamic "action" {
    for_each = toset(var.ACGIds)
    iterator = each

    content {
      action_group_id = each.key
    }

  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = local.Tags

}


resource "azurerm_monitor_metric_alert" "NodeWorkingSetMemoryPercentageThreshold" {
  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  name                = "malt-NodeWorkingSetMemoryPercentageThreshold-${azurerm_kubernetes_cluster.AKS.name}"
  resource_group_name = var.AKSRGName
  scopes              = [azurerm_kubernetes_cluster.AKS.id]
  description         = "${azurerm_kubernetes_cluster.AKS.name}-NodeWorkingSetMemoryPercentageThreshold"

  criteria {
    metric_namespace = "MICROSOFT.CONTAINERSERVICE/MANAGEDCLUSTERS"
    metric_name      = "node_memory_working_set_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80


  }


  dynamic "action" {
    for_each = toset(var.ACGIds)
    iterator = each

    content {
      action_group_id = each.key
    }

  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = local.Tags

}


resource "azurerm_monitor_metric_alert" "UnschedulablePodCountThreshold" {
  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  name                = "malt-UnschedulablePodCountThreshold-${azurerm_kubernetes_cluster.AKS.name}"
  resource_group_name = var.AKSRGName
  scopes              = [azurerm_kubernetes_cluster.AKS.id]
  description         = "${azurerm_kubernetes_cluster.AKS.name}-UnschedulablePodCountThreshold"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "cluster_autoscaler_unschedulable_pods_count"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0

  }


  dynamic "action" {
    for_each = toset(var.ACGIds)
    iterator = each

    content {
      action_group_id = each.key
    }

  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = local.Tags

}


resource "azurerm_monitor_activity_log_alert" "ListAKSAdminCredsEvent" {
  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  name                = "malt-ListAKSAdminCredsEvent-${azurerm_kubernetes_cluster.AKS.name}"
  resource_group_name = var.AKSRGName
  scopes              = [azurerm_kubernetes_cluster.AKS.id]
  description         = "${azurerm_kubernetes_cluster.AKS.name}-ListAKSAdminCredsEvent"
  location            = "global"

  criteria {
    resource_id    = azurerm_kubernetes_cluster.AKS.id
    operation_name = "Microsoft.ContainerService/managedClusters/listClusterAdminCredential/action"
    category       = "Administrative"

  }


  dynamic "action" {
    for_each = toset(var.ACGIds)
    iterator = each

    content {
      action_group_id = each.key
    }

  }




  tags = local.Tags

}

