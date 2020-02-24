######################################################
# Module dtbs Variables
######################################################


######################################################
#Resource Group variables

variable "RGName" {
    type                = string
    description         = "The Resource Group containing all the resources for this module"
    default             = "RGDTBSFromTerra"
}

variable "RGLocation" {
    type                = string
    description         = "The Azure location of the RG"
    default             = "westeurope"
}

######################################################
#VNet variables

variable "VNetName" {
    type                = string
    description         = "VNet name"
    default             = "VNetDTBSFromTerra"


}

variable "VNetAddressSpace" {
    type                = list
    description         = "VNet IP Range"
    default             = [
                            "192.168.102.0/23"
                            ]


}

######################################################
#Subnets variables

variable "SubnetName" {
    type                = list
    description         = "List of subnet names"
    default             = [
                            "DtbsPubSubnet",
                            "DtbsPrivSubnet",
                            "AzureBastionSubnet"

                            ]       

}

variable "Subnetaddressprefix" {
    type                = list
    description         = "List of subnet range"
    default             = [
                            "192.168.102.0/26",
                            "192.168.102.64/26",
                            "192.168.102.128/26"

                            ]       

}

variable "SVCEP" {
    type                = list
    description         = "The list of service endpoint for the subnets"
    default             = null
}

######################################################
#NSG variables

variable "NSGName" {
    type                = list
    description         = "List of NSG Name"
    default             = [
                            "DtbsPubSubnet",
                            "DtbsPrivSubnet",

                            ]       

}

######################################################
#Databricks workspace variables

variable "DTBWSName" {
    type                = string
    description         = "Name of the Databricks workspace"
    default             = "dtbstest"

}

variable "DTBWSSku" {
    type                = string
    description         = "sku of the Databricks workspace"
    default             = "standard"

}

variable "DTBWSPIP" {
  type                  = string
  description           = "Define the dtbws param no_public_ip, default to false to have public ip"
  default               = false
}
######################################################
#Tag related variables and naming convention section

variable "EnvironmentTag" {
  type                  = string
  default               = "Poc"
}

variable "EnvironmentUsageTag" {
  type                  = string
  default               = "Poc usage only"
}

variable "OwnerTag" {
  type                  = string
  default               = "That would be me"
}

variable "ProvisioningDateTag" {
  type                  = string
  default               = "Today :)"
}