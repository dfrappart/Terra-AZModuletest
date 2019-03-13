##############################################################
#This module allows the creation of a vNEt
##############################################################

#Variable declaration for Module

variable "AKSClusName" {
  type = "string"
  default = "TerraAkSClus"
}

variable "AKSLocation" {
  type = "string"
}

variable "AKSRGName" {
  type = "string"
}

variable "AKSAgentPoolName" {
  type = "string"
  default = "TerraAKSAP"
}

variable "AKSNodeCount" {
  type = "string"
  default = "3"
}


variable "AKSNodeInstanceType" {
  type = "string"
  default = "Standard_DS2_v2"
}

variable "AKSNodeOSType" {
  type = "string"
  default = "Linux"
}

variable "AKSNodeOSDiskSize" {
  type = "string"
  default = "30"
}

variable "AKSSubnetId" {
  type = "string"
}

variable "AKSMaxPods" {
  type = "string"
  default = "100"
}

variable "AKSprefix" {
  type = "string"
  default = "terraaksdfr"
}

variable "K8SSPId" {
  type = "string"
}

variable "K8SSPSecret" {
  type = "string"
}

variable "AKSLAWId" {
  type = "string"
}

variable "KubeVersion" {
  type = "string"
  default = "1.12.5"
}

variable "AKSAdminName" {
  type = "string"
  default = "AKSAdmin"
}

variable "PublicSSHKey" {
  type = "string"
}

variable "AKSDNSSVCIP" {
  type = "string"
  default = "172.19.0.10"
}

variable "AKSDockerBridgeCIDR" {
  type = "string"
  default = "172.17.0.1/16"
}

variable "AKSSVCCIDR" {
  type = "string"
  default = "172.19.0.0/16"
}

variable "IshttproutingEnabled" {
  type = "string"
  default = "true"
}

variable "AADTenantId" {
  type = "string"

}

variable "AADServerAppSecret" {
  type = "string"

}

variable "AADServerAppId" {
  type = "string"

}

variable "AADCliAppId" {
  type = "string"

}


variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

variable "OwnerTag" {
  type    = "string"
  default = "That would be me"
}

variable "ProvisioningDateTag" {
  type    = "string"
  default = "Today :)"
}