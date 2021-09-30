################################################################
#This module allows the creation of an AKS Cluster
################################################################



################################################################
#Creating the AKS Cluster with RBAC Enabled and AAD integration

resource "azurerm_kubernetes_cluster" "AKSRBACKubenet" {

  lifecycle {
    ignore_changes                        = [
      #Ignore change for node count since it is autoscaling
      default_node_pool[0].node_count,
      default_node_pool[0].orchestrator_version,
      kubernetes_version,
      addon_profile[0].ingress_application_gateway


    ]
  }
  
  name                                    = local.AKSClusterName
  location                                = var.AKSLocation
  resource_group_name                     = var.AKSRGName

  default_node_pool {
    name                                  = substr(local.AKSDefaultNodePoolName,0,12)
    vm_size                               = var.AKSNodeInstanceType
    availability_zones                    = var.AKSAZ
    enable_auto_scaling                   = var.EnableAKSAutoScale      
    enable_node_public_ip                 = var.EnableNodePublicIP        
    max_pods                              = var.AKSMaxPods
    node_labels                           = var.AKSNodeLabels
    node_taints                           = var.AKSNodeTaints
    os_disk_size_gb                       = var.AKSNodeOSDiskSize  
    vnet_subnet_id                        = var.AKSSubnetId
    max_count                             = var.MaxAutoScaleCount
    min_count                             = var.MinAutoScaleCount
    node_count                            = var.AKSNodeCount
    orchestrator_version                  = var.KubeVersion

    tags = merge(local.DefaultTags, var.extra_tags)

  }

  dns_prefix                              = var.IsAKSPrivate == true ? null : local.DNSPrefix
  dns_prefix_private_cluster              = var.IsAKSPrivate == true ? local.DNSPrefix : null
  node_resource_group                     = var.UseAKSNodeRGDefaultName ? local.DefaultNodeRGName : local.CustomNodeRGName
  private_cluster_enabled                 = var.IsAKSPrivate
  private_dns_zone_id                     = var.PrivateDNSZoneId


  api_server_authorized_ip_ranges         = var.APIAccessList

  auto_scaler_profile {
    
    balance_similar_node_groups           = var.AutoScaleProfilBalanceSimilarNdGP
    max_graceful_termination_sec          = var.AutoScaleProfilMaxGracefullTerm
    scale_down_delay_after_add            = var.AutoScaleProfilScaleDownAfterAdd
    scale_down_delay_after_delete         = var.AutoScaleProfilScaleDownAfterDelete
    scale_down_delay_after_failure        = var.AutoScaleProfilScaleDownAfterFail
    scan_interval                         = var.AutoScaleProfilScanInterval
    scale_down_unneeded                   = var.AutoScaleProfilScaleDownUnneeded
    scale_down_unready                    = var.AutoScaleProfilScaleDownUnready
    scale_down_utilization_threshold      = var.AutoScaleProfilScaleDownUtilThreshold

  }

  #pod security policy is deprecated in favor of Azure Policy for AKS
  # https://docs.microsoft.com/en-us/azure/aks/use-pod-security-policies
  #enable_pod_security_policy              = var.EnablePodPolicy

  disk_encryption_set_id                  = var.AKSDiskEncryptionId

  #Moving from sp to managed id
  #service_principal {
  #  client_id                             = var.K8SSPId
  #  client_secret                         = var.K8SSPSecret
  #}
  identity {
    type                                  = var.AKSIdentityType
    user_assigned_identity_id             = var.UAIId
  }

  kubernetes_version                      = var.KubeVersion



  linux_profile {
    admin_username                        = var.AKSAdminName

    ssh_key {
      key_data                            = var.PublicSSHKey
    }
  }

  network_profile {
    network_plugin                        = "kubenet"
    network_policy                        = "calico"
    dns_service_ip                        = var.AKSNetworkDNS
    docker_bridge_cidr                    = var.AKSDockerBridgeCIDR
    outbound_type                         = var.AKSOutboundType
    pod_cidr                              = var.AKSPodCIDR
    service_cidr                          = var.AKSSVCCIDR
    load_balancer_sku                     = var.AKSLBSku

  }
  
  role_based_access_control {
    enabled                               = true

    azure_active_directory {
      managed                             = true
      admin_group_object_ids              = var.AKSClusterAdminsIds

      #Moving to Managed AAD Cluster, those information are unecessary
      #client_app_id       = var.AADCliAppId
      #server_app_id       = var.AADServerAppId
      #server_app_secret   = var.AADServerAppSecret
      #tenant_id           = var.AADTenantId
    }

  }

  sku_tier                                = var.AKSControlPlaneSku

  addon_profile {

    azure_policy {
      enabled                             = var.IsAzPolicyEnabled
    }

    
    http_application_routing {
      enabled                             = var.IshttproutingEnabled
    }
    
    kube_dashboard {
      enabled                             = var.IsKubeDashboardEnabled
    }


    oms_agent {
      enabled                             = var.IsOMSAgentEnabled
      log_analytics_workspace_id          = var.LawSubLogId
    }

  }

  tags = merge(local.DefaultTags, var.extra_tags) 
}


################################################################
# Diagnostic settings resource

