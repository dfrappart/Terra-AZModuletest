
# AKS Cluster Recommanded alerting module

## Module description

- This module allows the deployment of Azure monitor alert for AKS based on the Insight/Container extension.
- It requires that the Identity associated to the cluster is allowed to publish metrics in Azure monitor through a specific role assignment

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| AKSClusId | string | N/A | The Id of the Cluster |
| AKSRGName | string | N/A | The RG for for AKS |
| AKSClusName | string | N/A | The name of the cluster |
| ACG1Id | string | N/A | Resource Id of the 1st action group |
| ResourceOwnerTag | string | That would be me | Tag describing the owner |
| CountryTag | string | fr | Tag describing the Country |
| CostCenterTag | string | lab | Tag describing the Cost Center |
| Company | string | dfitc | The Company owner of the resource |
| Project | string | tfmodule | The name of the project |
| Environment | string | dev | The environment, dev, prod... |
| extra_tags | map | {} | Additional optional tags. |

### Module outputs

N/A

## Exemple configuration

Deploy the following to have a working AKS cluster:

```bash

######################################################################
# configuring alerting recommandation on AKS

module "AKSAlerting1" {
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest/Custom_Modules/IaaS_AKS_ClusterAlerting/"

  #Module variable
  
  AKSClusId                               = data.azurerm_kubernetes_cluster.AKSCluster.id
  AKSRGName                               = data.terraform_remote_state.AKSClus1.outputs.KubeRG
  AKSClusName                             = data.azurerm_kubernetes_cluster.AKSCluster.name
  
  ACG1Id                                  = data.azurerm_monitor_action_group.SubACG.id
  
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

}


```

## Sample display

terraform plan should gives the following output:

