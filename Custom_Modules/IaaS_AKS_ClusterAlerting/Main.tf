################################################################
#This module allows the creation of an AKS Cluster
################################################################

################################################################
# AKS Alert

resource "azurerm_monitor_metric_alert" "NodeWorkingSetMemoryPercentageThresholdInsightContainer" {


  name                = "malt-NodeWorkingSetMemoryPercentageThresholdInsightContainer-${var.AKSClusName}"
  resource_group_name = var.AKSRGName
  scopes              = [var.AKSClusId]
  description         = "${var.AKSClusName}-NodeWorkingSetMemoryPercentageThresholdInsightContainer"

  criteria {
    metric_namespace = "Insights.Container/nodes"
    metric_name      = "memoryWorkingSetPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80

    dimension {
      name     = "host"
      operator = "Include"
      values   = ["*"]
    }

  }


  action {
    action_group_id = var.ACG1Id
  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}

resource "azurerm_monitor_metric_alert" "NodeNotReadyCountThreshold" {


  name                = "malt-NodeNotReadyCountThreshold-${var.AKSClusName}"
  resource_group_name = var.AKSRGName
  scopes              = [var.AKSClusId]
  description         = "${var.AKSClusName}-NodeNotReadyCountThreshold"

  criteria {
    metric_namespace = "Insights.Container/nodes"
    metric_name      = "nodesCount"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0

    dimension {
      name     = "Status"
      operator = "Include"
      values   = ["NotReady"]
    }


  }


  action {
    action_group_id = var.ACG1Id
  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}

resource "azurerm_monitor_metric_alert" "PVUsagePercentageThreshold" {


  name                = "malt-PVUsagePercentageThreshold-${var.AKSClusName}"
  resource_group_name = var.AKSRGName
  scopes              = [var.AKSClusId]
  description         = "${var.AKSClusName}-PVUsagePercentageThreshold"

  criteria {
    metric_namespace = "Insights.Container/persistentvolumes"
    metric_name      = "pvUsageExceededPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 95

    dimension {
      name     = "podName"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "KubernetesNamespace"
      operator = "Include"
      values   = ["*"]
    }

  }


  action {
    action_group_id = var.ACG1Id
  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}

resource "azurerm_monitor_metric_alert" "PodReadyPercentageThreshold" {


  name                = "malt-PodReadyPercentageThreshold-${var.AKSClusName}"
  resource_group_name = var.AKSRGName
  scopes              = [var.AKSClusId]
  description         = "${var.AKSClusName}-PodReadyPercentageThreshold"

  criteria {
    metric_namespace = "insights.container/pods"
    metric_name      = "podReadyPercentage"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 80

    dimension {
      name     = "controllerName"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "Kubernetes namespace"
      operator = "Include"
      values   = ["*"]
    }

  }


  action {
    action_group_id = var.ACG1Id
  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}

resource "azurerm_monitor_metric_alert" "FailedPodCountThreshold" {


  name                = "malt-FailedPodCountThreshold-${var.AKSClusName}"
  resource_group_name = var.AKSRGName
  scopes              = [var.AKSClusId]
  description         = "${var.AKSClusName}-FailedPodCountThreshold"

  criteria {
    metric_namespace = "insights.container/pods"
    metric_name      = "podCount"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0

    dimension {
      name     = "Phase"
      operator = "Include"
      values   = ["Failed"]
    }


  }


  action {
    action_group_id = var.ACG1Id
  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}



resource "azurerm_monitor_metric_alert" "CompletedJobCount" {


  name                = "malt-CompletedJobCount-${var.AKSClusName}"
  resource_group_name = var.AKSRGName
  scopes              = [var.AKSClusId]
  description         = "${var.AKSClusName}-CompletedJobCount"

  criteria {
    metric_namespace = "insights.container/pods"
    metric_name      = "completedJobsCount"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0

    dimension {
      name     = "controllerName"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "kubernetes namespace"
      operator = "Include"
      values   = ["*"]
    }

  }


  action {
    action_group_id = var.ACG1Id
  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}

resource "azurerm_monitor_metric_alert" "ContainerCpuExceededPercentageThreshold" {


  name                = "malt-ContainerCpuExceededPercentageThreshold-${var.AKSClusName}"
  resource_group_name = var.AKSRGName
  scopes              = [var.AKSClusId]
  description         = "${var.AKSClusName}-ContainerCpuExceededPercentageThreshold"

  criteria {
    metric_namespace = "Insights.Container/containers"
    metric_name      = "cpuExceededPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 95

    dimension {
      name     = "controllerName"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "kubernetes namespace"
      operator = "Include"
      values   = ["*"]
    }

  }


  action {
    action_group_id = var.ACG1Id
  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}

resource "azurerm_monitor_metric_alert" "ContainermemoryWorkingSetExceededPercentageThreshold" {


  name                = "malt-ContainermemoryWorkingSetExceededPercentageThreshold-${var.AKSClusName}"
  resource_group_name = var.AKSRGName
  scopes              = [var.AKSClusId]
  description         = "${var.AKSClusName}-ContainermemoryWorkingSetExceededPercentageThreshold"

  criteria {
    metric_namespace = "Insights.Container/containers"
    metric_name      = "memoryWorkingSetExceededPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 95

    dimension {
      name     = "controllerName"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "kubernetes namespace"
      operator = "Include"
      values   = ["*"]
    }

  }


  action {
    action_group_id = var.ACG1Id
  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}

resource "azurerm_monitor_metric_alert" "RestartingContainerCountThreshold" {


  name                = "malt-RestartingContainerCountThreshold-${var.AKSClusName}"
  resource_group_name = var.AKSRGName
  scopes              = [var.AKSClusId]
  description         = "${var.AKSClusName}-RestartingContainerCountThreshold"

  criteria {
    metric_namespace = "Insights.Container/pods"
    metric_name      = "restartingContainerCount"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 95

    dimension {
      name     = "controllerName"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "kubernetes namespace"
      operator = "Include"
      values   = ["*"]
    }

  }


  action {
    action_group_id = var.ACG1Id
  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}

resource "azurerm_monitor_metric_alert" "OomKilledContainerCountThreshold" {


  name                = "malt-OomKilledContainerCountThreshold-${var.AKSClusName}"
  resource_group_name = var.AKSRGName
  scopes              = [var.AKSClusId]
  description         = "${var.AKSClusName}-OomKilledContainerCountThreshold"

  criteria {
    metric_namespace = "Insights.Container/pods"
    metric_name      = "oomKilledContainerCount"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0

    dimension {
      name     = "controllerName"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "kubernetes namespace"
      operator = "Include"
      values   = ["*"]
    }

  }


  action {
    action_group_id = var.ACG1Id
  }


  frequency   = "PT1M"
  window_size = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}

