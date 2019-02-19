##############################################################
#This module allows the creation of a vNEt
##############################################################

#Variable declaration for Module

variable "AKSClusName" {
  type = "string"
}

variable "AKSLocation" {
  type = "string"
}

variable "AKSRGName" {
  type = "string"
}

variable "AKSAgentPoolName" {
  type = "string"
}

variable "AKSNodeCount" {
  type = "string"
}


variable "AKSNodeInstanceType" {
  type = "string"
}

variable "AKSNodeOSType" {
  type = "string"
}

variable "AKSNodeOSDiskSize" {
  type = "string"
}

variable "AKSSubnetId" {
  type = "string"
}

variable "AKSMaxPods" {
  type = "string"
}

variable "AKSprefix" {
  type = "string"
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
}

variable "AKSAdminName" {
  type = "string"
}

variable "PublicSSHKey" {
  type = "string"
}

variable "AKSDNSSVCIP" {
  type = "string"
}

variable "AKSDockerBridgeCIDR" {
  type = "string"
}

variable "AKSSVCCIDR" {
  type = "string"
}

variable "IshttproutingEnabled" {
  type = "string"
}

variable "IshttproutingEnabled" {
  type = "string"
}

variable "AKSLAWId" {
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