##############################################################
#This module allows the creation of a Local VPN Gateway Object
##############################################################

#Variable declaration for Module

#Local Gateway Name

variable "LGWName" {
    type    = "string"  
}

#Local Gateway Object Location (in Azure, not on the On Premise site)

variable "LGWLocation" {
  type    = "string"  
}

#Local Gateway Object Resource Group

variable "LGWRG" {

    type    = "string"
}

#Local Gateway Public IP Address

variable "LGWAdress" {
    type    = "string"  
}

#Local Gateway On Premise Address space

variable "LGWAddressspace" {
    type    = "list"
}


# Variables to define the Tag


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