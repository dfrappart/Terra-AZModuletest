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

#Importing Route table

data "azurerm_route_table" "RTTest" {
    resource_group_name = data.azurerm_resource_group.ImportedRG.name
    name                = "RTTest"
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

# Calling the Route module

module "Route" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//16 Route/"

    RouteName                   = "Route1"
    RGName                      = module.ResourceGroup.Name
    RTName                      = module.RouteTable.Name
    DestinationCIDR             = var.BGPDisabled
    NextHop                     = var.NextHop
    NextHopinIPAddress          = var.NextHopinIPAddress
    EnvironmentTag              = var.EnvironmentTag
    EnvironmentUsageTag         = var.EnvironmentUsageTag
    OwnerTag                    = var.OwnerTag
    ProvisioningDateTag         = var.ProvisioningDateTag


}

```