##############################################################
#This module allows the creation of a Netsork Security Group
##############################################################

#Variable declaration for Module

variable "PrivateDNSDomainName" {
  type                = string
  description         = "The name of the Private DNS Zone. Must be a valid domain name."

}

variable "RGName" {
  type                = string
  description         = "Specifies the resource group where the resource exists. Changing this forces a new resource to be created."

}

variable "SOARecordEmail" {
  type                = string
  description         = "The email contact for the SOA record."
  

}

variable "SOARecordExpireTime" {
  type                = string
  description         = "The expire time for the SOA record. Defaults to 2419200."
  default             = null

}

variable "SOARecordMinTTL" {
  type                = string
  description         = "The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. Defaults to 10."
  default             = null

}

variable "SOARecordRefreshTime" {
  type                = string
  description         = "The refresh time for the SOA record. Defaults to 3600."
  default             = null

}

variable "SOARecordRetryTime" {
  type                = string
  description         = "The retry time for the SOA record. Defaults to 300."
  default             = null

}

variable "SOARecordTTL" {
  type                = string
  description         = "The Time To Live of the SOA Record in seconds. Defaults to 3600."
  default             = null

}
###################################################################
#Tag related variables section

variable "ResourceOwnerTag" {
  type               = string
  description        = "Tag describing the owner"
  default            = "That would be me"
}

variable "CountryTag" {
  type                = string
  description         = "Tag describing the Country"
  default             = "fr"
}

variable "CostCenterTag" {
  type                = string
  description         = "Tag describing the Cost Center"
  default             = "labtf"
}

variable "EnvironmentTag" {
  type                = string
  description         = "The environment, dev, prod..."
  default             = "lab"
}

variable "Project" {
  type                = string
  description         = "The name of the project"
  default             = "tfmodule"
}

variable "extra_tags" {
  type        = map
  description = "Additional optional tags."
  default     = {}
}