################################################################
#This module allows the creation of an AKS Node Pool
################################################################

#Creating the AKS Cluster with RBAC Enabled and AAD integration

resource "azurerm_kubernetes_cluster_node_pool" "AKSNodePool" {

  lifecycle {
    ignore_changes = [
      node_count,
      orchestrator_version,
      linux_os_config,
      kubelet_config,
      tags
    ]
  }

  ##############################################################
  # Basic configuration

  name                  = "np${var.NPSuffix}"
  kubernetes_cluster_id = var.AKSClusterId
  vm_size               = var.AKSNodeInstanceType
  zones                 = var.AKSAZ
  mode                  = var.NPMode
  orchestrator_version  = var.KubeVersion
  max_pods              = var.AKSMaxPods
  workload_runtime      = var.WorkloadRuntimeType

  ##############################################################
  # Security Parameters

  host_encryption_enabled = var.EnableHostEncryption
  fips_enabled            = var.IsFipsEnabled

  ##############################################################
  # Network configuration

  node_public_ip_enabled = var.EnableNodePublicIP
  vnet_subnet_id         = var.AKSSubnetId
  pod_subnet_id          = var.PodSubnetId
  node_network_profile {
    node_public_ip_tags            = var.NodePublicIpTags
    application_security_group_ids = var.CustomAsgList
  }

  ##############################################################
  # Autoscaling configuration

  auto_scaling_enabled = var.EnableAKSAutoScale
  max_count            = var.MaxAutoScaleCount
  min_count            = var.MinAutoScaleCount
  node_count           = var.AKSNodeCount
  scale_down_mode      = var.ScaleDownMode

  ##############################################################
  # OS related Configuration

  os_sku          = var.AKSNodeOSSku
  os_type         = var.AKSNodeOSType
  os_disk_type    = var.AKSNodeOSDiskType
  os_disk_size_gb = var.AKSNodeOSDiskSize

  ##############################################################
  # Nodes taints and Labels management

  node_labels = var.AKSNodeLabels
  node_taints = var.AKSNodeTaints

  ##############################################################
  # Node pool spot configuration

  priority        = var.AKSNPPriority
  eviction_policy = var.EvictionPolicy
  spot_max_price  = var.SpotMaxPrice

  ##############################################################
  # Node pool reservation configuration  

  capacity_reservation_group_id = var.CapacityReservationGroupId

  ##############################################################
  # Host and prximity configuration

  proximity_placement_group_id = var.PlacementGroupId
  host_group_id                = var.HostGroupId

  ##############################################################
  # Kubelet configuration  

  kubelet_disk_type = var.KubeletDiskType
  kubelet_config {

    allowed_unsafe_sysctls    = var.KubeletAllowedUnsafeSysctls
    container_log_max_line    = var.KubeletContainerLogMaxLine
    container_log_max_size_mb = var.KubeletContainerLogMaxSize
    cpu_cfs_quota_enabled     = var.KubeletCpuCfsQuotaEnabled
    cpu_cfs_quota_period      = var.KubeletCpuCfsQuotaPeriod
    cpu_manager_policy        = var.KubeletCpuManagerPolicy
    image_gc_high_threshold   = var.KubeletImageGcHighThreshold
    image_gc_low_threshold    = var.KubeletImageGcLowThreshold
    pod_max_pid               = var.KubeletPodMaxPid
    topology_manager_policy   = var.KubeletTopologyManagerPolicy

  }

  ##############################################################
  # Linux OS configuration 

  linux_os_config {

    swap_file_size_mb             = var.LinuxOSConfigSwapFileSize
    transparent_huge_page_defrag  = var.LinuxOSConfigTransparentHugePageDefrag
    transparent_huge_page_enabled = var.LinuxOSConfigTransparentHugePageEnabled

    sysctl_config {

      fs_aio_max_nr                      = var.SysCtlFsAioMaxNr
      fs_file_max                        = var.SysCtlFsFileMax
      fs_inotify_max_user_watches        = var.SysCtlFsInotifyMaxUserWatches
      fs_nr_open                         = var.SysCtlFsNrOpen
      kernel_threads_max                 = var.SysCtlKernelThreadsMax
      net_core_netdev_max_backlog        = var.SysCtlNetCoredevMaxBacklog
      net_core_optmem_max                = var.SysCtlNetCoreOptmemMax
      net_core_rmem_default              = var.SysCtlNetCoreRmemDefault
      net_core_rmem_max                  = var.SysCtlNetCoreRmemMax
      net_core_somaxconn                 = var.SysCtlNetCoreSomaxconn
      net_core_wmem_default              = var.SysCtlNetCoreWmemDefault
      net_core_wmem_max                  = var.SysCtlNetCoreWmemMax
      net_ipv4_ip_local_port_range_max   = var.SysCtlNetIpv4IpLocalPortRangeMax
      net_ipv4_ip_local_port_range_min   = var.SysCtlNetIpv4IpLocalPortRangeMin
      net_ipv4_neigh_default_gc_thresh1  = var.SysCtlNetIpv4NeighDefaultGcThreshold1
      net_ipv4_neigh_default_gc_thresh2  = var.SysCtlNetIpv4NeighDefaultGcThreshold2
      net_ipv4_neigh_default_gc_thresh3  = var.SysCtlNetIpv4NeighDefaultGcThreshold3
      net_ipv4_tcp_fin_timeout           = var.SysCtlNetIpv4NTcpFinTimeOut
      net_ipv4_tcp_keepalive_intvl       = var.SysCtlNetIpv4NTcpKeepAliveIntvl
      net_ipv4_tcp_keepalive_probes      = var.SysCtlNetIpv4NTcpKeepAliveProbes
      net_ipv4_tcp_keepalive_time        = var.SysCtlNetIpv4NTcpKeepAliveTime
      net_ipv4_tcp_max_syn_backlog       = var.SysCtlNetIpv4NTcpMaxSynBacklog
      net_ipv4_tcp_max_tw_buckets        = var.SysCtlNetIpv4NTcpMaxTwBuckets
      net_ipv4_tcp_tw_reuse              = var.SysCtlNetIpv4NTcpMaxTwReuse
      net_netfilter_nf_conntrack_buckets = var.SysCtlNetfilterNfConntrackBuckets
      net_netfilter_nf_conntrack_max     = var.SysCtlNetfilterNfConntrackMax
      vm_max_map_count                   = var.SysCtlVmMaxMapCount
      vm_swappiness                      = var.SysCtlVmSwapiness
      vm_vfs_cache_pressure              = var.SysCtlVmVfsCachePressure

    }

  }

  ##############################################################
  # Upgrade configuration
  upgrade_settings {
    max_surge = var.AKSMaxSurge
  }

  ##############################################################
  # Windows OS configuration 

  dynamic "windows_profile" {
    for_each = var.AKSNodeOSType == "Windows" ? ["fake"] : []

    content {
      outbound_nat_enabled = var.NATEnabledforWinProfile
    }

  }



  ##############################################################
  # Tags 

  tags = merge(var.DefaultTags, var.ExtraTags, { "AKSClusterName" = split("/", var.AKSClusterId)[8] })



}