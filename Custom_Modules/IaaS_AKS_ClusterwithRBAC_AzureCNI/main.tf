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
      #Ignore change for some default node pool block
      default_node_pool[0].kubelet_config,
      default_node_pool[0].linux_os_config,
      #Ignore change on kubernetes version. It should not be
      kubernetes_version,


    ]
  }
  
  name                                    = local.AKSClusterName
  location                                = var.AKSLocation
  resource_group_name                     = var.AKSRGName

  default_node_pool {
    name                                  = substr(local.AKSDefaultNodePoolName,0,12)
    vm_size                               = var.AKSNodeInstanceType
    availability_zones                    = var.AKSLBSku == "Standard" ? var.AKSAZ : null
    enable_auto_scaling                   = var.EnableAKSAutoScale
    enable_host_encryption                = var.EnableHostEncryption      
    enable_node_public_ip                 = var.EnableNodePublicIP
    fips_enabled                          = var.NodePoolWithFIPSEnabled        
    max_pods                              = var.AKSMaxPods
    node_labels                           = var.AKSNodeLabels
    node_taints                           = var.AKSNodeTaints
    os_disk_size_gb                       = var.AKSNodeOSDiskSize 
    os_disk_type                          = var.AKSNodeOSDiskType 
    vnet_subnet_id                        = var.AKSSubnetId
    max_count                             = var.MaxAutoScaleCount
    min_count                             = var.MinAutoScaleCount
    node_count                            = var.AKSNodeCount
    orchestrator_version                  = var.KubeVersion
    pod_subnet_id                         = var.AKSNodePodSubnetId
    ultra_ssd_enabled                     = var.AKSNodeUltraSSDEnabled

    kubelet_config {

      allowed_unsafe_sysctls              = var.KubeletAllowedUnsafeSysctls
      container_log_max_line              = var.KubeletContainerLogMaxLine
      container_log_max_size_mb           = var.KubeletContainerLogMaxSize
      cpu_cfs_quota_enabled               = var.KubeletCpuCfsQuotaEnabled
      cpu_cfs_quota_period                = var.KubeletCpuCfsQuotaPeriod
      cpu_manager_policy                  = var.KubeletCpuManagerPolicy
      image_gc_high_threshold             = var.KubeletImageGcHighThreshold
      image_gc_low_threshold              = var.KubeletImageGcLowThreshold
      pod_max_pid                         = var.KubeletPodMaxPid
      topology_manager_policy             = var.KubeletTopologyManagerPolicy

    }

    kubelet_disk_type                     = var.KubeletDiskType
    linux_os_config {

      swap_file_size_mb                   = var.LinuxOSConfigSwapFileSize 
      transparent_huge_page_defrag        = var.LinuxOSConfigTransparentHugePageDefrag
      transparent_huge_page_enabled       = var.LinuxOSConfigTransparentHugePageEnabled
      sysctl_config {
        fs_aio_max_nr                     = var.SysCtlFsAioMaxNr
        fs_file_max                       = var.SysCtlFsFileMax
        fs_inotify_max_user_watches       = var.SysCtlFsInotifyMaxUserWatches
        fs_nr_open                        = var.SysCtlFsNrOpen
        kernel_threads_max                = var.SysCtlKernelThreadsMax
        net_core_netdev_max_backlog       = var.SysCtlNetCoredevMaxBacklog
        net_core_optmem_max               = var.SysCtlNetCoreOptmemMax
        net_core_rmem_default             = var.SysCtlNetCoreRmemDefault
        net_core_rmem_max                 = var.SysCtlNetCoreRmemMax
        net_core_somaxconn                = var.SysCtlNetCoreSomaxconn
        net_core_wmem_default             = var.SysCtlNetCoreWmemDefault
        net_core_wmem_max                 = var.SysCtlNetCoreWmemMax
        net_ipv4_ip_local_port_range_max  = var.SysCtlNetIpv4IpLocalPortRangeMax
        net_ipv4_ip_local_port_range_min  = var.SysCtlNetIpv4IpLocalPortRangeMin
        net_ipv4_neigh_default_gc_thresh1 = var.SysCtlNetIpv4NeighDefaultGcThreshold1
        net_ipv4_neigh_default_gc_thresh2 = var.SysCtlNetIpv4NeighDefaultGcThreshold2
        net_ipv4_neigh_default_gc_thresh3 = var.SysCtlNetIpv4NeighDefaultGcThreshold3
        net_ipv4_tcp_fin_timeout          = var.SysCtlNetIpv4NTcpFinTimeOut
        net_ipv4_tcp_keepalive_intvl      = var.SysCtlNetIpv4NTcpKeepAliveIntvl
        net_ipv4_tcp_keepalive_probes     = var.SysCtlNetIpv4NTcpKeepAliveProbes
        net_ipv4_tcp_keepalive_time       = var.SysCtlNetIpv4NTcpKeepAliveTime
        net_ipv4_tcp_max_syn_backlog      = var.SysCtlNetIpv4NTcpMaxSynBacklog
        net_ipv4_tcp_max_tw_buckets       = var.SysCtlNetIpv4NTcpMaxTwBuckets
        net_ipv4_tcp_tw_reuse             = var.SysCtlNetIpv4NTcpMaxTwReuse
        net_netfilter_nf_conntrack_buckets= var.SysCtlNetfilterNfConntrackBuckets
        net_netfilter_nf_conntrack_max    = var.SysCtlNetfilterNfConntrackMax
        vm_max_map_count                  = var.SysCtlVmMaxMapCount
        vm_swappiness                     = var.SysCtlVmSwapiness
        vm_vfs_cache_pressure             = var.SysCtlVmVfsCachePressure
      }      
    }

    only_critical_addons_enabled          = var.TaintCriticalAddonsEnabled 

    tags = merge(local.DefaultTags, var.extra_tags)

  }

  dns_prefix                              = var.IsAKSPrivate == true ? null : local.DNSPrefix
  dns_prefix_private_cluster              = var.IsAKSPrivate == true ? local.DNSPrefix : null
  node_resource_group                     = var.UseAKSNodeRGDefaultName ? local.DefaultNodeRGName : local.CustomNodeRGName
  private_cluster_enabled                 = var.IsAKSPrivate
  private_dns_zone_id                     = var.PrivateDNSZoneId
  private_cluster_public_fqdn_enabled     = var.PrivateClusterPublicFqdn
  local_account_disabled                  = var.LocalAccountDisabled

  automatic_channel_upgrade               = var.AutoUpgradeChannelConfig 


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
      log_analytics_workspace_id          = var.IsOMSAgentEnabled ? var.LawSubLogId : null
    }

    ingress_application_gateway {
      enabled                             = var.IsAGICEnabled
      gateway_id                          = var.AGWId
      gateway_name                        = var.AGWName
      subnet_cidr                         = var.AGWSubnetCidr
      subnet_id                           = var.AGWSubnetId
    }

    open_service_mesh {
      enabled                             = var.IsOpenServiceMeshEnabled
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

  log {
    category                            = "cloud-controller-manager"
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

  lifecycle {
    ignore_changes                        = [
      tags
    ]
  }

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
  lifecycle {
    ignore_changes                        = [
      tags
    ]
  }

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
  lifecycle {
    ignore_changes                        = [
      tags
    ]
  }

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
  lifecycle {
    ignore_changes                        = [
      tags
    ]
  }

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
  lifecycle {
    ignore_changes                        = [
      tags
    ]
  }

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