```powershell

PS C:\Users\jubei.yagyu\AKSAlerting\> terraform apply -target="module.AKSAlerting1"       

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.AKSAlerting1.azurerm_monitor_metric_alert.CompletedJobCount will be created
  + resource "azurerm_monitor_metric_alert" "CompletedJobCount" {
      + auto_mitigate            = true
      + description              = "aks-azday-CompletedJobCount"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-CompletedJobCount-aks-azday"
      + resource_group_name      = "rsglab"
      + scopes                   = [
          + "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsglab/providers/Microsoft.ContainerService/managedClusters/aks-azday",
        ]
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "k8slab"
          + "Country"       = "fr"
          + "Environment"   = "uat"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "obs"
          + "ResourceOwner" = "That would be me"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT5M"

      + action {
          + action_group_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-azdayazday/providers/microsoft.insights/actionGroups/acg-fr-lab-azday-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        }

      + criteria {
          + aggregation            = "Average"
          + metric_name            = "completedJobsCount"
          + metric_namespace       = "insights.container/pods"
          + operator               = "GreaterThan"
          + skip_metric_validation = false
          + threshold              = 0

          + dimension {
              + name     = "controllerName"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
          + dimension {
              + name     = "kubernetes namespace"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
        }
    }

  # module.AKSAlerting1.azurerm_monitor_metric_alert.ContainerCpuExceededPercentageThreshold will be created
  + resource "azurerm_monitor_metric_alert" "ContainerCpuExceededPercentageThreshold" {
      + auto_mitigate            = true
      + description              = "aks-azday-ContainerCpuExceededPercentageThreshold"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-ContainerCpuExceededPercentageThreshold-aks-azday"
      + resource_group_name      = "rsglab"
      + scopes                   = [
          + "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsglab/providers/Microsoft.ContainerService/managedClusters/aks-azday",
        ]
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "k8slab"
          + "Country"       = "fr"
          + "Environment"   = "uat"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "obs"
          + "ResourceOwner" = "That would be me"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT5M"

      + action {
          + action_group_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-azdayazday/providers/microsoft.insights/actionGroups/acg-fr-lab-azday-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        }

      + criteria {
          + aggregation            = "Average"
          + metric_name            = "cpuExceededPercentage"
          + metric_namespace       = "Insights.Container/containers"
          + operator               = "GreaterThan"
          + skip_metric_validation = false
          + threshold              = 95

          + dimension {
              + name     = "controllerName"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
          + dimension {
              + name     = "kubernetes namespace"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
        }
    }

  # module.AKSAlerting1.azurerm_monitor_metric_alert.ContainermemoryWorkingSetExceededPercentageThreshold will be created
  + resource "azurerm_monitor_metric_alert" "ContainermemoryWorkingSetExceededPercentageThreshold" {
      + auto_mitigate            = true
      + description              = "aks-azday-ContainermemoryWorkingSetExceededPercentageThreshold"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-ContainermemoryWorkingSetExceededPercentageThreshold-aks-azday"
      + resource_group_name      = "rsglab"
      + scopes                   = [
          + "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsglab/providers/Microsoft.ContainerService/managedClusters/aks-azday",
        ]
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "k8slab"
          + "Country"       = "fr"
          + "Environment"   = "uat"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "obs"
          + "ResourceOwner" = "That would be me"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT5M"

      + action {
          + action_group_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-azdayazday/providers/microsoft.insights/actionGroups/acg-fr-lab-azday-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        }

      + criteria {
          + aggregation            = "Average"
          + metric_name            = "memoryWorkingSetExceededPercentage"
          + metric_namespace       = "Insights.Container/containers"
          + operator               = "GreaterThan"
          + skip_metric_validation = false
          + threshold              = 95

          + dimension {
              + name     = "controllerName"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
          + dimension {
              + name     = "kubernetes namespace"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
        }
    }

  # module.AKSAlerting1.azurerm_monitor_metric_alert.FailedPodCountThreshold will be created
  + resource "azurerm_monitor_metric_alert" "FailedPodCountThreshold" {
      + auto_mitigate            = true
      + description              = "aks-azday-FailedPodCountThreshold"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-FailedPodCountThreshold-aks-azday"
      + resource_group_name      = "rsglab"
      + scopes                   = [
          + "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsglab/providers/Microsoft.ContainerService/managedClusters/aks-azday",
        ]
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "k8slab"
          + "Country"       = "fr"
          + "Environment"   = "uat"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "obs"
          + "ResourceOwner" = "That would be me"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT5M"

      + action {
          + action_group_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-azdayazday/providers/microsoft.insights/actionGroups/acg-fr-lab-azday-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        }

      + criteria {
          + aggregation            = "Average"
          + metric_name            = "podCount"
          + metric_namespace       = "insights.container/pods"
          + operator               = "GreaterThan"
          + skip_metric_validation = false
          + threshold              = 0

          + dimension {
              + name     = "Phase"
              + operator = "Include"
              + values   = [
                  + "Failed",
                ]
            }
        }
    }

  # module.AKSAlerting1.azurerm_monitor_metric_alert.NodeNotReadyCountThreshold will be created
  + resource "azurerm_monitor_metric_alert" "NodeNotReadyCountThreshold" {
      + auto_mitigate            = true
      + description              = "aks-azday-NodeNotReadyCountThreshold"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-NodeNotReadyCountThreshold-aks-azday"
      + resource_group_name      = "rsglab"
      + scopes                   = [
          + "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsglab/providers/Microsoft.ContainerService/managedClusters/aks-azday",
        ]
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "k8slab"
          + "Country"       = "fr"
          + "Environment"   = "uat"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "obs"
          + "ResourceOwner" = "That would be me"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT5M"

      + action {
          + action_group_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-azdayazday/providers/microsoft.insights/actionGroups/acg-fr-lab-azday-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        }

      + criteria {
          + aggregation            = "Average"
          + metric_name            = "nodesCount"
          + metric_namespace       = "Insights.Container/nodes"
          + operator               = "GreaterThan"
          + skip_metric_validation = false
          + threshold              = 0

          + dimension {
              + name     = "Status"
              + operator = "Include"
              + values   = [
                  + "NotReady",
                ]
            }
        }
    }

  # module.AKSAlerting1.azurerm_monitor_metric_alert.NodeWorkingSetMemoryPercentageThresholdInsightContainer will be created
  + resource "azurerm_monitor_metric_alert" "NodeWorkingSetMemoryPercentageThresholdInsightContainer" {
      + auto_mitigate            = true
      + description              = "aks-azday-NodeWorkingSetMemoryPercentageThresholdInsightContainer"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-NodeWorkingSetMemoryPercentageThresholdInsightContainer-aks-azday"
      + resource_group_name      = "rsglab"
      + scopes                   = [
          + "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsglab/providers/Microsoft.ContainerService/managedClusters/aks-azday",
        ]
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "k8slab"
          + "Country"       = "fr"
          + "Environment"   = "uat"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "obs"
          + "ResourceOwner" = "That would be me"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT5M"

      + action {
          + action_group_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-azdayazday/providers/microsoft.insights/actionGroups/acg-fr-lab-azday-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        }

      + criteria {
          + aggregation            = "Average"
          + metric_name            = "memoryWorkingSetPercentage"
          + metric_namespace       = "Insights.Container/nodes"
          + operator               = "GreaterThan"
          + skip_metric_validation = false
          + threshold              = 80

          + dimension {
              + name     = "host"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
        }
    }

  # module.AKSAlerting1.azurerm_monitor_metric_alert.OomKilledContainerCountThreshold will be created
  + resource "azurerm_monitor_metric_alert" "OomKilledContainerCountThreshold" {
      + auto_mitigate            = true
      + description              = "aks-azday-OomKilledContainerCountThreshold"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-OomKilledContainerCountThreshold-aks-azday"
      + resource_group_name      = "rsglab"
      + scopes                   = [
          + "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsglab/providers/Microsoft.ContainerService/managedClusters/aks-azday",
        ]
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "k8slab"
          + "Country"       = "fr"
          + "Environment"   = "uat"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "obs"
          + "ResourceOwner" = "That would be me"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT5M"

      + action {
          + action_group_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-azdayazday/providers/microsoft.insights/actionGroups/acg-fr-lab-azday-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        }

      + criteria {
          + aggregation            = "Average"
          + metric_name            = "oomKilledContainerCount"
          + metric_namespace       = "Insights.Container/pods"
          + operator               = "GreaterThan"
          + skip_metric_validation = false
          + threshold              = 0

          + dimension {
              + name     = "controllerName"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
          + dimension {
              + name     = "kubernetes namespace"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
        }
    }

  # module.AKSAlerting1.azurerm_monitor_metric_alert.PVUsagePercentageThreshold will be created
  + resource "azurerm_monitor_metric_alert" "PVUsagePercentageThreshold" {
      + auto_mitigate            = true
      + description              = "aks-azday-PVUsagePercentageThreshold"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-PVUsagePercentageThreshold-aks-azday"
      + resource_group_name      = "rsglab"
      + scopes                   = [
          + "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsglab/providers/Microsoft.ContainerService/managedClusters/aks-azday",
        ]
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "k8slab"
          + "Country"       = "fr"
          + "Environment"   = "uat"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "obs"
          + "ResourceOwner" = "That would be me"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT5M"

      + action {
          + action_group_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-azdayazday/providers/microsoft.insights/actionGroups/acg-fr-lab-azday-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        }

      + criteria {
          + aggregation            = "Average"
          + metric_name            = "pvUsageExceededPercentage"
          + metric_namespace       = "Insights.Container/persistentvolumes"
          + operator               = "GreaterThan"
          + skip_metric_validation = false
          + threshold              = 95

          + dimension {
              + name     = "podName"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
          + dimension {
              + name     = "KubernetesNamespace"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
        }
    }

  # module.AKSAlerting1.azurerm_monitor_metric_alert.PodReadyPercentageThreshold will be created
  + resource "azurerm_monitor_metric_alert" "PodReadyPercentageThreshold" {
      + auto_mitigate            = true
      + description              = "aks-azday-PodReadyPercentageThreshold"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-PodReadyPercentageThreshold-aks-azday"
      + resource_group_name      = "rsglab"
      + scopes                   = [
          + "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsglab/providers/Microsoft.ContainerService/managedClusters/aks-azday",
        ]
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "k8slab"
          + "Country"       = "fr"
          + "Environment"   = "uat"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "obs"
          + "ResourceOwner" = "That would be me"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT5M"

      + action {
          + action_group_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-azdayazday/providers/microsoft.insights/actionGroups/acg-fr-lab-azday-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        }

      + criteria {
          + aggregation            = "Average"
          + metric_name            = "podReadyPercentage"
          + metric_namespace       = "insights.container/pods"
          + operator               = "LessThan"
          + skip_metric_validation = false
          + threshold              = 80

          + dimension {
              + name     = "controllerName"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
          + dimension {
              + name     = "Kubernetes namespace"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
        }
    }

  # module.AKSAlerting1.azurerm_monitor_metric_alert.RestartingContainerCountThreshold will be created
  + resource "azurerm_monitor_metric_alert" "RestartingContainerCountThreshold" {
      + auto_mitigate            = true
      + description              = "aks-azday-RestartingContainerCountThreshold"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-RestartingContainerCountThreshold-aks-azday"
      + resource_group_name      = "rsglab"
      + scopes                   = [
          + "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsglab/providers/Microsoft.ContainerService/managedClusters/aks-azday",
        ]
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "k8slab"
          + "Country"       = "fr"
          + "Environment"   = "uat"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "obs"
          + "ResourceOwner" = "That would be me"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT5M"

      + action {
          + action_group_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-azdayazday/providers/microsoft.insights/actionGroups/acg-fr-lab-azday-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        }

      + criteria {
          + aggregation            = "Average"
          + metric_name            = "restartingContainerCount"
          + metric_namespace       = "Insights.Container/pods"
          + operator               = "GreaterThan"
          + skip_metric_validation = false
          + threshold              = 95

          + dimension {
              + name     = "controllerName"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
          + dimension {
              + name     = "kubernetes namespace"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
        }
    }

Plan: 10 to add, 0 to change, 0 to destroy.

```

## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/aksalerting001.png)

![Illustration 2](./Img/aksalerting002.png)
