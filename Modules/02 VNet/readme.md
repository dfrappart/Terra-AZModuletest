# VNet Module

## This module deploys a VNet


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
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//02 VNet/"

    #Module variable
    VNetName                = "TestModule_VNet"
    RGName                  = "${data.azurerm_resource_group.ImportedRG.name}"
    VNetLocation            = "${data.azurerm_resource_group.ImportedRG.location}"
    VNetAddressSpace        = ["10.0.0.0/20"]
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"


}

```
