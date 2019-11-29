# Route Table Module

## This module deploys a route table


As for all Azure resources, a resource group is required.
If it does not exist, it is possible to use another module to create the resource group, or it is possible to reference the Resource Group as a data source.



## Option 1. Use data source

```hcl

# Importing Resource group 

data "azurerm_resource_group" "ImportedRG" {

    name = "RG-Testmodule"

}

# Calling the Route table module

module "RouteTable" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//17 RouteTable/"

    RouteTableName              = "RouteTable1"
    RGName                      = data.azurerm_resource_group.ImportedRG.name
    RTLocation                  = data.azurerm_resource_group.ImportedRG.location
    BGPDisabled                 = var.BGPDisabled
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

module "RouteTable" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//17 RouteTable/"

    RouteTableName              = "RouteTable1"
    RGName                      = module.ResourceGroup.Name
    RTLocation                  = module.ResourceGroup.Location
    BGPDisabled                 = var.BGPDisabled
    EnvironmentTag              = var.EnvironmentTag
    EnvironmentUsageTag         = var.EnvironmentUsageTag
    OwnerTag                    = var.OwnerTag
    ProvisioningDateTag         = var.ProvisioningDateTag


}

```