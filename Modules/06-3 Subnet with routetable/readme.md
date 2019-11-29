# VNet Module

## This module deploys a Subnet


As for all Azure resources, a resource group is required.
If it does not exist, it is possible to use another module to create the resource group, or it is possible to reference the Resource Group as a data source.

**Note**: The nsg id parameter in the Subnet resource is deprecated in favor of the deicated resource **azurerm_subnet_network_security_group_association**.
So using it will generate a warning about the deprecated status.
However, curently, having only the NSG association will result in a Subnet not associated with its nsg.
Thus in the module, we have both the subnet and the azurerm_network_security_group_association.

**Note**: The routetable id parameter in the Subnet resource is deprecated in favor of the deicated resource **azurerm_subnet_route_table_association**.
So using it will generate a warning about the deprecated status.
However, curently, having only the Route table association will result in a Subnet not associated with its route table.
Thus in the module, we have both the subnet and the azurerm_subnet_route_table_association.

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

#Importing NSG

data "azurerm_network_security_group" "NSGTest" {
    resource_group_name = data.azurerm_resource_group.ImportedRG.name
    name                = "TestNSG"
}

#Importing Route table

data "azurerm_route_table" "RTTest" {
    resource_group_name = data.azurerm_resource_group.ImportedRG.name
    name                = "RTTest"
}

# Creating Subnet

module "Subnet" {
  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-3 Subnet with routetable/"

  #Module variable
    SubnetName              = "Subnet1"
    RGName                  = data.azurerm_resource_group.ImportedRG.name
    VNetName                = data.azurerm_virtual_network.VNetTest.name
    Subnetaddressprefix     = "192.168.201.0/25"
    NSGid                   = data.azurerm_network_security_group.NSGTest.id
    RouteTableId            = data.azurerm_route_table.RTTest.id
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

# Calling the NSG module

module "NSG" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//07 NSG/"

    #Module variable
    NSGName                 = "TestModule_VNet"
    RGName                  = module.ResourceGroup.Name
    NSGLocation             = module.VNet.Location
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"


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


# Calling the Subnet module


module "Subnet" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-3 Subnet with routetable/"

    SubnetName              = "Subnet1"
    RGName                  = module.ResourceGroup.Name
    VNetName                = module.VNet.Name
    Subnetaddressprefix     = "192.168.201.0/25"
    NSGid                   = module.NSG.Id
    RouteTableId            = module.RouteTable.Id
    SVCEP                   = ["Microsoft.AzureCosmosDB", "Microsoft.KeyVault"]


}

```