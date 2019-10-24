# Resource Group Module

## This Module deploys a Resource Group

Use as follow : 

```hcl

# Creating the ResourceGroup


module "ResourceGroup" {

    #Module Location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//01 ResourceGroup/"
    #Module variable
    RGName                  = "RG-Testmodule"
    RGLocation              = "Westeurope"
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"
}

```

Note that by default, all variables have default values: 

```hcl


#Variable declaration for Module



variable "RGName" {
  type    = string
  default = "DefaultRG"
}


variable "RGLocation" {
  type    = string
  default = "Westeurope"
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

```

