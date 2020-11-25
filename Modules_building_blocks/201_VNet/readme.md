# Azure Virtual Network Module

## Module description

This module deploys an Azure Virtual Network

## How to call the module

An existing RG is required, so use of data source is recommanded.
Use as follow:

```hcl

#Importing Resource group

data "azurerm_resource_group" "ImportedRG" {

    name = "RG-Testmodule"

}


# Creating VNet

module "VNet" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//201_VNet/"

    #Module variable
    VNetName                           = "TestModule_VNet"
    RGName                             = data.azurerm_resource_group.ImportedRG.name
    VNetLocation                       = data.azurerm_resource_group.ImportedRG.location
    VNetAddressSpace                   = ["10.0.0.0/20"]
    ResourceOwnerTag                   = "DFR"
    CountryTag                         = "fr"
    CostCenterTag                      = "labtf"
    EnvironmentTag                     = "dev"


}

```
