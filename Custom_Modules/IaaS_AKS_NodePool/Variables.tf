##############################################################
#This module allows the creation of a vNEt
##############################################################




##############################################################
# basic parameters

variable "NPSuffix" {
  type                          = string
  description                   = "An suffix to identify the node pool"

}

variable "AKSClusterId" {
  type                          = string
  description                   = "The ID of the Kubernetes Cluster where this Node Pool should exist. Changing this forces a new resource to be created."

}

##############################################################
# Node pool config

variable "AKSNodeInstanceType" {
  type                          = string
  default                       = "Standard_D2S_v4"
  description                   = "The type of Azure instance for the pool"
}

variable "AKSAZ" {
  type                          = list(string)
  default                       = ["1","2","3"]
  description                   = "The list of AZ to use"
}

variable "EnableAKSAutoScale" {
  type                          = string
  default                       = true
  description                   = "Is autoscaling enabled for this node pool"
}

variable "EnableNodePublicIP" {
  type                          = string
  default                       = null
  description                   = "Define if Nodes get Public IP. Defualt API value is false"
}

variable "AKSMaxPods" {
  type                          = string
  default                       = 100
  description                   = "Define the max pod number per nodes, Change force new resoure to be created"
}

variable "NPMode" {
  type                          = string
  default                       = null
  description                   = "Should this Node Pool be used for System or User resources? Possible values are System and User. Defaults to User."
}


variable "AKSNodeLabels" {
  type                          = map
  default                       = null
  description                   = "A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created."
}

variable "AKSNodeTaints" {
  type                          = list
  default                       = null
  description                   = "A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
}

variable "AKSNodeOSDiskSize" {
  type                          = string
  default                       = 100
  description                   = "The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created."
}

variable "AKSNodeOSDiskType" {
  type                          = string
  default                       = null
  description                   = "The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
}

variable "AKSNodeOSType" {
  type                          = string
  default                       = "Linux"
  description                   = "he Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are Linux and Windows. Defaults to Linux."
}

variable "AKSNPPriority" {
  type                          = string
  default                       = "Regular"
  description                   = "The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created."
}

variable "AKSNPPlacementGroup" {
  type                          = string
  default                       = null
  description                   = "The ID of the Proximity Placement Group where the Virtual Machine Scale Set that powers this Node Pool will be placed. Changing this forces a new resource to be created."
}

variable "AKSSubnetId" {
  type                          = string
  description                   = "The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
}

variable "MaxAutoScaleCount" {
  type                          = string
  default                       = 10
  description                   = "The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100"
}

variable "MinAutoScaleCount" {
  type                          = string
  default                       = 2
  description                   = "The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100."
}

variable "AKSNodeCount" {
  type                          = string
  default                       = 3
  description                   = "The number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100."

}

variable "KubeVersion" {
  type                          = string
  default                       = null
  description                   = "The version of Kube, used for Node pool version but also for Control plane version"
}

variable "EnableHostEncryption" {
  type                          = string
  default                       = null
  description                   = "Should the nodes in this Node Pool have host encryption enabled? Defaults to false."
}

variable "EvictionPolicy" {
  type                          = string
  default                       = null
  description                   = "The Eviction Policy which should be used for Virtual Machines within the Virtual Machine Scale Set powering this Node Pool. Possible values are Deallocate and Delete. Changing this forces a new resource to be created."
}

variable "AKSMaxSurge" {
  type                          = string
  default                       = "33%"
  description                   = "The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade."
}

##############################################################
# kubelet_config block variables

variable "KubeletAllowedUnsafeSysctls" {
  type                          = list(string)
  default                       = null
  description                   = "Specifies the allow list of unsafe sysctls command or patterns (ending in *). Changing this forces a new resource to be created."
}

variable "KubeletContainerLogMaxLine" {
  type                          = string
  default                       = null
  description                   = "Specifies the maximum number of container log files that can be present for a container. must be at least 2. Changing this forces a new resource to be created."
}

