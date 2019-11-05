# Storage container module

## This module deploys a storage container


As for all Azure resources, a resource group is required to host the storage account which contains the Azure File
If it does not exist, it is possible to use another module to create the resource group, or it is possible to reference the Resource Group as a data source.
Note that the namespace of the storage accounts is global on all Azure region, so the name of the storage account must be unique. Injecting a random suffix in the name is one way of doing it

## Option 1. Use data source

```hcl

#Importing Resource group 

data "azurerm_resource_group" "ImportedRG" {

    name = "RG-Testmodule"

}

#Data source for storage account

data "azurerm_storage_account" "Impported_STA" {
    resource_group_name = data.azurerm_resource_group.ImportedRG.name
    name = "stadevtestadrs"
}

module "AzureFile" {
    #Module Location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//05 StorageAccountShare/"

    #Module variable            
    ShareName                   = "testshare"
    RGName                      = data.azurerm_resource_group.ImportedRG.name
    StorageAccountName          = data.azurerm_storage_account.Impported_STA.name
    Quota                       = "1000"

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

module "AzureFile" {
    #Module Location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//05 StorageAccountShare/"

    #Module variable            
    ShareName                   = "testshare"
    RGName                      = module.ResourceGroupStorage.Name
    StorageAccountName          = module.StorageAccount.Name
    Quota                       = "1000"

}

```