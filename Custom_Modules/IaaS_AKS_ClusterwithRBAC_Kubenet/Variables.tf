##############################################################
#This module creates an AKS Clulster with RBAC and Kubenet
##############################################################




variable "LawSubLogId" {
  type          = string
  description   = "ID of the log analytics workspace containing the logs"
}

variable "STASubLogId" {
  type          = string
  description   = "Id of the storage account containing the logs"
}


##############################################################
# basic parameters

variable "AKSClusSuffix" {
  type                          = string
  default                       = "AksClus"
  description                   = "A suffix to identify the cluster without breacking the naming convention"

}


variable "AKSLocation" {
  type                          = string
  description                   = "The region for AKS"
  default                       = "westeurope"
}

variable "AKSRGName" {
  type                          = string
  description                   = "The RG for for AKS"

}

##############################################################
# Default Node pool config

variable "AKSNodeInstanceType" {
  type                          = string
  default                       = "standard_d2s_v4"
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

##############################################################

variable "APIAccessList" {
  type                          = list(string)
  default                       = null
  description                   = "The IP ranges to whitelist for incoming traffic to the masters."
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

##############################################################

variable "AKSDiskEncryptionId" {
  type                          = string
  default                       = null
  description                   = "The encryption id to encrypted nodes disk. Default to null to use Azure managed encryption."
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
  default                       = "Standard"
  description                   = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are Basic and Standard. Defaults to Standard."
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
  type                          = string
  default                       = false
  description                   = "Should this Kubernetes Cluster have it's API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
}

variable "PrivateDNSZoneId" {
  type                          = string
  default                       = null
  description                   = "Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning."
}

##############################################################
# Spec for AKS managed identity

variable "AKSIdentityType" {
  type                          = string
  default                       = "SystemAssigned"
  description                   = "The type of identity used for the managed cluster. Possible values are SystemAssigned and UserAssigned. If UserAssigned is set, a user_assigned_identity_id must be set as well."
}

variable "UAIId" {
  type                          = string
  default                       = null
  description                   = "The ID of a user assigned identity."
}

##############################################################
# RBAC config

variable "AKSClusterAdminsIds" {
  type                          = list(string)
  description                   = " A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
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
  type                          = string
  default                       = true
  description                   = "Is the Azure Policy for Kubernetes Add On enabled? "

}

# http application routing addon

variable "IshttproutingEnabled" {
  type                          = string
  default                       = false
  description                   = "Is HTTP Application Routing Enabled? Changing this forces a new resource to be created."

}

# kube dashboard addon

variable "IsKubeDashboardEnabled" {
  type                          = string
  default                       = false
  description                   = "Is the Kubernetes Dashboard enabled? - Deprecated from aks 1.19.x"

}

# oms agent addon

variable "IsOMSAgentEnabled" {
  type                          = string
  default                       = true
}


######################################################
############### Monitoring Variable ##################
######################################################

variable "ACG1Id" {
  type        = string
  description = "Resource Id of the 1st action group"
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

variable "extra_tags" {
  type        = map
  description = "Additional optional tags."
  default     = {}
}