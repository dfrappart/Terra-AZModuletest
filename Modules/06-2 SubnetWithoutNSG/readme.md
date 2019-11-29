# Subnet without NSG Module

## This module deploys a Subnet without NSG


As for all Azure resources, a resource group is required.
If it does not exist, it is possible to use another module to create the resource group, or it is possible to reference the Resource Group as a data source.

Note: this module is usefull for subnet such as GatewaySubnet or AzureFirewallSubnet, which should not have a NSG associated.

## Option 1. Use data source

```hcl

# Importing Resource group 

data "azurerm_resource_group" "ImportedRG" {

    name = "RG-Testmodule"

}

# Importing VNet

data "azurerm_virtual_network" "VNetTest" {
    resource_group_name = data.azurerm_resource_group.ImportedRG.name
    name                = "TestVNet"
}

# Creating Subnet

module "Subnet" {
    #Module Location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-2 SubnetWithoutNSG/"

    #Module variable
    SubnetName              = "Subnet1"
    RGName                  = data.azurerm_resource_group.ImportedRG.name
    VNetName                = data.azurerm_virtual_network.VNetTest.name
    Subnetaddressprefix     = "192.168.201.0/25"
    SVCEP                   = ["Microsoft.AzureCosmosDB", "Microsoft.KeyVault"]


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

# Calling the VNet module

module "VNet" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//02 VNet/"

    #Module variable
    VNetName                = "TestModule_VNet"
    RGName                  = module.ResourceGroup.Name
    VNetLocation            = module.ResourceGroup.Location
    VNetAddressSpace        = ["10.0.0.0/20"]
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"


}


# Calling the Subnet module


module "Subnet" {

    #Module Location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-2 SubnetWithoutNSG/"

    #Module variable
    SubnetName              = "Subnet1"
    RGName                  = module.ResourceGroup.Name
    VNetName                = module.VNet.Name
    Subnetaddressprefix     = "192.168.201.0/25"
    SVCEP                   = ["Microsoft.AzureCosmosDB", "Microsoft.KeyVault"]


}

```