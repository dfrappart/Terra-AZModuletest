
# ACR module

This module allows the deployment of a container. Only Basic, Standard and Premium Sku with this module, so no Storage Account required.


Use is as follow:


## RG for the Azure Container Registry


## Creating the ResourceGroup

```hcl
module "ResourceGroupACR" {
  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//01 ResourceGroup/"

  #Module variable
  RGName              = var.RGName
  RGLocation          = var.AzureRegion
  EnvironmentTag      = var.EnvironmentTag
  EnvironmentUsageTag = var.EnvironmentUsageTag
  OwnerTag            = var.OwnerTag
  ProvisioningDateTag = var.ProvisioningDateTag

}

```
## Creating the ACR

The ACR is accessed via an fqdn, thus it needs to have a unique name on all Azure namespace. To attain this objective, it is possible to use a random string.

define the variable file as follow: 

```hcl


variable "RGName" {
    type = string
}

variable "AzureRegion" {
    type = string
}

variable "EnvironmentTag" {
    type = string
}

variable "EnvironmentUsageTag" {
    type = string
}

variable "OwnerTag" {
    type = string
}

variable "ProvisioningDateTag" {
    type = string
}

variable "ACRAdminAccountEnabled" {
    type = string
    default = false
}

variable "ACRSku" {
    type = string

}

variable "ACRReplicationList" {
    type = list
    default = ["westeurope","francecentral"]

}

```

And the terraform.tfvars as follow: 

```hcl



RGName = "ACRTest"
AzureRegion = "westeurope"
EnvironmentTag = "DEV"
EnvironmentUsageTag = "ACRTest"
OwnerTag ="DFR"
ProvisioningDateTag = "20191104"
ACRSku = "standard"


```

Then define the main.tf file as follow: 

```hcl

module "ACRRandomPrefix" {
    #Module source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//00 RandomString/"

    #Module variables
    stringlenght        = "4"
    stringspecial       = "false"
    stringupper         = "false"
    
}

module "ACR" {
    #Module source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//49 Azure Container Registry/"

    #Module variables
    ACRName                     = module.ACRRandomPrefix.Result}${var.EnvironmentTag}acr"
    ACRRG                       = module.ResourceGroupACR.Name
    ACRLocation                 = var.AzureRegion    
    IsAdminEnabled              = var.ACRAdminAccountEnabled
    ACRSku                      = var.ACRSku
    #ACRReplList                 = var.ACRReplicationList
    EnvironmentTag              = var.EnvironmentTag
    EnvironmentUsageTag         = var.EnvironmentUsageTag
    OwnerTag                    = var.OwnerTag
    ProvisioningDateTag         = var.ProvisioningDateTag


}

```

Uncomment the ACRRepllist only if sku chosen is premium, which is the only supporting replication.
In this case, change the terraform.tfvars as follow : 

```hcl

RGName = "ACRTest"
AzureRegion = "westeurope"
EnvironmentTag = "DEV"
EnvironmentUsageTag = "ACRTest"
OwnerTag ="DFR"
ProvisioningDateTag = "20191104"
ACRSku = "premium"
ACRReplicationList = ["northeurope","francecentral"]


```