variable "KubeletContainerLogMaxSize" {
  type                          = string
  default                       = null
  description                   = "Specifies the maximum size (e.g. 10MB) of container log file before it is rotated. Changing this forces a new resource to be created."
}

variable "KubeletCpuCfsQuotaEnabled" {
  type                          = string
  default                       = null
  description                   = "Is CPU CFS quota enforcement for containers enabled? Changing this forces a new resource to be created."
}

variable "KubeletCpuCfsQuotaPeriod" {
  type                          = string
  default                       = null
  description                   = "Specifies the CPU CFS quota period value. Changing this forces a new resource to be created."
}

variable "KubeletCpuManagerPolicy" {
  type                          = string
  default                       = null
  description                   = "Specifies the CPU Manager policy to use. Possible values are none and static, Changing this forces a new resource to be created."
}

variable "KubeletImageGcHighThreshold" {
  type                          = string
  default                       = null
  description                   = "Specifies the percent of disk usage above which image garbage collection is always run. Must be between 0 and 100. Changing this forces a new resource to be created."
}

variable "KubeletImageGcLowThreshold" {
  type                          = string
  default                       = null
  description                   = "Specifies the percent of disk usage lower than which image garbage collection is never run. Must be between 0 and 100. Changing this forces a new resource to be created."
}

variable "KubeletPodMaxPid" {
  type                          = string
  default                       = null
  description                   = "Specifies the maximum number of processes per pod. Changing this forces a new resource to be created."
}

variable "KubeletTopologyManagerPolicy" {
  type                          = string
  default                       = null
  description                   = "Specifies the Topology Manager policy to use. Possible values are none, best-effort, restricted or single-numa-node. Changing this forces a new resource to be created."
}

##############################################################
# linux_os_config block variables

variable "LinuxOSConfigSwapFileSize" {
  type                          = string
  default                       = null
  description                   = "Specifies the size of swap file on each node in MB. Changing this forces a new resource to be created."
}

variable "LinuxOSConfigTransparentHugePageDefrag" {
  type                          = string
  default                       = null
  description                   = "Specifies the defrag configuration for Transparent Huge Page. Possible values are always, defer, defer+madvise, madvise and never. Changing this forces a new resource to be created."
}

variable "LinuxOSConfigTransparentHugePageEnabled" {
  type                          = string
  default                       = null
  description                   = "Specifies the Transparent Huge Page enabled configuration. Possible values are always, madvise and never. Changing this forces a new resource to be created."
}

variable "SysCtlFsAioMaxNr" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting fs.aio-max-nr. Must be between 65536 and 6553500. Changing this forces a new resource to be created."
}

variable "SysCtlFsFileMax" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting fs.file-max. Must be between 8192 and 12000500. Changing this forces a new resource to be created."
}

variable "SysCtlFsInotifyMaxUserWatches" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting fs.inotify.max_user_watches. Must be between 781250 and 2097152. Changing this forces a new resource to be created."
}

variable "SysCtlFsNrOpen" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting fs.nr_open. Must be between 8192 and 20000500. Changing this forces a new resource to be created."
}

variable "SysCtlKernelThreadsMax" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting kernel.threads-max. Must be between 20 and 513785. Changing this forces a new resource to be created."
}

variable "SysCtlNetCoredevMaxBacklog" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.core.netdev_max_backlog. Must be between 1000 and 3240000. Changing this forces a new resource to be created. "
}

variable "SysCtlNetCoreOptmemMax" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.core.optmem_max. Must be between 20480 and 4194304. Changing this forces a new resource to be created."
}

variable "SysCtlNetCoreRmemDefault" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.core.rmem_default. Must be between 212992 and 134217728. Changing this forces a new resource to be created."
}

variable "SysCtlNetCoreRmemMax" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.core.rmem_max. Must be between 212992 and 134217728. Changing this forces a new resource to be created."
}

variable "SysCtlNetCoreSomaxconn" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.core.somaxconn. Must be between 4096 and 3240000. Changing this forces a new resource to be created."
}