resource "azurerm_monitor_diagnostic_setting" "AKSDiag" {
  name                                  = "${azurerm_kubernetes_cluster.AKSRBACKubenet.name}diag"
  target_resource_id                    = azurerm_kubernetes_cluster.AKSRBACKubenet.id
  storage_account_id                    = var.STASubLogId
  log_analytics_workspace_id            = var.LawSubLogId

  log {
    category                            = "kube-apiserver"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "kube-controller-manager"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "kube-scheduler"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "kube-audit"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "cluster-autoscaler"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "kube-audit-admin"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "guard"
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


######################################################################
# Requirement for monitoring
######################################################################
######################################################################
# Mapping OMS UAI to Azure monitor publisher role

resource "azurerm_role_assignment" "MSToMonitorPublisher" {
  scope                               = azurerm_kubernetes_cluster.AKSRBACKubenet.id
  role_definition_name                = "Monitoring Metrics Publisher"
  principal_id                        = azurerm_kubernetes_cluster.AKSRBACKubenet.addon_profile[0].oms_agent[0].oms_agent_identity[0].object_id
}


################################################################
# AKS Alert


resource "azurerm_monitor_metric_alert" "NodeCPUPercentageThreshold" {

  lifecycle {
    ignore_changes                        = [
      tags
    ]
  }

  name                                        = "malt-NodeCPUPercentageThreshold-${azurerm_kubernetes_cluster.AKSRBACKubenet.name}"
  resource_group_name                         = var.AKSRGName
  scopes                                      = [azurerm_kubernetes_cluster.AKSRBACKubenet.id]
  description                                 = "${azurerm_kubernetes_cluster.AKSRBACKubenet.name}-NodeCPUPercentageThreshold"

  criteria {
    metric_namespace                          = "MICROSOFT.CONTAINERSERVICE/MANAGEDCLUSTERS"
    metric_name                               = "node_cpu_usage_percentage"
    aggregation                               = "Average"
    operator                                  = "GreaterThan"
    threshold                                 = 80



  }


  action {
    action_group_id                           = var.ACG1Id
  }


  frequency                                   = "PT1M"
  window_size                                 = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}

resource "azurerm_monitor_metric_alert" "NodeDiskPercentageThreshold" {

  lifecycle {
    ignore_changes                        = [
      tags
    ]
  }

  name                                        = "malt-NodeDiskPercentageThreshold-${azurerm_kubernetes_cluster.AKSRBACKubenet.name}"
  resource_group_name                         = var.AKSRGName
  scopes                                      = [azurerm_kubernetes_cluster.AKSRBACKubenet.id]
  description                                 = "${azurerm_kubernetes_cluster.AKSRBACKubenet.name}-NodeDiskPercentageThreshold"

  criteria {
    metric_namespace                          = "MICROSOFT.CONTAINERSERVICE/MANAGEDCLUSTERS"
    metric_name                               = "node_disk_usage_percentage"
    aggregation                               = "Average"
    operator                                  = "GreaterThan"
    threshold                                 = 80


  }


  action {
    action_group_id                           = var.ACG1Id
  }


  frequency                                   = "PT1M"
  window_size                                 = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}


resource "azurerm_monitor_metric_alert" "NodeWorkingSetMemoryPercentageThreshold" {

  lifecycle {
    ignore_changes                        = [
      tags
    ]
  }

  name                                        = "malt-NodeWorkingSetMemoryPercentageThreshold-${azurerm_kubernetes_cluster.AKSRBACKubenet.name}"
  resource_group_name                         = var.AKSRGName
  scopes                                      = [azurerm_kubernetes_cluster.AKSRBACKubenet.id]
  description                                 = "${azurerm_kubernetes_cluster.AKSRBACKubenet.name}-NodeWorkingSetMemoryPercentageThreshold"

  criteria {
    metric_namespace                          = "MICROSOFT.CONTAINERSERVICE/MANAGEDCLUSTERS"
    metric_name                               = "node_memory_working_set_percentage"
    aggregation                               = "Average"
    operator                                  = "GreaterThan"
    threshold                                 = 80


  }


  action {
    action_group_id                           = var.ACG1Id
  }


  frequency                                   = "PT1M"
  window_size                                 = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}


resource "azurerm_monitor_metric_alert" "UnschedulablePodCountThreshold" {

  lifecycle {
    ignore_changes                        = [
      tags
    ]
  }

  name                                        = "malt-UnschedulablePodCountThreshold-${azurerm_kubernetes_cluster.AKSRBACKubenet.name}"
  resource_group_name                         = var.AKSRGName
  scopes                                      = [azurerm_kubernetes_cluster.AKSRBACKubenet.id]
  description                                 = "${azurerm_kubernetes_cluster.AKSRBACKubenet.name}-UnschedulablePodCountThreshold"

  criteria {
    metric_namespace                          = "Microsoft.ContainerService/managedClusters"
    metric_name                               = "cluster_autoscaler_unschedulable_pods_count"
    aggregation                               = "Average"
    operator                                  = "GreaterThan"
    threshold                                 = 0

  }


  action {
    action_group_id                           = var.ACG1Id
  }


  frequency                                   = "PT1M"
  window_size                                 = "PT5M"




  tags = merge(local.DefaultTags, var.extra_tags)

}


resource "azurerm_monitor_activity_log_alert" "ListAKSAdminCredsEvent" {


  name                                        = "malt-ListAKSAdminCredsEvent-${azurerm_kubernetes_cluster.AKSRBACKubenet.name}"
  resource_group_name                         = var.AKSRGName
  scopes                                      = [azurerm_kubernetes_cluster.AKSRBACKubenet.id]
  description                                 = "${azurerm_kubernetes_cluster.AKSRBACKubenet.name}-ListAKSAdminCredsEvent"

  criteria {
    resource_id                               = azurerm_kubernetes_cluster.AKSRBACKubenet.id
    operation_name                            = "Microsoft.ContainerService/managedClusters/listClusterAdminCredential/action"
    category                                  = "Administrative"

  }


  action {
    action_group_id                           = var.ACG1Id
  }




  tags = merge(local.DefaultTags, var.extra_tags)

}

