# NSG Module

## This module deploys a Network Security Group

As for all Azure resources, a resource group is required.
If it does not exist, it is possible to use another module to create the resource group, or it is possible to reference the Resource Group as a data source.



## Option 1. Use data source

```hcl

# Importing Resource group 

data "azurerm_resource_group" "ImportedRG" {

    name = "RG-Testmodule"

}

# Calling the NSG module

module "NSGTest" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//07 NSG/"

    NSGName                     = "NSGTest"
    RGName                      = data.azurerm_resource_groupe.ImportedRG.name
    NSGLocation                 = data.azurerm_resource_groupe.ImportedRG.location
    EnvironmentTag              = var.EnvironmentTag
    EnvironmentUsageTag         = var.EnvironmentUsageTag
    OwnerTag                    = var.OwnerTag
    ProvisioningDateTag         = var.ProvisioningDateTag


}

```




## Option 2. create everything from module

```hcl


# Calling the resource group module

module "ResourceGroup" {
  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//01 ResourceGroup/"

  #Module variable
  RGName              = "RGTest"
  RGLocation          = "westeurope"
  EnvironmentTag      = var.EnvironmentTag
  EnvironmentUsageTag = var.EnvironmentUsageTag
  OwnerTag            = var.OwnerTag
  ProvisioningDateTag = var.ProvisioningDateTag

}

# Calling the Route table module

module "NSGTest" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//07 NSG/"

    NSGName                     = "NSGTest"
    RGName                      = module.ResourceGroup.Name
    NSGLocation                 = module.ResourceGroup.Location
    EnvironmentTag              = var.EnvironmentTag
    EnvironmentUsageTag         = var.EnvironmentUsageTag
    OwnerTag                    = var.OwnerTag
    ProvisioningDateTag         = var.ProvisioningDateTag


}

module "RouteTable" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//07 NSG/"

    RouteTableName              = "NSGTest"
    RGName                      = module.ResourceGroup.Name
    RTLocation                  = module.ResourceGroup.Location
    BGPDisabled                 = var.BGPDisabled
    EnvironmentTag              = var.EnvironmentTag
    EnvironmentUsageTag         = var.EnvironmentUsageTag
    OwnerTag                    = var.OwnerTag
    ProvisioningDateTag         = var.ProvisioningDateTag


}

```