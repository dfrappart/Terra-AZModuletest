# Storage Account module


## This module allows the deployment of a storage account.

A resource group is required to deploy the storage account.
If it does not exist, it is possible to use another module to create the resource group, or it is possible to reference the Resource Group as a data source.
Note that the namespace of the storage accounts is global on all Azure region, so the name of the storage account must be unique. Injecting a random suffix in the name is one way of doing it

## Option 1. Use data source

```hcl

#Importing Resource group 

data "azurerm_resource_group" "ImportedRG" {

    name = "RG-Testmodule"

}

#Random string for storage account name

resource "random_string" "TerraRandomstring" {



    length      = 4
    special     = false
    upper       = false
    number      = false

}



module "StorageAccount" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//03 StorageAccountGP"

    #Module variable
    StorageAccountName          = "stoa${var.EnvironmentTag}${random_string.TerraRandomstring.result}"
    RGName                      = data.azurerm_resource_group.ImportedRG.name
    StorageAccountLocation      = "westeurope"
    StorageAccountTier          = "Standard"
    StorageReplicationType      = "LRS" #The Storage Account Replication Type, accept LRS, GRS, RAGRS and ZRS.
    EnvironmentTag              = var.EnvironmentTag
    EnvironmentUsageTag         = var.EnvironmentUsageTag
    OwnerTag                    = var.OwnerTag
    ProvisioningDateTag         = var.ProvisioningDateTag
}

```

## Option 2 . Create everything with module

```hcl

#Calling the resource group module

module "ResourceGroupStorage" {
  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//01 ResourceGroup/"

  #Module variable
  RGName              = "RGTest
  RGLocation          = "westeurope"
  EnvironmentTag      = var.EnvironmentTag
  EnvironmentUsageTag = var.EnvironmentUsageTag
  OwnerTag            = var.OwnerTag
  ProvisioningDateTag = var.ProvisioningDateTag

}

#Random string for storage account name

resource "random_string" "TerraRandomstring" {



    length      = 4
    special     = false
    upper       = false
    number      = false

}

module "StorageAccount" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//03 StorageAccountGP"

    #Module variable
    StorageAccountName          = "stoa${var.EnvironmentTag}${random_string.TerraRandomstring.result}"
    RGName                      = module.ResourceGroupStorage.Name
    StorageAccountLocation      = module.ResourceGroupStorage.Location
    StorageAccountTier          = "Standard
    StorageReplicationType      = ""LRS
    EnvironmentTag              = var.EnvironmentTag
    EnvironmentUsageTag         = var.EnvironmentUsageTag
    OwnerTag                    = var.OwnerTag
    ProvisioningDateTag         = var.ProvisioningDateTag
}

```