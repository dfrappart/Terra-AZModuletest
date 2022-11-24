##############################################################
#This module creates an AKS Clulster with RBAC and Kubenet
##############################################################




variable "LawLogId" {
  type                          = string
  description                   = "ID of the log analytics workspace containing the logs, if not specified, no diagnostic settings to log analytics is created"
  default                       = "unspecified"
}

variable "STALogId" {
  type                          = string
  description                   = "Id of the storage account containing the logs, if not specified, no diagnostic settings to storage account is created"
  default                       = "unspecified"
}


##############################################################
# basic parameters

variable "AKSClusSuffix" {
  type                          = string
  default                       = "AksClus"
  description                   = "A suffix to identify the cluster without breacking the naming convention. Changing this will change the name so forces a new resource to be created."

}


variable "AKSLocation" {
  type                          = string
  description                   = "The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created."
  default                       = "westeurope"
}

variable "AKSRGName" {
  type                          = string
  description                   = "Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."

}

##############################################################
# Default Node pool config

variable "AKSNodeInstanceType" {
  type                          = string
  default                       = "standard_d2s_v4"
  description                   = "The size of the Virtual Machine, such as Standard_DS2_v2."
}

variable "AKSAZ" {
  type                          = list(string)
  default                       = ["1","2","3"]
  description                   = "A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
}

variable "EnableAKSAutoScale" {
  type                          = string
  default                       = true
  description                   = "Should the Kubernetes Auto Scaler be enabled for this Node Pool? Defaults to true."
}

variable "EnableHostEncryption" {
  type                          = string
  default                       = null
  description                   = "Should the nodes in the Default Node Pool have host encryption enabled? Defaults to false."
}

variable "EnableNodePublicIP" {
  type                          = string
  default                       = null
  description                   = "Define if Nodes get Public IP. Defualt API value is false"
}

variable "NodePoolWithFIPSEnabled" {
  type                          = string
  default                       = null
  description                   = "Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created."
}

