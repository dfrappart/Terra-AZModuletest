# NSG rule Module

## This module deploys a Network Security Group Rule

As for all Azure resources, a resource group is required.
An NSG rule is a subobject included in an NSG, so it is also required to have an existing NSG to deploy an NSG rule
If it does not exist, it is possible to use another module to create the resource group, or it is possible to reference the Resource Group as a data source.



## Option 1. Use data source

```hcl

# Importing Resource group 

data "azurerm_resource_group" "ImportedRG" {

    name = "RG-Testmodule"

}

# Importing NSG 

data "azurerm_network_security_group" "ImportedNSG" {

    name                = "NSG"
    resource_group_name = data.azurerm_resource_group.ImportedRG.nale



}

module "NSGRule" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//08-1 NSGRule/"

    NSGRuleName                                 = var.NSGRuleName
    NSGRulePriority                             = var.NSGRulePriority
    NSGRuleDirection                            = var.NSGRuleDirection
    NSGRuleAccess                               = var.NSGRuleAccess
    NSGRuleProtocol                             = var.NSGRuleProtocol
    NSGRuleSourcePortRange                      = var.NSGRuleSourcePortRange
    NSGRuleDestinationAddressPrefixes           = var.NSGRuleDestinationAddressPrefixes
    NSGRuleSourceAddressPrefixes                = var.NSGRuleSourceAddressPrefixes
    NSGRuleDestinationASG                       = var.NSGRuleDestinationASG
    RGName                                      = module.ResourceGroup.Name
    NSGReference                                = data.azurerm_network_security_group.ImportedNSG.name


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

# Calling the NSG module

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

module "NSGRule" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//08-1 NSGRule/"

    NSGRuleName                                 = var.NSGRuleName
    NSGRulePriority                             = var.NSGRulePriority
    NSGRuleDirection                            = var.NSGRuleDirection
    NSGRuleAccess                               = var.NSGRuleAccess
    NSGRuleProtocol                             = var.NSGRuleProtocol
    NSGRuleSourcePortRange                      = var.NSGRuleSourcePortRange
    NSGRuleSourceAddressPrefixes                = var.NSGRuleSourceAddressPrefixes
    NSGRuleDestinationAddressPrefixes           = var.NSGRuleDestinationAddressPrefixes
    RGName                                      = module.ResourceGroup.Name
    NSGReference                                = module.NSGTest.Name


}

```