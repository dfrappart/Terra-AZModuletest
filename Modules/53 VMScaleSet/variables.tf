######################################################
#Resource Group variables

variable "RGName" {
    type                = string
    description         = "The Resource Group containing all the resources for this module"
}

variable "RGLocation" {
    type                = string
    description         = "The Azure location of the RG"
}

######################################################
#VNet variables

variable "VNetName" {
    type                = string
    description         = "VNet name"


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
                            "PubSubnet",
                            "PrivSubnet",
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
                            "PubSubnet",
                            "PrivSubnet",

                            ]       

}

######################################################
#The Public IP Namevariables

variable "PublicIPName" {
  type                  = string
  default               = "meetup2020"
  description           = "Public IP Name"
}


######################################################
#Azure Load Balancer variables

#LB Resource

variable "ExtLBName" {
  type                  = string
  description           = "Load balancer name"
  default               = "meetup2020"
}


variable "FEConfigName" {
  type                  = string
  description           = "Load balancer name"
  default               = "meetup2020"
}

variable "LBSku" {
  type                  = string
  description           = "Load balancer sku, basic or standard, default to standard"
  default               = "standard"
}

# LB Probe

variable "LBProbePort" {
  type                  = string
  description           = "Load balancer Probe port"
  default               = 80
}

variable "LBProbeName" {
  type                  = string
  description           = "Load balancer Probe Name"
  default               = "MeetupLBProbe"
}

#LB BE Pool

variable "LBBackEndPoolName" {
  type                  = string
  description           = "Load balancer BE Pool Name"
  default               = "MeetupLBBEPool"
}

#LB FE Rule Name

variable "FERuleName" {
  type                  = string
  description           = "Load balancer FE Rule"
  default               = "MeetupLBFERule"
}


variable "FERuleProtocol" {
  type                  = string
  description           = "Load balancer FE Protocol"
  default               = "tcp"
}


variable "FERuleFEPort" {
  type                  = string
  description           = "Load balancer FE Rule FE Port"
  default               = 80
}

variable "FERuleBEPort" {
  type                  = string
  description           = "Load balancer FE Rule BE Port"
  default               = 80
}


#####################################################
# VMSS Variables

variable "CloudinitscriptPath" {
  type                  = string
  description           = "bootstrap script name"
  default               = "/Scripts/bootstrap.sh"
}

variable "VMSSName" {
  type                  = string
  description           = "VMSS Name"
  default               = "meetup2020"
}

variable "VMSSSku" {
  type                  = string
  description           = "VMSS SKU"
  default               = "Standard_B4ms"
}

variable "VMSSInstanceNumber" {
  type                  = string
  description           = "VMSS Insance number"
  default               = 3
}

variable "VMAdminName" {
  type                  = string
  description           = "VMSS Admin Name"
  default               = "VMAdmin"
}

variable "PublicSSHKeyPath" {
  type                  = string
  description           = "VMSS SSH Key"
  default               = "/sshkey.pub"
}

variable "VMAdminPassword" {
  type                  = string
  description           = "VMSS pwd"
  default               = "Devoteam75!#"
}

variable "VMImagePublisherName" {
  type                  = string
  description           = "M Image Publisher namee"
  default               = "Canonical"
}

variable "VMImageOfferName" {
  type                  = string
  description           = "VM Image Offere"
  default               = "UbuntuServer"
}

variable "VMImageSku" {
  type                  = string
  description           = "VM Image SKU"
  default               = "18.04-LTS"
}

variable "OSDiskTier" {
  type                  = string
  description           = "Managed DIsk Storage Tier"
  default               = "Premium_LRS"
}

variable "OSDiskCaching" {
  type                  = string
  description           = "Nic Name"
  default               = "None"
}

variable "VMSSNICName" {
  type                  = string
  description           = "Managed DIsk Caching option"
  default               = "meetup2020"
}

variable "VMSSNICNameConfig" {
  type                  = string
  description           = "VMSS IP Config Name"
  default               = "meetup2020"
}



######################################################
#Tag related variables and naming convention section

variable "EnvironmentTag" {
  type                  = string
  default               = "meetup2020"
}

variable "EnvironmentUsageTag" {
  type                  = string
  default               = "Meetup usage only"
}

variable "OwnerTag" {
  type                  = string
  default               = "That would be me"
}

variable "ProvisioningDateTag" {
  type                  = string
  default               = "Today :)"
}
