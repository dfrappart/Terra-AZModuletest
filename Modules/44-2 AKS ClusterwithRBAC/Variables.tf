##############################################################
#AKS Module
##############################################################


##############################################################
#Variable declaration for Module

variable "AKSClusName" {
  type                  = string
  default               = "TerraAkSClus"
  description           = "The name of the cluster"
}

variable "AKSLocation" {
  type                  = string
  description           = "The region of the AKS cluster"
}

variable "AKSRGName" {
  type                  = string
  description           = "The resource group name containing the AKS Control plane"
}

variable "AKSNodesRG" {
  type                  = string
  default               = null
  description           = "Define the name of the resource group that will contains the nodes"
}

##############################################################
# default node pool variables

variable "AKSAgentPoolName" {
  type                  = string
  default               = "aksdefaultpool"
  description           = "The name of the default Agent pool"
}


variable "AKSNodeInstanceType" {
  type                  = string
  default               = "Standard_DS2_v2"
  description           = "The node instance type"
}

variable "AKSAZ" {
  type                  = list(string)
  default               = null
  description           = "Thelist of the AZ targeted by the node pool"
}

variable "EnableAKSAutoScale" {
  type                  = string
  default               = null
  description           = "Define if the AKS Cluster node pool will autoscale or not"
}

variable "EnableNodePublicIP" {
  type                  = string
  default               = null
  description           = "Are Public IP allowed on the nodes in the node pool, default to false"
}

variable "AKSMaxPods" {
  type                  = string
  default               = 100
  description           = "The maximum number of pods per node"
}

variable "AKSNodeLabels" {
  type                  = map
  default               = null
  description           = "The Nodes labels"
}

variable "AKSNodeTaints" {
  type                  = list
  default               = null
  description           = "The Nodes taints list"
}

variable "AKSNodeOSDiskSize" {
  type                  = string
  default               = 30
  description           = "The size of the OS Disk for the node"
}

variable "AKSNodePoolType" {
  type                  = string
  default               = "VirtualMachineScaleSets"
  description           = "The type of node pool"
}

variable "AKSSubnetId" {
  type                  = string
  description           = "The subnet id in which lives the node pool, and thus the nodes"
}



variable "MinAutoScaleCount" {
  type                  = string
  default               = null
}

variable "MaxAutoScaleCount" {
  type                  = string
  default               = null
}

variable "AKSNodeCount" {
  type                  = string
  default               = "3"
}


/*
variable "AKSNodeOSType" {
  type = string
  default = "Linux"
}

*/




##############################################################
# dns related variables


variable "AKSprefix" {
  type                  = string
  default               = "terraaksdfr"
  description           = "DNS prefix for the AKS cluster"
}

##############################################################
# service principal related variables

variable "K8SSPId" {
  type                  = string
  description           = "The App Id of the AAD App used by AKS"
}

variable "K8SSPSecret" {
  type                  = string
  description           = "The App secret of the AAD App used by AKS"
}

##############################################################
# variables for the add on block

variable "AKSLAWId" {
  type                  = string
  description           = "The Id of the associated logs analityc workspace, must be provided if var.IsOMSAgentEnabled is set to true"
  default               = null
}

variable "IsOMSAgentEnabled" {
  type                  = string
  default               = null
  description           = "Define if Log Analytics extension is used or not"
}



variable "KubeVersion" {
  type                  = string
  default               = null
  description           = "The kube version"
}

variable "APIAccessList" {
  type                  = list(string)
  default               = null
  description           = "A list of Public IP authorized to connect to the control plane"
}

variable "EnablePodPolicy" {
  type                  = string
  default               = null
  description           = "Is the pod policy enabled or not"
}


##############################################################
# variables for the linux profile block

variable "AKSAdminName" {
  type = string
  default               = "aksadmin"
  description           = "admin for the node"
}

variable "PublicSSHKey" {
  type                  = string
  description           = "ssh key for the node"
}

##############################################################
# variables for the network profile block


variable "NetworkPolicyPlugin" {
  type                  = string
  default               = "calico"
  description           = "The network policy plugin, can be either azure or calico"
}


variable "AKSDNSSVCIPModfier" {
  type                  = string
  default               = "10"
}

variable "AKSDockerBridgeCIDR" {
  type                  = string
  default               = "172.17.0.1/16"
}

variable "AKSSVCCIDR" {
  type                  = string
  default               = "172.19.0.0/16"
}

variable "AKSLBSku" {
  type                  = string
  default               = "Standard"
  description           = "The sku for the lb, default to sandard, because it's so much better than the basic ^^, and anyway it is required for AZ usage"
}


##############################################################
# variables for the rbac block

variable "AADTenantId" {
  type                  = string
  description           = "The AAD tenant Id used for the RBAC AAD integration"

}

variable "AADServerAppSecret" {
  type                  = string
  description           = "The App server secret"

}

variable "AADServerAppId" {
  type                  = string
  description           = "The id of theapp used for AAD check"

}

variable "AADCliAppId" {
  type                  = string
  description           = "The id of the client app on which kube user authenticate"

}

##############################################################
# Tags variables

variable "EnvironmentTag" {
  type    = string
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = string
  default = "Poc usage only"
}

variable "OwnerTag" {
  type    = string
  default = "That would be me"
}

variable "ProvisioningDateTag" {
  type    = string
  default = "Today :)"
}


#Last stuff available on AKS










