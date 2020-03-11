######################################################
# Module VMSS Variables
######################################################


######################################################
#Resource Group variables

variable "RGName" {
    type                = string
    description         = "The Resource Group containing all the resources for this module"
    default             = "vmsstest"
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
    default             = "vmsstest"


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
  default               = "vmsstest"
  description           = "Public IP Name"
}


######################################################
#Azure Load Balancer variables

#LB Resource

variable "ExtLBName" {
  type                  = string
  description           = "Load balancer name"
  default               = "vmsstest"
}


variable "FEConfigName" {
  type                  = string
  description           = "Load balancer name"
  default               = "vmsstest"
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
  default               = "vmsstest"
}

variable "VMSSSku" {
  type                  = string
  description           = "VMSS SKU"
  default               = "Standard_B2ms"
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
  default               = "vmsstest"
}

variable "VMSSNICNameConfig" {
  type                  = string
  description           = "VMSS IP Config Name"
  default               = "vmsstest"
}

variable "VMSSUpgradeMode" {
  type                  = string
  description           = "The upgrade mode of the VMSS, possible value are Manual, Rolling and Automatic"
  default               = "Rolling"
}

variable "VMSSZonesList" {
  type                  = list
  description           = "The list of AZ in wich the VMSS is deployed"
  default               = [1,2,3]
}

variable "IsZoneBalanced" {
  type                  = string
  description           = "If the VMSS is balanced across the AZ"
  default               = true
}

######################################################
# Autoscale variable

variable "VMSSPRofileName" {
  type                  = string
  description           = "VMSS Autoscale profile name"
  default               = "vmssautoscaleprofile"
}


variable "VMSSInstanceNumber" {
  type                  = string
  description           = "VMSS Instance number"
  default               = 6
}

variable "VMSSInstanceMin" {
  type                  = string
  description           = "VMSS Minimal Instance number"
  default               = 3
}

variable "VMSSInstanceMax" {
  type                  = string
  description           = "VMSS Maximal Instance number"
  default               = 9
}

# Autoscale variable - scale out rule

variable "ScaleUpRuleMetricName" {
  type                  = string
  description           = "the metric name for the scale out rule"
  default               = "Percentage CPU"
}

variable "ScaleUpRuleTimeGrain" {
  type                  = string
  description           = "the metric name for the scale out rule"
  default               = "PT1M"
}

variable "ScaleUpRuleStatistic" {
  type                  = string
  description           = "the statistic name for the rule scale out rule"
  default               = "Average"
}

variable "ScaleUpRuleTimeWindow" {
  type                  = string
  description           = "the time window for the rule scale out rule"
  default               = "PT5M"
}

variable "ScaleUpRuleTimeAggreg" {
  type                  = string
  description           = "the time aggregation for the rule scale out rule"
  default               = "Average"
}

variable "ScaleUpRuleOperator" {
  type                  = string
  description           = "the operator for the rule scale out rule"
  default               = "GreaterThan"
}

variable "ScaleUpRuleThreshold" {
  type                  = string
  description           = "the theshold for the rule scale out rule"
  default               = 90
}

variable "ScaleUpActionType" {
  type                  = string
  description           = "the theshold for the rule scale out rule"
  default               = "ChangeCount"
}

variable "ScaleUpActionValue" {
  type                  = string
  description           = "the theshold for the rule scale out rule"
  default               = 3
}

variable "ScaleUpActionCooldown" {
  type                  = string
  description           = "the theshold for the rule scale out rule"
  default               = "PT1M"
}

# Autoscale variable - scale out rule

variable "ScaleDownRuleMetricName" {
  type                  = string
  description           = "the metric name for the scale out rule"
  default               = "Percentage CPU"
}

variable "ScaleDownRuleTimeGrain" {
  type                  = string
  description           = "the metric name for the scale out rule"
  default               = "PT1M"
}

variable "ScaleDownRuleStatistic" {
  type                  = string
  description           = "the statistic name for the rule scale out rule"
  default               = "Average"
}

variable "ScaleDownRuleTimeWindow" {
  type                  = string
  description           = "the time window for the rule scale out rule"
  default               = "PT5M"
}

variable "ScaleDownRuleTimeAggreg" {
  type                  = string
  description           = "the time aggregation for the rule scale out rule"
  default               = "Average"
}

variable "ScaleDownRuleOperator" {
  type                  = string
  description           = "the operator for the rule scale out rule"
  default               = "LessThan"
}

variable "ScaleDownRuleThreshold" {
  type                  = string
  description           = "the theshold for the rule scale out rule"
  default               = 25
}

variable "ScaleDownActionType" {
  type                  = string
  description           = "the theshold for the rule scale out rule"
  default               = "ChangeCount"
}

variable "ScaleDownActionValue" {
  type                  = string
  description           = "the theshold for the rule scale out rule"
  default               = 3
}

variable "ScaleDownActionCooldown" {
  type                  = string
  description           = "the theshold for the rule scale out rule"
  default               = "PT1M"
}

######################################################
#Tag related variables and naming convention section

variable "EnvironmentTag" {
  type                  = string
  default               = "vmsstest"
}

variable "EnvironmentUsageTag" {
  type                  = string
  default               = "test"
}

variable "OwnerTag" {
  type                  = string
  default               = "That would be me"
}

variable "ProvisioningDateTag" {
  type                  = string
  default               = "Today :)"
}
