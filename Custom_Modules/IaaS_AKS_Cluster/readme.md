<!-- BEGIN_TF_DOCS -->

# Module Azure Kubernetes Cluster

This module is used to provision an Azure Kubernetes Cluster and related resources

## Module description

This module deploys an Azure Kubernetes Cluster
It includes configuration for:

- The cluster,
- Azure diagnostic settings for the cluster,
- User Assign managed identity for the control plane,
- Azure monitor alerts for the cluster,
- Azure role assignment for the OMS managed identity if the addon is enabled.

## Deployment options

Diagnostic settings send logs to a storage account and a log analytic workspace. The resources are referenced through their resource ids. If not specified, the module can create a storage acocunt and a log analytics workspace. The variables `StaLogId` and `LawLogId` are set to `unspecified`. If set at module call, the values must be valid resource Ids. However, there is no variable validation at this time

The target resource group can also either be specified, by its name, or be created by the module. The default value of the variable `AKSRGName` is set to `unspecified` so that the RG is created by the module.

## How to call the module

AKS cluster creation, with diagnostic settings, oms agent and defender specified:

```hcl

######################################################################
# Creating an Azure Kubernetes Cluster

module "AKS" {

  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/IaaS_AKS_Cluster?ref=aksv1.2" 

  #Module variable

  AKSLocation                           = azurerm_resource_group.RG.location
  AKSRGName                             = azurerm_resource_group.RG.name
  AKSSubnetId                           = azurerm_subnet.subnet.id
  AKSNetworkPlugin                      = "kubenet"
  AKSNetPolProvider                     = "calico"
  AKSClusSuffix                         = "lab1"
  AKSIdentityType                       = "UserAssigned"
  UAIIds                                = ["<UAI_ID>"]
  PublicSSHKey                          = "<SSH_Key>"
  AKSClusterAdminsIds                   = ["<AAD_Group_Object_Id>"]

  LawLogId                              = "<Log_analytics_workspace_id_for_Diagnostic_settings>"
  StaLogId                              = "<Storage_for_monitoring_id>"

  LawOMSId                              = "<Log_analytics_workspace_id_for_OMS>"
  IsOMSAgentEnabled                     = true

  LawDefenderId                         = "<Log_analytics_workspace_id_for_Defender>"
  IsDefenderEnabled                     = true

  EnableDiagSettings                    = true


}

```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.108.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.108.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ACGIds"></a> [ACGIds](#input\_ACGIds) | A list of Action GroupResource Id | `list(any)` | `[]` | no |
| <a name="input_AGWId"></a> [AGWId](#input\_AGWId) | The ID of the Application Gateway to integrate with the ingress controller of this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_AGWName"></a> [AGWName](#input\_AGWName) | The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_AGWSubnetCidr"></a> [AGWSubnetCidr](#input\_AGWSubnetCidr) | The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_AGWSubnetId"></a> [AGWSubnetId](#input\_AGWSubnetId) | The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_AKSAZ"></a> [AKSAZ](#input\_AKSAZ) | A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |
| <a name="input_AKSAdminName"></a> [AKSAdminName](#input\_AKSAdminName) | The Admin Username for the Cluster. Changing this forces a new resource to be created. | `string` | `"AKSAdmin"` | no |
| <a name="input_AKSCapacityReservationGroupId"></a> [AKSCapacityReservationGroupId](#input\_AKSCapacityReservationGroupId) | The Capacity Reservation Group ID to use for the Node Pool. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_AKSClusSuffix"></a> [AKSClusSuffix](#input\_AKSClusSuffix) | A suffix to identify the cluster without breacking the naming convention. Changing this will change the name so forces a new resource to be created. | `string` | `"AksClus"` | no |
| <a name="input_AKSClusterAdminsIds"></a> [AKSClusterAdminsIds](#input\_AKSClusterAdminsIds) | A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster. | `list(string)` | n/a | yes |
| <a name="input_AKSControlPlaneSku"></a> [AKSControlPlaneSku](#input\_AKSControlPlaneSku) | The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free. Note: It is currently possible to upgrade in place from Free to Paid. However, changing this value from Paid to Free will force a new resource to be created. | `string` | `null` | no |
| <a name="input_AKSDiskEncryptionId"></a> [AKSDiskEncryptionId](#input\_AKSDiskEncryptionId) | The encryption id to encrypted nodes disk. Default to null to use Azure managed encryption. | `string` | `null` | no |
| <a name="input_AKSDockerBridgeCIDR"></a> [AKSDockerBridgeCIDR](#input\_AKSDockerBridgeCIDR) | IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_AKSEbpfDataplane"></a> [AKSEbpfDataplane](#input\_AKSEbpfDataplane) | Define the eBPF Dataplane. can be only cilium if set. Default to null | `string` | `null` | no |
| <a name="input_AKSIdentityType"></a> [AKSIdentityType](#input\_AKSIdentityType) | Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both). | `string` | `"SystemAssigned"` | no |
| <a name="input_AKSLBIdleTimeout"></a> [AKSLBIdleTimeout](#input\_AKSLBIdleTimeout) | Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between 4 and 120 inclusive. Defaults to 30. | `string` | `null` | no |
| <a name="input_AKSLBOutboundIPAddressIds"></a> [AKSLBOutboundIPAddressIds](#input\_AKSLBOutboundIPAddressIds) | The ID of the Public IP Addresses which should be used for outbound communication for the cluster load balancer. | `list(any)` | `null` | no |
| <a name="input_AKSLBOutboundIPCount"></a> [AKSLBOutboundIPCount](#input\_AKSLBOutboundIPCount) | Count of desired managed outbound IPs for the cluster load balancer. Must be between 1 and 100 inclusive. | `string` | `2` | no |
| <a name="input_AKSLBOutboundIPPrefixIds"></a> [AKSLBOutboundIPPrefixIds](#input\_AKSLBOutboundIPPrefixIds) | The ID of the outbound Public IP Address Prefixes which should be used for the cluster load balancer. | `list(any)` | `null` | no |
| <a name="input_AKSLBOutboundPortsAllocated"></a> [AKSLBOutboundPortsAllocated](#input\_AKSLBOutboundPortsAllocated) | Number of desired SNAT port for each VM in the clusters load balancer. Must be between 0 and 64000 inclusive. Defaults to 0. | `string` | `null` | no |
| <a name="input_AKSLBSku"></a> [AKSLBSku](#input\_AKSLBSku) | Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are Basic and Standard. Defaults to Standard. | `string` | `"standard"` | no |
| <a name="input_AKSLocation"></a> [AKSLocation](#input\_AKSLocation) | The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created. | `string` | `"eastus"` | no |
| <a name="input_AKSMaxPods"></a> [AKSMaxPods](#input\_AKSMaxPods) | Define the max pod number per nodes, Change force new resoure to be created | `string` | `100` | no |
| <a name="input_AKSNetPolProvider"></a> [AKSNetPolProvider](#input\_AKSNetPolProvider) | Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. | `string` | `"calico"` | no |
| <a name="input_AKSNetworkDNS"></a> [AKSNetworkDNS](#input\_AKSNetworkDNS) | IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_AKSNetworkPlugin"></a> [AKSNetworkPlugin](#input\_AKSNetworkPlugin) | Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created. | `string` | `"azure"` | no |
| <a name="input_AKSNetworkPluginMode"></a> [AKSNetworkPluginMode](#input\_AKSNetworkPluginMode) | Specifies the network plugin mode used for building the Kubernetes network. Possible value is overlay. | `string` | `null` | no |
| <a name="input_AKSNodeCount"></a> [AKSNodeCount](#input\_AKSNodeCount) | The number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100. | `string` | `3` | no |
| <a name="input_AKSNodeInstanceType"></a> [AKSNodeInstanceType](#input\_AKSNodeInstanceType) | The size of the Virtual Machine, such as Standard\_DS2\_v2. | `string` | `"standard_d2s_v4"` | no |
| <a name="input_AKSNodeLabels"></a> [AKSNodeLabels](#input\_AKSNodeLabels) | A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created. | `map(any)` | `null` | no |
| <a name="input_AKSNodeOSDiskSize"></a> [AKSNodeOSDiskSize](#input\_AKSNodeOSDiskSize) | The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created. | `string` | `127` | no |
| <a name="input_AKSNodeOSDiskType"></a> [AKSNodeOSDiskType](#input\_AKSNodeOSDiskType) | The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_AKSNodeOSSku"></a> [AKSNodeOSSku](#input\_AKSNodeOSSku) | OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. Possible values include: Ubuntu, CBLMariner. Defaults to Ubuntu. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_AKSNodePodSubnetId"></a> [AKSNodePodSubnetId](#input\_AKSNodePodSubnetId) | The ID of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_AKSNodeUltraSSDEnabled"></a> [AKSNodeUltraSSDEnabled](#input\_AKSNodeUltraSSDEnabled) | Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false. | `string` | `null` | no |
| <a name="input_AKSNodesRG"></a> [AKSNodesRG](#input\_AKSNodesRG) | The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. If set to unspecified, the name is build from a local | `string` | `"unspecified"` | no |
| <a name="input_AKSOutboundType"></a> [AKSOutboundType](#input\_AKSOutboundType) | The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer. | `string` | `null` | no |
| <a name="input_AKSPodCIDR"></a> [AKSPodCIDR](#input\_AKSPodCIDR) | The CIDR to use for pod IP addresses. This field can only be set when network\_plugin is set to kubenet. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_AKSRGName"></a> [AKSRGName](#input\_AKSRGName) | Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created. | `string` | `"unspecified"` | no |
| <a name="input_AKSSVCCIDR"></a> [AKSSVCCIDR](#input\_AKSSVCCIDR) | The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_AKSSubnetId"></a> [AKSSubnetId](#input\_AKSSubnetId) | The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_AKSUpgradeDrainTimeOut"></a> [AKSUpgradeDrainTimeOut](#input\_AKSUpgradeDrainTimeOut) | The amount of time in minutes to wait on eviction of pods and graceful termination per node. This eviction wait time honors pod disruption budgets for upgrades. If this time is exceeded, the upgrade fails. Unsetting this after configuring it will force a new resource to be created. | `number` | `null` | no |
| <a name="input_AKSUpgradeMaxSurge"></a> [AKSUpgradeMaxSurge](#input\_AKSUpgradeMaxSurge) | Define the number of nodes created during an upgrade process. Can be a number or a percentage | `string` | `"33%"` | no |
| <a name="input_AKSUpgradeNodeSoakDuration"></a> [AKSUpgradeNodeSoakDuration](#input\_AKSUpgradeNodeSoakDuration) | The amount of time in minutes to wait after draining a node and before reimaging and moving on to next node. Defaults to 0. | `number` | `null` | no |
| <a name="input_AksLogCategories"></a> [AksLogCategories](#input\_AksLogCategories) | A list of log categories to activate on the Aks Cluster. If set to null, it will use a data source to enable all categories | `list(any)` | `null` | no |
| <a name="input_AksMetricCategories"></a> [AksMetricCategories](#input\_AksMetricCategories) | A list of metric categories to activate on the Aks Cluster. If set to null, it will use a data source to enable all categories | `list(any)` | `null` | no |
| <a name="input_ApiAllowedIps"></a> [ApiAllowedIps](#input\_ApiAllowedIps) | A list of allowed IP on the API Server | `list(string)` | `[]` | no |
| <a name="input_ApiSubnetId"></a> [ApiSubnetId](#input\_ApiSubnetId) | The subnet id for the Api Server Vnet integration | `string` | `null` | no |
| <a name="input_AutoScaleProfilBalanceSimilarNdGP"></a> [AutoScaleProfilBalanceSimilarNdGP](#input\_AutoScaleProfilBalanceSimilarNdGP) | Detect similar node groups and balance the number of nodes between them. Defaults to false. | `string` | `null` | no |
| <a name="input_AutoScaleProfilExpander"></a> [AutoScaleProfilExpander](#input\_AutoScaleProfilExpander) | Expander to use. Possible values are least-waste, priority, most-pods and random. Defaults to random. | `string` | `null` | no |
| <a name="input_AutoScaleProfilMaxGracefullTerm"></a> [AutoScaleProfilMaxGracefullTerm](#input\_AutoScaleProfilMaxGracefullTerm) | Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to 600. | `string` | `null` | no |
| <a name="input_AutoScaleProfilScaleDownAfterAdd"></a> [AutoScaleProfilScaleDownAfterAdd](#input\_AutoScaleProfilScaleDownAfterAdd) | How long after the scale up of AKS nodes the scale down evaluation resumes. Defaults to 10m. | `string` | `null` | no |
| <a name="input_AutoScaleProfilScaleDownAfterDelete"></a> [AutoScaleProfilScaleDownAfterDelete](#input\_AutoScaleProfilScaleDownAfterDelete) | How long after node deletion that scale down evaluation resumes. Defaults to the value used for scan\_interval. | `string` | `null` | no |
| <a name="input_AutoScaleProfilScaleDownAfterFail"></a> [AutoScaleProfilScaleDownAfterFail](#input\_AutoScaleProfilScaleDownAfterFail) | How long after scale down failure that scale down evaluation resumes. Defaults to 3m. | `string` | `null` | no |
| <a name="input_AutoScaleProfilScaleDownUnneeded"></a> [AutoScaleProfilScaleDownUnneeded](#input\_AutoScaleProfilScaleDownUnneeded) | How long a node should be unneeded before it is eligible for scale down. Defaults to 10m. | `string` | `null` | no |
| <a name="input_AutoScaleProfilScaleDownUnready"></a> [AutoScaleProfilScaleDownUnready](#input\_AutoScaleProfilScaleDownUnready) | How long an unready node should be unneeded before it is eligible for scale down. Defaults to 20m. | `string` | `null` | no |
| <a name="input_AutoScaleProfilScaleDownUtilThreshold"></a> [AutoScaleProfilScaleDownUtilThreshold](#input\_AutoScaleProfilScaleDownUtilThreshold) | Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. Defaults to 0.5. | `string` | `null` | no |
| <a name="input_AutoScaleProfilScanInterval"></a> [AutoScaleProfilScanInterval](#input\_AutoScaleProfilScanInterval) | How often the AKS Cluster should be re-evaluated for scale up/down. Defaults to 10s. | `string` | `null` | no |
| <a name="input_AutoUpgradeChannelConfig"></a> [AutoUpgradeChannelConfig](#input\_AutoUpgradeChannelConfig) | The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none. | `string` | `null` | no |
| <a name="input_AutoscaleProfilEmptyBulkDeleteMax"></a> [AutoscaleProfilEmptyBulkDeleteMax](#input\_AutoscaleProfilEmptyBulkDeleteMax) | Maximum number of empty nodes that can be deleted at the same time. Defaults to 10. | `string` | `null` | no |
| <a name="input_AutoscaleProfilMaxNodeProvTime"></a> [AutoscaleProfilMaxNodeProvTime](#input\_AutoscaleProfilMaxNodeProvTime) | Maximum time the autoscaler waits for a node to be provisioned. Defaults to 15m. | `string` | `null` | no |
| <a name="input_AutoscaleProfilMaxUnreadyNodes"></a> [AutoscaleProfilMaxUnreadyNodes](#input\_AutoscaleProfilMaxUnreadyNodes) | Maximum Number of allowed unready nodes. Defaults to 3. | `string` | `null` | no |
| <a name="input_AutoscaleProfilMaxUnreadyPercentage"></a> [AutoscaleProfilMaxUnreadyPercentage](#input\_AutoscaleProfilMaxUnreadyPercentage) | Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded. Defaults to 45. | `string` | `null` | no |
| <a name="input_AutoscaleProfilNewPodScaleUpDelay"></a> [AutoscaleProfilNewPodScaleUpDelay](#input\_AutoscaleProfilNewPodScaleUpDelay) | For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. Defaults to 10s. | `string` | `null` | no |
| <a name="input_AutoscaleProfilSkipNodeWithSystemPods"></a> [AutoscaleProfilSkipNodeWithSystemPods](#input\_AutoscaleProfilSkipNodeWithSystemPods) | If true cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods). Defaults to true. | `string` | `null` | no |
| <a name="input_AutoscaleProfilSkipNodesWLocalStorage"></a> [AutoscaleProfilSkipNodesWLocalStorage](#input\_AutoscaleProfilSkipNodesWLocalStorage) | If true cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath. Defaults to true. | `string` | `null` | no |
| <a name="input_AzureRBACEnabled"></a> [AzureRBACEnabled](#input\_AzureRBACEnabled) | A bool to enable or disable Azure RBAC in Kubernetes. True means that Azure Role can be used to grant access inside kubernetes, false means that only Kubernetes roles and binding can be used to managed granular access inside kubernetes | `bool` | `false` | no |
| <a name="input_CSIKVSecretRotationEnabled"></a> [CSIKVSecretRotationEnabled](#input\_CSIKVSecretRotationEnabled) | Is rotation from the KV secret enabled? | `bool` | `true` | no |
| <a name="input_CSIKVSecretRotationInterval"></a> [CSIKVSecretRotationInterval](#input\_CSIKVSecretRotationInterval) | The interval to poll for secret rotation. This attribute is only set when secret\_rotation is true and defaults to 2m. | `string` | `"2m"` | no |
| <a name="input_CustomAsgList"></a> [CustomAsgList](#input\_CustomAsgList) | A list of Asg Ids to attach to the default node pool | `list(string)` | `[]` | no |
| <a name="input_CustomFQDNPrefix"></a> [CustomFQDNPrefix](#input\_CustomFQDNPrefix) | A string to specify a custom fqdn prefix instead of the default built with tags | `string` | `""` | no |
| <a name="input_CustomPrivateFQDNPrefix"></a> [CustomPrivateFQDNPrefix](#input\_CustomPrivateFQDNPrefix) | Same as the CustomFQDNPrefix variable, but for private cluster in byo dns zone | `string` | `""` | no |
| <a name="input_DefaultTags"></a> [DefaultTags](#input\_DefaultTags) | Default Tags | `map(any)` | <pre>{<br>  "Company": "dfitc",<br>  "CostCenter": "lab",<br>  "Country": "fr",<br>  "Environment": "dev",<br>  "Project": "tfmodule",<br>  "ResourceOwner": "That could be me"<br>}</pre> | no |
| <a name="input_DiskDriverVersion"></a> [DiskDriverVersion](#input\_DiskDriverVersion) | Disk CSI Driver version to be used. Possible values are v1 and v2. Defaults to v1. | `string` | `null` | no |
| <a name="input_EnableAKSAutoScale"></a> [EnableAKSAutoScale](#input\_EnableAKSAutoScale) | Should the Kubernetes Auto Scaler be enabled for this Node Pool? Defaults to true. | `string` | `true` | no |
| <a name="input_EnableApiVnetIntegration"></a> [EnableApiVnetIntegration](#input\_EnableApiVnetIntegration) | A bool to enable or disable | `bool` | `false` | no |
| <a name="input_EnableDiagSettings"></a> [EnableDiagSettings](#input\_EnableDiagSettings) | A bool to enable or disable the diagnostic settings | `bool` | `false` | no |
| <a name="input_EnableHostEncryption"></a> [EnableHostEncryption](#input\_EnableHostEncryption) | Should the nodes in the Default Node Pool have host encryption enabled? Defaults to true. | `string` | `true` | no |
| <a name="input_EnableNodePublicIP"></a> [EnableNodePublicIP](#input\_EnableNodePublicIP) | Define if Nodes get Public IP. Defualt API value is false | `string` | `null` | no |
| <a name="input_EntraIdTenantId"></a> [EntraIdTenantId](#input\_EntraIdTenantId) | The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used. | `string` | `null` | no |
| <a name="input_GPUInstance"></a> [GPUInstance](#input\_GPUInstance) | The type of GPU instance to use for the Default Node Pool. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_HostGroupId"></a> [HostGroupId](#input\_HostGroupId) | The Host Group ID to use for the Default Node Pool. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_IsAGICEnabled"></a> [IsAGICEnabled](#input\_IsAGICEnabled) | Whether to deploy the Application Gateway ingress controller to this Kubernetes Cluster? | `bool` | `false` | no |
| <a name="input_IsAKSKMSEnabled"></a> [IsAKSKMSEnabled](#input\_IsAKSKMSEnabled) | A bool to activate the kms etcd feature block | `bool` | `false` | no |
| <a name="input_IsAKSPrivate"></a> [IsAKSPrivate](#input\_IsAKSPrivate) | Should this Kubernetes Cluster have it's API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_IsAzPolicyEnabled"></a> [IsAzPolicyEnabled](#input\_IsAzPolicyEnabled) | Is the Azure Policy for Kubernetes Add On enabled? | `bool` | `true` | no |
| <a name="input_IsBYOPrivateDNSZone"></a> [IsBYOPrivateDNSZone](#input\_IsBYOPrivateDNSZone) | Specify if the cluster is configured for BYO DNS private zone. If true, the parameter dns\_prefix\_private\_cluster is set with the fqdn value, if false, it is set to null and the dns\_prefix is set instead | `bool` | `false` | no |
| <a name="input_IsBlobDriverEnabled"></a> [IsBlobDriverEnabled](#input\_IsBlobDriverEnabled) | Is the Blob CSI driver enabled? Defaults to false. | `bool` | `true` | no |
| <a name="input_IsCSIKVAddonEnabled"></a> [IsCSIKVAddonEnabled](#input\_IsCSIKVAddonEnabled) | Is the CSI driver for KV enabled? | `bool` | `true` | no |
| <a name="input_IsDefenderEnabled"></a> [IsDefenderEnabled](#input\_IsDefenderEnabled) | Is Microsoft Defender enabled? | `bool` | `true` | no |
| <a name="input_IsDiskDriverEnabled"></a> [IsDiskDriverEnabled](#input\_IsDiskDriverEnabled) | Is the Disk CSI driver enabled? Defaults to true. | `bool` | `null` | no |
| <a name="input_IsFileDriverEnabled"></a> [IsFileDriverEnabled](#input\_IsFileDriverEnabled) | Is the File CSI driver enabled? Defaults to true. | `bool` | `null` | no |
| <a name="input_IsKubeletUsingUAI"></a> [IsKubeletUsingUAI](#input\_IsKubeletUsingUAI) | A boolean used to activate the block for kubelet identity | `bool` | `true` | no |
| <a name="input_IsOIDCIssuerEnabled"></a> [IsOIDCIssuerEnabled](#input\_IsOIDCIssuerEnabled) | Enable or Disable the OIDC issuer URL | `bool` | `true` | no |
| <a name="input_IsOMSAgentEnabled"></a> [IsOMSAgentEnabled](#input\_IsOMSAgentEnabled) | Is Container Insight enabled? | `bool` | `true` | no |
| <a name="input_IsOpenServiceMeshEnabled"></a> [IsOpenServiceMeshEnabled](#input\_IsOpenServiceMeshEnabled) | Is Open Service Mesh enabled? | `bool` | `false` | no |
| <a name="input_IsRunCommandEnabled"></a> [IsRunCommandEnabled](#input\_IsRunCommandEnabled) | Whether to enable run command for the cluster or not. Defaults to true. | `bool` | `true` | no |
| <a name="input_IsSnapshotControllerEnabled"></a> [IsSnapshotControllerEnabled](#input\_IsSnapshotControllerEnabled) | Is the Snapshot Controller enabled? Defaults to true. | `bool` | `null` | no |
| <a name="input_IsWorkloadIdentityEnabled"></a> [IsWorkloadIdentityEnabled](#input\_IsWorkloadIdentityEnabled) | Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false if not set. | `bool` | `true` | no |
| <a name="input_IshttproutingEnabled"></a> [IshttproutingEnabled](#input\_IshttproutingEnabled) | Is HTTP Application Routing Enabled? Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_KmsKeyVaultKeyId"></a> [KmsKeyVaultKeyId](#input\_KmsKeyVaultKeyId) | Identifier of Azure Key Vault key. See key identifier format for more details. When Azure Key Vault key management service is enabled, this field is required and must be a valid key identifier. When enabled is false, leave the field empty | `string` | `null` | no |
| <a name="input_KmsKeyvaultNtwAccess"></a> [KmsKeyvaultNtwAccess](#input\_KmsKeyvaultNtwAccess) | Network access of the key vault Network access of key vault. The possible values are Public and Private. Public means the key vault allows public access from all networks. Private means the key vault disables public access and enables private link. The default value is Public. | `string` | `null` | no |
| <a name="input_KubeVersion"></a> [KubeVersion](#input\_KubeVersion) | The version of Kube, used for Node pool version but also for Control plane version | `string` | `null` | no |
| <a name="input_KubeletAllowedUnsafeSysctls"></a> [KubeletAllowedUnsafeSysctls](#input\_KubeletAllowedUnsafeSysctls) | Specifies the allow list of unsafe sysctls command or patterns (ending in *). Changing this forces a new resource to be created. | `list(string)` | `null` | no |
| <a name="input_KubeletClientId"></a> [KubeletClientId](#input\_KubeletClientId) | Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both). | `string` | `null` | no |
| <a name="input_KubeletContainerLogMaxLine"></a> [KubeletContainerLogMaxLine](#input\_KubeletContainerLogMaxLine) | Specifies the maximum number of container log files that can be present for a container. must be at least 2. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_KubeletContainerLogMaxSize"></a> [KubeletContainerLogMaxSize](#input\_KubeletContainerLogMaxSize) | Specifies the maximum size (e.g. 10MB) of container log file before it is rotated. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_KubeletCpuCfsQuotaEnabled"></a> [KubeletCpuCfsQuotaEnabled](#input\_KubeletCpuCfsQuotaEnabled) | Is CPU CFS quota enforcement for containers enabled? Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_KubeletCpuCfsQuotaPeriod"></a> [KubeletCpuCfsQuotaPeriod](#input\_KubeletCpuCfsQuotaPeriod) | Specifies the CPU CFS quota period value. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_KubeletCpuManagerPolicy"></a> [KubeletCpuManagerPolicy](#input\_KubeletCpuManagerPolicy) | Specifies the CPU Manager policy to use. Possible values are none and static, Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_KubeletDiskType"></a> [KubeletDiskType](#input\_KubeletDiskType) | The type of disk used by kubelet. At this time the only possible value is OS. | `string` | `null` | no |
| <a name="input_KubeletImageGcHighThreshold"></a> [KubeletImageGcHighThreshold](#input\_KubeletImageGcHighThreshold) | Specifies the percent of disk usage above which image garbage collection is always run. Must be between 0 and 100. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_KubeletImageGcLowThreshold"></a> [KubeletImageGcLowThreshold](#input\_KubeletImageGcLowThreshold) | Specifies the percent of disk usage lower than which image garbage collection is never run. Must be between 0 and 100. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_KubeletObjectId"></a> [KubeletObjectId](#input\_KubeletObjectId) | Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_KubeletPodMaxPid"></a> [KubeletPodMaxPid](#input\_KubeletPodMaxPid) | Specifies the maximum number of processes per pod. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_KubeletTopologyManagerPolicy"></a> [KubeletTopologyManagerPolicy](#input\_KubeletTopologyManagerPolicy) | Specifies the Topology Manager policy to use. Possible values are none, best-effort, restricted or single-numa-node. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_KubeletUAIId"></a> [KubeletUAIId](#input\_KubeletUAIId) | Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_LawDefenderId"></a> [LawDefenderId](#input\_LawDefenderId) | The Id of the log analytics workspace for Microsoft defender, if not specified, locals will configure the same workspace as for diagnostic settings | `string` | `"unspecified"` | no |
| <a name="input_LawLogId"></a> [LawLogId](#input\_LawLogId) | ID of the log analytics workspace containing the logs, if not specified, no diagnostic settings to log analytics is created | `string` | `"unspecified"` | no |
| <a name="input_LawOMSId"></a> [LawOMSId](#input\_LawOMSId) | The Id of the log analytics workspace for Container Insight, if not specified, locals will configure the same workspace as for diagnostic settings | `string` | `"unspecified"` | no |
| <a name="input_LinuxOSConfigSwapFileSize"></a> [LinuxOSConfigSwapFileSize](#input\_LinuxOSConfigSwapFileSize) | Specifies the size of swap file on each node in MB. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_LinuxOSConfigTransparentHugePageDefrag"></a> [LinuxOSConfigTransparentHugePageDefrag](#input\_LinuxOSConfigTransparentHugePageDefrag) | Specifies the defrag configuration for Transparent Huge Page. Possible values are always, defer, defer+madvise, madvise and never. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_LinuxOSConfigTransparentHugePageEnabled"></a> [LinuxOSConfigTransparentHugePageEnabled](#input\_LinuxOSConfigTransparentHugePageEnabled) | Specifies the Transparent Huge Page enabled configuration. Possible values are always, madvise and never. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_LocalAccountDisabled"></a> [LocalAccountDisabled](#input\_LocalAccountDisabled) | Is local account disabled for AAD integrated kubernetes cluster? | `bool` | `true` | no |
| <a name="input_MaxAutoScaleCount"></a> [MaxAutoScaleCount](#input\_MaxAutoScaleCount) | The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100 | `string` | `10` | no |
| <a name="input_MinAutoScaleCount"></a> [MinAutoScaleCount](#input\_MinAutoScaleCount) | The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100. | `string` | `2` | no |
| <a name="input_NodePoolAllowedPorts"></a> [NodePoolAllowedPorts](#input\_NodePoolAllowedPorts) | A map to define allowed ports on the default node pool | <pre>map(object({<br>    PortStart = optional(number, null)<br>    PortEnd   = optional(number, null)<br>    protocol  = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_NodePoolWithFIPSEnabled"></a> [NodePoolWithFIPSEnabled](#input\_NodePoolWithFIPSEnabled) | Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_NodePublicIpPrefixId"></a> [NodePublicIpPrefixId](#input\_NodePublicIpPrefixId) | Define if Nodes get Public IP. Defualt API value is false | `string` | `null` | no |
| <a name="input_PrivateClusterPublicFqdn"></a> [PrivateClusterPublicFqdn](#input\_PrivateClusterPublicFqdn) | Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false. Note: If set to true, alocal is used to set the private\_dns\_zone\_id to None | `bool` | `false` | no |
| <a name="input_PrivateDNSZoneId"></a> [PrivateDNSZoneId](#input\_PrivateDNSZoneId) | Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. | `string` | `null` | no |
| <a name="input_PublicSSHKey"></a> [PublicSSHKey](#input\_PublicSSHKey) | An ssh\_key block. Only one is currently allowed. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_StaLogId"></a> [StaLogId](#input\_StaLogId) | Id of the storage account containing the logs, if not specified, no diagnostic settings to storage account is created | `string` | `"unspecified"` | no |
| <a name="input_SysCtlFsAioMaxNr"></a> [SysCtlFsAioMaxNr](#input\_SysCtlFsAioMaxNr) | The sysctl setting fs.aio-max-nr. Must be between 65536 and 6553500. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlFsFileMax"></a> [SysCtlFsFileMax](#input\_SysCtlFsFileMax) | The sysctl setting fs.file-max. Must be between 8192 and 12000500. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlFsInotifyMaxUserWatches"></a> [SysCtlFsInotifyMaxUserWatches](#input\_SysCtlFsInotifyMaxUserWatches) | The sysctl setting fs.inotify.max\_user\_watches. Must be between 781250 and 2097152. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlFsNrOpen"></a> [SysCtlFsNrOpen](#input\_SysCtlFsNrOpen) | The sysctl setting fs.nr\_open. Must be between 8192 and 20000500. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlKernelThreadsMax"></a> [SysCtlKernelThreadsMax](#input\_SysCtlKernelThreadsMax) | The sysctl setting kernel.threads-max. Must be between 20 and 513785. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetCoreOptmemMax"></a> [SysCtlNetCoreOptmemMax](#input\_SysCtlNetCoreOptmemMax) | The sysctl setting net.core.optmem\_max. Must be between 20480 and 4194304. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetCoreRmemDefault"></a> [SysCtlNetCoreRmemDefault](#input\_SysCtlNetCoreRmemDefault) | The sysctl setting net.core.rmem\_default. Must be between 212992 and 134217728. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetCoreRmemMax"></a> [SysCtlNetCoreRmemMax](#input\_SysCtlNetCoreRmemMax) | The sysctl setting net.core.rmem\_max. Must be between 212992 and 134217728. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetCoreSomaxconn"></a> [SysCtlNetCoreSomaxconn](#input\_SysCtlNetCoreSomaxconn) | The sysctl setting net.core.somaxconn. Must be between 4096 and 3240000. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetCoreWmemDefault"></a> [SysCtlNetCoreWmemDefault](#input\_SysCtlNetCoreWmemDefault) | The sysctl setting net.core.wmem\_default. Must be between 212992 and 134217728. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetCoreWmemMax"></a> [SysCtlNetCoreWmemMax](#input\_SysCtlNetCoreWmemMax) | The sysctl setting net.core.wmem\_max. Must be between 212992 and 134217728. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetCoredevMaxBacklog"></a> [SysCtlNetCoredevMaxBacklog](#input\_SysCtlNetCoredevMaxBacklog) | The sysctl setting net.core.netdev\_max\_backlog. Must be between 1000 and 3240000. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetIpv4IpLocalPortRangeMax"></a> [SysCtlNetIpv4IpLocalPortRangeMax](#input\_SysCtlNetIpv4IpLocalPortRangeMax) | The sysctl setting net.ipv4.ip\_local\_port\_range max value. Must be between 1024 and 60999. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetIpv4IpLocalPortRangeMin"></a> [SysCtlNetIpv4IpLocalPortRangeMin](#input\_SysCtlNetIpv4IpLocalPortRangeMin) | The sysctl setting net.ipv4.ip\_local\_port\_range min value. Must be between 1024 and 60999. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetIpv4NTcpFinTimeOut"></a> [SysCtlNetIpv4NTcpFinTimeOut](#input\_SysCtlNetIpv4NTcpFinTimeOut) | The sysctl setting net.ipv4.tcp\_fin\_timeout. Must be between 5 and 120. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetIpv4NTcpKeepAliveIntvl"></a> [SysCtlNetIpv4NTcpKeepAliveIntvl](#input\_SysCtlNetIpv4NTcpKeepAliveIntvl) | The sysctl setting net.ipv4.tcp\_keepalive\_intvl. Must be between 10 and 75. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetIpv4NTcpKeepAliveProbes"></a> [SysCtlNetIpv4NTcpKeepAliveProbes](#input\_SysCtlNetIpv4NTcpKeepAliveProbes) | The sysctl setting net.ipv4.tcp\_keepalive\_probes. Must be between 1 and 15. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetIpv4NTcpKeepAliveTime"></a> [SysCtlNetIpv4NTcpKeepAliveTime](#input\_SysCtlNetIpv4NTcpKeepAliveTime) | The sysctl setting net.ipv4.tcp\_keepalive\_time. Must be between 30 and 432000. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetIpv4NTcpMaxSynBacklog"></a> [SysCtlNetIpv4NTcpMaxSynBacklog](#input\_SysCtlNetIpv4NTcpMaxSynBacklog) | The sysctl setting net.ipv4.tcp\_max\_syn\_backlog. Must be between 128 and 3240000. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetIpv4NTcpMaxTwBuckets"></a> [SysCtlNetIpv4NTcpMaxTwBuckets](#input\_SysCtlNetIpv4NTcpMaxTwBuckets) | The sysctl setting net.ipv4.tcp\_max\_tw\_buckets. Must be between 8000 and 1440000. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetIpv4NTcpMaxTwReuse"></a> [SysCtlNetIpv4NTcpMaxTwReuse](#input\_SysCtlNetIpv4NTcpMaxTwReuse) | The sysctl setting net.ipv4.tcp\_tw\_reuse. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetIpv4NeighDefaultGcThreshold1"></a> [SysCtlNetIpv4NeighDefaultGcThreshold1](#input\_SysCtlNetIpv4NeighDefaultGcThreshold1) | The sysctl setting net.ipv4.neigh.default.gc\_thresh1. Must be between 128 and 80000. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetIpv4NeighDefaultGcThreshold2"></a> [SysCtlNetIpv4NeighDefaultGcThreshold2](#input\_SysCtlNetIpv4NeighDefaultGcThreshold2) | The sysctl setting net.ipv4.neigh.default.gc\_thresh2. Must be between 512 and 90000. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetIpv4NeighDefaultGcThreshold3"></a> [SysCtlNetIpv4NeighDefaultGcThreshold3](#input\_SysCtlNetIpv4NeighDefaultGcThreshold3) | The sysctl setting net.ipv4.neigh.default.gc\_thresh3. Must be between 512 and 90000. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetfilterNfConntrackBuckets"></a> [SysCtlNetfilterNfConntrackBuckets](#input\_SysCtlNetfilterNfConntrackBuckets) | The sysctl setting net.netfilter.nf\_conntrack\_max. Must be between 131072 and 589824. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlNetfilterNfConntrackMax"></a> [SysCtlNetfilterNfConntrackMax](#input\_SysCtlNetfilterNfConntrackMax) | The sysctl setting net.netfilter.nf\_conntrack\_max. Must be between 131072 and 589824. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlVmMaxMapCount"></a> [SysCtlVmMaxMapCount](#input\_SysCtlVmMaxMapCount) | The sysctl setting vm.max\_map\_count. Must be between 65530 and 262144. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlVmSwapiness"></a> [SysCtlVmSwapiness](#input\_SysCtlVmSwapiness) | The sysctl setting vm.swappiness. Must be between 0 and 100. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_SysCtlVmVfsCachePressure"></a> [SysCtlVmVfsCachePressure](#input\_SysCtlVmVfsCachePressure) | The sysctl setting vm.vfs\_cache\_pressure. Must be between 0 and 100. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_TaintCriticalAddonsEnabled"></a> [TaintCriticalAddonsEnabled](#input\_TaintCriticalAddonsEnabled) | Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_UAIIds"></a> [UAIIds](#input\_UAIIds) | Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster. | `list(any)` | `null` | no |
| <a name="input_UseAKSNodeRGDefaultName"></a> [UseAKSNodeRGDefaultName](#input\_UseAKSNodeRGDefaultName) | This variable is used to define if the default name for the node rg is used, default to false, which allows to either use the name provided bu AKSNodeRG or the local in locals.tf | `string` | `false` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Additional optional tags. | `map(any)` | `{}` | no |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_security_group.NodePoolAsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_security_group) | resource |
| [azurerm_kubernetes_cluster.AKS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_log_analytics_workspace.LawMonitor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_activity_log_alert.ListAKSAdminCredsEvent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert) | resource |
| [azurerm_monitor_diagnostic_setting.AksDiagSettings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_metric_alert.NodeCPUPercentageThreshold](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.NodeDiskPercentageThreshold](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.NodeWorkingSetMemoryPercentageThreshold](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.UnschedulablePodCountThreshold](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_resource_group.RgAks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.MSToMonitorPublisher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.StaMonitor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_monitor_diagnostic_categories.Aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_FullAKS"></a> [FullAKS](#output\_FullAKS) | Full output of the cluster, just in case |
| <a name="output_KubeControlPlane_SAI"></a> [KubeControlPlane\_SAI](#output\_KubeControlPlane\_SAI) | The Identity block for the control plane |
| <a name="output_KubeControlPlane_SAI_PrincipalId"></a> [KubeControlPlane\_SAI\_PrincipalId](#output\_KubeControlPlane\_SAI\_PrincipalId) | Client Id of the AKS control plane. This is this guid that is used to assign rbac role to AKS control plane, such as acces to network operation or dns attachment... |
| <a name="output_KubeControlPlane_SAI_TenantId"></a> [KubeControlPlane\_SAI\_TenantId](#output\_KubeControlPlane\_SAI\_TenantId) | The tenant id in which the control plane identity lives |
| <a name="output_KubeFQDN"></a> [KubeFQDN](#output\_KubeFQDN) | Cluster fully qualified domain name |
| <a name="output_KubeId"></a> [KubeId](#output\_KubeId) | The resource Id of the cluster |
| <a name="output_KubeKubelet_UAI"></a> [KubeKubelet\_UAI](#output\_KubeKubelet\_UAI) | The Kubelet Identity block |
| <a name="output_KubeKubelet_UAI_ClientId"></a> [KubeKubelet\_UAI\_ClientId](#output\_KubeKubelet\_UAI\_ClientId) | Client Id of the Kubelet Identity. This is usually this guid that is used for RBAC assignment to kubelet |
| <a name="output_KubeKubelet_UAI_Id"></a> [KubeKubelet\_UAI\_Id](#output\_KubeKubelet\_UAI\_Id) | n/a |
| <a name="output_KubeKubelet_UAI_ObjectId"></a> [KubeKubelet\_UAI\_ObjectId](#output\_KubeKubelet\_UAI\_ObjectId) | Object Id of the Kubelet Identity |
| <a name="output_KubeLocation"></a> [KubeLocation](#output\_KubeLocation) | The location of the cluster |
| <a name="output_KubeName"></a> [KubeName](#output\_KubeName) | The name of the cluster |
| <a name="output_KubeRG"></a> [KubeRG](#output\_KubeRG) | The resource group containing the control plane of the cluster |
| <a name="output_KubeVersion"></a> [KubeVersion](#output\_KubeVersion) | The version of kubernetes |
| <a name="output_NodeRG"></a> [NodeRG](#output\_NodeRG) | Resource group containing the managed Azure resources of the AKS cluster |
| <a name="output_stalog"></a> [stalog](#output\_stalog) | n/a |

## How to update this documentation

In the module folder, use the following command.

```bash

terraform-docs --config ./.config/.terraform-doc.yml .

```
<!-- END_TF_DOCS -->