variable "AKSMaxPods" {
  type                          = string
  default                       = 100
  description                   = "Define the max pod number per nodes, Change force new resoure to be created"
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
  default                       = 127
  description                   = "The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created."
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

variable "KubeletDiskType" {
  type                          = string
  default                       = null
  description                   = "The type of disk used by kubelet. At this time the only possible value is OS."
}

variable "TaintCriticalAddonsEnabled" {
  type                          = string
  default                       = null
  description                   = "Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. Changing this forces a new resource to be created."
}

variable "AKSNodeOSDiskType" {
  type                          = string
  default                       = null
  description                   = "The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
}

variable "AKSNodeOSSku" {
  type                          = string
  default                       = null
  description                   = "OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. Possible values include: Ubuntu, CBLMariner. Defaults to Ubuntu. Changing this forces a new resource to be created."
}

variable "AKSNodePodSubnetId" {
  type                          = string
  default                       = null
  description                   = "The ID of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created."
}

variable "AKSNodeUltraSSDEnabled" {
  type                          = string
  default                       = null
  description                   = "Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false."
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

##############################################################

variable "APIAccessList" {
  type                          = list(string)
  default                       = null
  description                   = "The IP ranges to whitelist for incoming traffic to the masters."
}

variable "AutoUpgradeChannelConfig" {
  type                          = string
  default                       = null
  description                   = "The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none."
}

##############################################################
# Autoscaler profile config

variable "AutoScaleProfilBalanceSimilarNdGP" {
  type                          = string
  default                       = null
  description                   = "Detect similar node groups and balance the number of nodes between them. Defaults to false."
}

variable "AutoScaleProfilMaxGracefullTerm" {
  type                          = string
  default                       = null
  description                   = "Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to 600."
}

variable "AutoScaleProfilScaleDownAfterAdd" {
  type                          = string
  default                       = null
  description                   = "How long after the scale up of AKS nodes the scale down evaluation resumes. Defaults to 10m."
}

variable "AutoScaleProfilScaleDownAfterDelete" {
  type                          = string
  default                       = null
  description                   = "How long after node deletion that scale down evaluation resumes. Defaults to the value used for scan_interval."
}

variable "AutoScaleProfilScaleDownAfterFail" {
  type                          = string
  default                       = null
  description                   = "How long after scale down failure that scale down evaluation resumes. Defaults to 3m."
}

variable "AutoScaleProfilScanInterval" {
  type                          = string
  default                       = null
  description                   = "How often the AKS Cluster should be re-evaluated for scale up/down. Defaults to 10s."
}

variable "AutoScaleProfilScaleDownUnneeded" {
  type                          = string
  default                       = null
  description                   = "How long a node should be unneeded before it is eligible for scale down. Defaults to 10m."
}

variable "AutoScaleProfilScaleDownUnready" {
  type                          = string
  default                       = null
  description                   = "How long an unready node should be unneeded before it is eligible for scale down. Defaults to 20m."
}

variable "AutoScaleProfilScaleDownUtilThreshold" {
  type                          = string
  default                       = null
  description                   = "Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. Defaults to 0.5."
}

variable "AutoScaleProfilExpander" {
  type                          = string
  default                       = null
  description                   = "Expander to use. Possible values are least-waste, priority, most-pods and random. Defaults to random."
}

variable "AutoscaleProfilMaxNodeProvTime" {
  type                          = string
  default                       = null
  description                   = "Maximum time the autoscaler waits for a node to be provisioned. Defaults to 15m."
}

variable "AutoscaleProfilMaxUnreadyNodes" {
  type                          = string
  default                       = null
  description                   = "Maximum Number of allowed unready nodes. Defaults to 3."
}

variable "AutoscaleProfilMaxUnreadyPercentage" {
  type                          = string
  default                       = null
  description                   = "Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded. Defaults to 45."
}

variable "AutoscaleProfilNewPodScaleUpDelay" {
  type                          = string
  default                       = null
  description                   = "For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. Defaults to 10s."
}

variable "AutoscaleProfilEmptyBulkDeleteMax" {
  type                          = string
  default                       = null
  description                   = "Maximum number of empty nodes that can be deleted at the same time. Defaults to 10."
}

variable "AutoscaleProfilSkipNodesWLocalStorage" {
  type                          = string
  default                       = null
  description                   = "If true cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath. Defaults to true."
}

variable "AutoscaleProfilSkipNodeWithSystemPods" {
  type                          = string
  default                       = null
  description                   = "If true cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods). Defaults to true."
}
##############################################################

variable "AKSDiskEncryptionId" {
  type                          = string
  default                       = null
  description                   = "The encryption id to encrypted nodes disk. Default to null to use Azure managed encryption."
}

variable "LocalAccountDisabled" {
  type                          = bool
  default                       = null
  description                   = "Is local account disabled for AAD integrated kubernetes cluster?"
}

variable "IsOIDCIssuerEnabled" {
  type                          = bool
  default                       = true
  description                   = "Enable or Disable the OIDC issuer URL" 
}

variable "IsRunCommandEnabled" {
  type                          = bool
  default                       = true
  description                   = "Whether to enable run command for the cluster or not. Defaults to true." 
}

##############################################################
# Linux profile config

variable "AKSAdminName" {
  type                          = string
  default                       = "AKSAdmin"
  description                   = "The Admin Username for the Cluster. Changing this forces a new resource to be created."
}

variable "PublicSSHKey" {
  type                          = string
  description                   = "An ssh_key block. Only one is currently allowed. Changing this forces a new resource to be created."
}

##############################################################
# Network profile config

variable "AKSNetworkPlugin" {
  type                          = string
  default                       = "azure"
  description                   = "Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created."
}
variable "AKSNetworkDNS" {
  type                          = string
  default                       = null
  description                   = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created."
}

variable "AKSDockerBridgeCIDR" {
  type                          = string
  default                       = null
  description                   = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created."
}

variable "AKSOutboundType" {
  type                          = string
  default                       = null
  description                   = "The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer."
}

variable "AKSPodCIDR" {
  type                          = string
  default                       = null
  description                   = "The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created."
}

variable "AKSSVCCIDR" {
  type                          = string
  default                       = null
  description                   = "The Network Range used by the Kubernetes service. Changing this forces a new resource to be created."
}

variable "AKSLBSku" {
  type                          = string
  default                       = "standard"
  description                   = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are Basic and Standard. Defaults to Standard."
}

variable "AKSNetPolProvider" {
  type                          = string
  description                   = "Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created."
  default                       = "calico"
}

variable "AKSLBOutboundPortsAllocated" {
  type                          = string
  description                   = "Number of desired SNAT port for each VM in the clusters load balancer. Must be between 0 and 64000 inclusive. Defaults to 0."
  default                       = null
}

variable "AKSLBIdleTimeout" {
  type                          = string
  description                   = "Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between 4 and 120 inclusive. Defaults to 30."
  default                       = null
}

variable "AKSLBOutboundIPCount" {
  type                          = string
  description                   = "Count of desired managed outbound IPs for the cluster load balancer. Must be between 1 and 100 inclusive."
  default                       = 2
}

variable "AKSLBOutboundIPPrefixIds" {
  type                          = list
  description                   = "The ID of the outbound Public IP Address Prefixes which should be used for the cluster load balancer."
  default                       = null
}

variable "AKSLBOutboundIPAddressIds" {
  type                          = list
  description                   = "The ID of the Public IP Addresses which should be used for outbound communication for the cluster load balancer."
  default                       = null
}

##############################################################
# Spec for Node resource group

variable "AKSNodesRG" {
  type                          = string
  default                       = "unspecified"
  description                   = "The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. If set to unspecified, the name is build from a local"
}

variable "UseAKSNodeRGDefaultName" {
  type                          = string
  default                       = false
  description                   = "This variable is used to define if the default name for the node rg is used, default to false, which allows to either use the name provided bu AKSNodeRG or the local in locals.tf"
}

##############################################################
# Spec for private cluster configuration

variable "IsAKSPrivate" {
  type                          = bool
  default                       = false
  description                   = "Should this Kubernetes Cluster have it's API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
}

variable "PrivateDNSZoneId" {
  type                          = string
  default                       = null
  description                   = "Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning."
}

variable "PrivateClusterPublicFqdn" {
  type                          = bool
  default                       = null
  description                   = "Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false."
}

##############################################################
# Variable for AGIC

variable "IsAGICEnabled" {
  type                          = bool
  default                       = false
  description                   = "Whether to deploy the Application Gateway ingress controller to this Kubernetes Cluster?"
}

variable "AGWId" {
  type                          = string
  default                       = null
  description                   = "The ID of the Application Gateway to integrate with the ingress controller of this Kubernetes Cluster."
}

variable "AGWName" {
  type                          = string
  default                       = null
  description                   = "The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster."
}

variable "AGWSubnetCidr" {
  type                          = string
  default                       = null
  description                   = "The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster."
}

variable "AGWSubnetId" {
  type                          = string
  default                       = null
  description                   = "The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster."
}

##############################################################
# Spec for AKS managed identity

variable "AKSIdentityType" {
  type                          = string
  default                       = "SystemAssigned"
  description                   = "Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)."
}

variable "UAIIds" {
  type                          = list
  default                       = null
  description                   = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster."
}

variable "IsKubeletUsingUAI" {
  type                          = bool
  description                   = "A boolean used to activate the block for kubelent identity"
  default                       = true
}
variable "KubeletClientId" {
  type                          = string
  default                       = null
  description                   = "Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)."
}

variable "KubeletObjectId" {
  type                          = string
  default                       = null
  description                   = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster."
}

variable "KubeletUAIId" {
  type                          = string
  default                       = null
  description                   = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster."
}

##############################################################
# RBAC config

variable "AKSClusterAdminsIds" {
  type                          = list(string)
  description                   = " A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
}

variable "AzureRBACEnabled" {
  type                          = bool
  description                   = "A bool to enable or disable Azure RBAC in Kubernetes. True means that Azure Role can be used to grant access inside kubernetes, false means that only Kubernetes roles and binding can be used to managed granular access inside kubernetes"
  default                       = false
}


##############################################################


variable "AKSControlPlaneSku" {
  type                          = string
  default                       = null
  description                   = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free. Note: It is currently possible to upgrade in place from Free to Paid. However, changing this value from Paid to Free will force a new resource to be created."

}

##############################################################
# Addon config


# Azure Policy addon

variable "IsAzPolicyEnabled" {
  type                          = bool
  default                       = true
  description                   = "Is the Azure Policy for Kubernetes Add On enabled? "

}

# http application routing addon

variable "IshttproutingEnabled" {
  type                          = bool
  default                       = false
  description                   = "Is HTTP Application Routing Enabled? Changing this forces a new resource to be created."

}

# CSI driver for KV

variable "IsCSIKVAddonEnabled" {
  type                          = bool
  default                       = false
  description                   = "Is the CSI driver for KV enabled?"

}

variable "CSIKVSecretRotationEnabled" {
  type                          = bool
  default                       = false
  description                   = "Is rotation from the KV secret enabled?"

}

variable "CSIKVSecretRotationInterval" {
  type                          = string
  default                       = "2m"
  description                   = "The interval to poll for secret rotation. This attribute is only set when secret_rotation is true and defaults to 2m."

}

# oms agent addon

variable "IsOMSAgentEnabled" {
  type                          = bool
  default                       = true
  description                   = "Is Container Insight enabled?"
}

variable "LawOMSId" {
  type                          = string
  default                       = "unspecified"
  description                   = "The Id of the log analytics workspace for Container Insight, if not specified, locals will configure the same workspace as for diagnostic settings"
}

# defender addon

variable "IsDefenderEnabled" {
  type                          = bool
  default                       = true
  description                   = "Is Microsoft Defender enabled?"
}

variable "LawDefenderId" {
  type                          = string
  default                       = "unspecified"
  description                   = "The Id of the log analytics workspace for Microsoft defender, if not specified, locals will configure the same workspace as for diagnostic settings"
}
# OSM addon

variable "IsOpenServiceMeshEnabled" {
  type                          = bool
  default                       = false
  description                   = "Is Open Service Mesh enabled?"
}

######################################################
############### Monitoring Variable ##################
######################################################

variable "ACGIds" {
  type                                        = list
  description                                 = "A list of Action GroupResource Id"
  default                                     = []
}

variable "LogCategory" {
  type = map(object({
    IsLogCatEnabledForLAW = bool
    IsLogCatEnabledForSTA = bool
    IsRetentionEnabled    = bool
    RetentionDaysValue    = number
  }))

  description = "A map to feed the log categories of the diagnostic settings"

  default = {

    "kube-apiserver" = {
      IsLogCatEnabledForLAW = true
      IsLogCatEnabledForSTA = true
      IsRetentionEnabled    = true
      RetentionDaysValue    = 365
    }
    "kube-controller-manager" = {
      IsLogCatEnabledForLAW = true
      IsLogCatEnabledForSTA = true
      IsRetentionEnabled    = true
      RetentionDaysValue    = 365
    }
    "kube-scheduler" = {
      IsLogCatEnabledForLAW = true
      IsLogCatEnabledForSTA = true
      IsRetentionEnabled    = true
      RetentionDaysValue    = 365
    }
    "kube-audit" = {
      IsLogCatEnabledForLAW = true
      IsLogCatEnabledForSTA = true
      IsRetentionEnabled    = true
      RetentionDaysValue    = 365
    }
    "cluster-autoscaler" = {
      IsLogCatEnabledForLAW = true
      IsLogCatEnabledForSTA = true
      IsRetentionEnabled    = true
      RetentionDaysValue    = 365
    }
    "kube-audit-admin" = {
      IsLogCatEnabledForLAW = true
      IsLogCatEnabledForSTA = true
      IsRetentionEnabled    = true
      RetentionDaysValue    = 365
    }
    "guard" = {
      IsLogCatEnabledForLAW = true
      IsLogCatEnabledForSTA = true
      IsRetentionEnabled    = true
      RetentionDaysValue    = 365
    }
    "cloud-controller-manager" = {
      IsLogCatEnabledForLAW = true
      IsLogCatEnabledForSTA = true
      IsRetentionEnabled    = true
      RetentionDaysValue    = 365
    }
    "csi-azuredisk-controller" = {
      IsLogCatEnabledForLAW = true
      IsLogCatEnabledForSTA = true
      IsRetentionEnabled    = true
      RetentionDaysValue    = 365
    }
    "csi-azurefile-controller" = {
      IsLogCatEnabledForLAW = true
      IsLogCatEnabledForSTA = true
      IsRetentionEnabled    = true
      RetentionDaysValue    = 365
    }
    "csi-snapshot-controller" = {
      IsLogCatEnabledForLAW = true
      IsLogCatEnabledForSTA = true
      IsRetentionEnabled    = true
      RetentionDaysValue    = 365
    }

  }
}

variable "MetricCategory" {
  type = map(object({
    MetricCatName            = string
    IsMetricCatEnabledForLAW = bool
    IsMetricCatEnabledForSTA = bool
    IsRetentionEnabled       = bool
    RetentionDaysValue       = number
  }))

  description = "A map to feed the log categories of the diagnostic settings"

  default = {

    "Category1" = {
      MetricCatName            = "AllMetrics"
      IsMetricCatEnabledForLAW = false
      IsMetricCatEnabledForSTA = true
      IsRetentionEnabled       = true
      RetentionDaysValue       = 365
    }


  }
}

######################################################
#Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type          = string
  description   = "Tag describing the owner"
  default       = "That would be me"
}

variable "CountryTag" {
  type          = string
  description   = "Tag describing the Country"
  default       = "fr"
}

variable "CostCenterTag" {
  type          = string
  description   = "Tag describing the Cost Center"
  default       = "lab"
}

variable "Company" {
  type          = string
  description   = "The Company owner of the resources"
  default       = "dfitc"
}

variable "Project" {
  type          = string
  description   = "The name of the project"
  default       = "tfmodule"
}

variable "Environment" {
  type          = string
  description   = "The environment, dev, prod..."
  default       = "dev"
}

variable "DefaultTags" {
  type        = map
  description = "Default Tags"
  default     = {
    Environment   = "dev"
    Project       = "tfmodule"
    Company       = "dfitc"
    CostCenter    = "lab"
    Country       = "fr"
    ResourceOwne  = "That could be me"
  }
}

variable "extra_tags" {
  type        = map
  description = "Additional optional tags."
  default     = {}
}