variable "SysCtlNetCoreWmemDefault" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.core.wmem_default. Must be between 212992 and 134217728. Changing this forces a new resource to be created."
}

variable "SysCtlNetCoreWmemMax" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.core.wmem_max. Must be between 212992 and 134217728. Changing this forces a new resource to be created."
}


variable "SysCtlNetIpv4IpLocalPortRangeMax" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.ipv4.ip_local_port_range max value. Must be between 1024 and 60999. Changing this forces a new resource to be created."
}

variable "SysCtlNetIpv4IpLocalPortRangeMin" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.ipv4.ip_local_port_range min value. Must be between 1024 and 60999. Changing this forces a new resource to be created."
}

variable "SysCtlNetIpv4NeighDefaultGcThreshold1" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.ipv4.neigh.default.gc_thresh1. Must be between 128 and 80000. Changing this forces a new resource to be created."
}

variable "SysCtlNetIpv4NeighDefaultGcThreshold2" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.ipv4.neigh.default.gc_thresh2. Must be between 512 and 90000. Changing this forces a new resource to be created."
}

variable "SysCtlNetIpv4NeighDefaultGcThreshold3" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.ipv4.neigh.default.gc_thresh3. Must be between 512 and 90000. Changing this forces a new resource to be created."
}

variable "SysCtlNetIpv4NTcpFinTimeOut" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.ipv4.tcp_fin_timeout. Must be between 5 and 120. Changing this forces a new resource to be created."
}

variable "SysCtlNetIpv4NTcpKeepAliveIntvl" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.ipv4.tcp_keepalive_intvl. Must be between 10 and 75. Changing this forces a new resource to be created."
}

variable "SysCtlNetIpv4NTcpKeepAliveProbes" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.ipv4.tcp_keepalive_probes. Must be between 1 and 15. Changing this forces a new resource to be created."
}

variable "SysCtlNetIpv4NTcpKeepAliveTime" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.ipv4.tcp_keepalive_time. Must be between 30 and 432000. Changing this forces a new resource to be created."
}

variable "SysCtlNetIpv4NTcpMaxSynBacklog" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.ipv4.tcp_max_syn_backlog. Must be between 128 and 3240000. Changing this forces a new resource to be created."
}

variable "SysCtlNetIpv4NTcpMaxTwBuckets" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.ipv4.tcp_max_tw_buckets. Must be between 8000 and 1440000. Changing this forces a new resource to be created."
}

variable "SysCtlNetIpv4NTcpMaxTwReuse" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.ipv4.tcp_tw_reuse. Changing this forces a new resource to be created."
}

variable "SysCtlNetfilterNfConntrackBuckets" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.netfilter.nf_conntrack_max. Must be between 131072 and 589824. Changing this forces a new resource to be created."
}

variable "SysCtlNetfilterNfConntrackMax" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting net.netfilter.nf_conntrack_max. Must be between 131072 and 589824. Changing this forces a new resource to be created."
}

variable "SysCtlVmMaxMapCount" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting vm.max_map_count. Must be between 65530 and 262144. Changing this forces a new resource to be created."
}

variable "SysCtlVmSwapiness" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting vm.swappiness. Must be between 0 and 100. Changing this forces a new resource to be created."
}

variable "SysCtlVmVfsCachePressure" {
  type                          = string
  default                       = null
  description                   = "The sysctl setting vm.vfs_cache_pressure. Must be between 0 and 100. Changing this forces a new resource to be created."
}

######################################################
#Tag related variables and naming convention section

variable "DefaultTags" {

  description                           = "Define a set of default tags"
  default                               = {
    ResourceOwner                       = "That would be me"
    Country                             = "fr"
    CostCenter                          = "labtf"
    Project                             = "aks"
    Environment                         = "lab"
    ManagedBy                           = "Terraform"

  }
  
}

variable "ExtraTags" {
  type                                  = map
  description                           = "Define a set of additional optional tags."
  default                               = {}
}