##############################################################
#This module allows the creation of an action group
##############################################################

#Variable declaration for Module


#The Container Registry Name
variable "ACRName" {
  type          = string
  description   = "The Container Registry Name"


}

#The RG containing the ACR
variable "ACRRG" {
  type          = string
  description   = "The RG containing the ACR"

}

#The ACR Location
variable "ACRLocation" {
  type    = string
  description = "The ACR Location"

}

#This variable determines if the admin account is enabled on the ACR or not, ture of false
variable "IsAdminEnabled" {
  type          = string
  description   = "This variable determines if the admin account is enabled on the ACR or not, ture of false"

}
/*
#This variable refers to the storage account underlying the ACR
variable "ACRSTOAID" {
  type          = string
  description   = "This variable refers to the storage account underlying the AC"

}
*/
#This variable determines the Sku of the ACR. Allowed values are basic, standard & premium
variable "ACRSku" {
  type          = string
  default       = "Standard"
  description   = "This variable determines the Sku of the ACR. Allowed values are basic, standard & premium"
    
  

}

#The list of Region for replication of the ACR
variable "ACRReplList" {
  type          = "list"
  default       = null
  description   = "The list of Region for replication of the ACR"

}

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