################################################################
#This module allows the creation of an AKS Cluster
################################################################



################################################################
#Creating the AKS Cluster with RBAC Enabled and AAD integration

resource "azurerm_kubernetes_cluster" "AKSRBACCNI" {

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
    expander                              = var.AutoScaleProfilExpander
    max_graceful_termination_sec          = var.AutoScaleProfilMaxGracefullTerm
    max_node_provisioning_time            = var.AutoscaleProfilMaxNodeProvTime
    max_unready_nodes                     = var.AutoscaleProfilMaxUnreadyNodes
    max_unready_percentage                = var.AutoscaleProfilMaxUnreadyPercentage
    new_pod_scale_up_delay                = var.AutoscaleProfilNewPodScaleUpDelay
    scale_down_delay_after_add            = var.AutoScaleProfilScaleDownAfterAdd
    scale_down_delay_after_delete         = var.AutoScaleProfilScaleDownAfterDelete
    scale_down_delay_after_failure        = var.AutoScaleProfilScaleDownAfterFail
    scan_interval                         = var.AutoScaleProfilScanInterval
    scale_down_unneeded                   = var.AutoScaleProfilScaleDownUnneeded
    scale_down_unready                    = var.AutoScaleProfilScaleDownUnready
    scale_down_utilization_threshold      = var.AutoScaleProfilScaleDownUtilThreshold
    empty_bulk_delete_max                 = var.AutoscaleProfilEmptyBulkDeleteMax
    skip_nodes_with_local_storage         = var.AutoscaleProfilSkipNodesWLocalStorage
    skip_nodes_with_system_pods           = var.AutoscaleProfilSkipNodeWithSystemPods

  }

  disk_encryption_set_id                  = var.AKSDiskEncryptionId



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
    network_plugin                        = var.AKSNetworkPlugin
    network_policy                        = var.AKSNetPolProvider
    dns_service_ip                        = var.AKSNetworkDNS
    docker_bridge_cidr                    = var.AKSDockerBridgeCIDR
    outbound_type                         = var.AKSOutboundType
    service_cidr                          = var.AKSSVCCIDR
    pod_cidr                              = var.AKSPodCIDR
    load_balancer_sku                     = var.AKSLBSku

   dynamic "load_balancer_profile" {
      for_each = var.AKSLBSku == "Standard" ? ["fake"] : []

      content {

      outbound_ports_allocated            = var.AKSLBOutboundPortsAllocated
      idle_timeout_in_minutes             = var.AKSLBIdleTimeout
      managed_outbound_ip_count           = var.AKSLBOutboundIPCount
      outbound_ip_prefix_ids              = var.AKSLBOutboundIPPrefixIds
      outbound_ip_address_ids             = var.AKSLBOutboundIPAddressIds

      }

    }

  }
  
  role_based_access_control {
    enabled                               = true

    azure_active_directory {
      managed                             = true
      admin_group_object_ids              = var.AKSClusterAdminsIds

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

    ingress_application_gateway {
      enabled                             = var.IsAGICEnabled
      gateway_id                          = var.AGWId
      gateway_name                        = var.AGWName
      subnet_cidr                         = var.AGWSubnetCidr
      subnet_id                           = var.AGWSubnetId
    }

# This block code seems to work but it's simpler with the above version

#    dynamic "ingress_application_gateway" {
#      for_each = var.IsAGICEnabled ? ["fake"] : []
#
#      content {
#
#      enabled                             = var.IsAGICEnabled
#      gateway_id                          = var.AGWId
#      gateway_name                        = var.AGWName
#      subnet_cidr                         = var.AGWSubnetCidr
#      subnet_id                           = var.AGWSubnetId
#
#      }
#
#    }



  }

  tags = merge(local.DefaultTags, var.extra_tags) 
}


################################################################
# Diagnostic settings resource

resource "azurerm_monitor_diagnostic_setting" "AKSDiag" {
  name                                  = "${azurerm_kubernetes_cluster.AKSRBACCNI.name}diag"
  target_resource_id                    = azurerm_kubernetes_cluster.AKSRBACCNI.id
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
  scope                               = azurerm_kubernetes_cluster.AKSRBACCNI.id
  role_definition_name                = "Monitoring Metrics Publisher"
  principal_id                        = azurerm_kubernetes_cluster.AKSRBACCNI.addon_profile[0].oms_agent[0].oms_agent_identity[0].object_id
}


################################################################
# AKS Alert


resource "azurerm_monitor_metric_alert" "NodeCPUPercentageThreshold" {


  name                                        = "malt-NodeCPUPercentageThreshold-${azurerm_kubernetes_cluster.AKSRBACCNI.name}"
  resource_group_name                         = var.AKSRGName
  scopes                                      = [azurerm_kubernetes_cluster.AKSRBACCNI.id]
  description                                 = "${azurerm_kubernetes_cluster.AKSRBACCNI.name}-NodeCPUPercentageThreshold"

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


  name                                        = "malt-NodeDiskPercentageThreshold-${azurerm_kubernetes_cluster.AKSRBACCNI.name}"
  resource_group_name                         = var.AKSRGName
  scopes                                      = [azurerm_kubernetes_cluster.AKSRBACCNI.id]
  description                                 = "${azurerm_kubernetes_cluster.AKSRBACCNI.name}-NodeDiskPercentageThreshold"

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


  name                                        = "malt-NodeWorkingSetMemoryPercentageThreshold-${azurerm_kubernetes_cluster.AKSRBACCNI.name}"
  resource_group_name                         = var.AKSRGName
  scopes                                      = [azurerm_kubernetes_cluster.AKSRBACCNI.id]
  description                                 = "${azurerm_kubernetes_cluster.AKSRBACCNI.name}-NodeWorkingSetMemoryPercentageThreshold"

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


  name                                        = "malt-UnschedulablePodCountThreshold-${azurerm_kubernetes_cluster.AKSRBACCNI.name}"
  resource_group_name                         = var.AKSRGName
  scopes                                      = [azurerm_kubernetes_cluster.AKSRBACCNI.id]
  description                                 = "${azurerm_kubernetes_cluster.AKSRBACCNI.name}-UnschedulablePodCountThreshold"

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


  name                                        = "malt-ListAKSAdminCredsEvent-${azurerm_kubernetes_cluster.AKSRBACCNI.name}"
  resource_group_name                         = var.AKSRGName
  scopes                                      = [azurerm_kubernetes_cluster.AKSRBACCNI.id]
  description                                 = "${azurerm_kubernetes_cluster.AKSRBACCNI.name}-ListAKSAdminCredsEvent"

  criteria {
    resource_id                               = azurerm_kubernetes_cluster.AKSRBACCNI.id
    operation_name                            = "Microsoft.ContainerService/managedClusters/listClusterAdminCredential/action"
    category                                  = "Administrative"

  }


  action {
    action_group_id                           = var.ACG1Id
  }




  tags = merge(local.DefaultTags, var.extra_tags)

}

