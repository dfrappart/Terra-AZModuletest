# Azure Virtual Network Module

## Module description

This module deploys an Azure Virtual Network

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|


### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|
## How to call the module

An existing RG is required, so use of data source is recommanded.
Use as follow:

```bash

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


## Sample display

terraform plan should gives the following output:

```powershell

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.VNet.azurerm_virtual_network.Terra_VNet will be created
  + resource "azurerm_virtual_network" "Terra_VNet" {
      + address_space         = [
          + "10.0.0.0/20",
        ]
      + guid                  = (known after apply)
      + id                    = (known after apply)
      + location              = "westeurope"
      + name                  = "TestModule_VNet"
      + resource_group_name   = "rsgvaultlab"
      + subnet                = (known after apply)
      + tags                  = {
          + "CostCenter"    = "labtf"
          + "Country"       = "fr"
          + "Environment"   = "dev"
          + "ManagedBy"     = "Terraform"
          + "ResourceOwner" = "DFR"
        }
      + vm_protection_enabled = false
    }

Plan: 1 to add, 0 to change, 0 to destroy.

```


## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/vnet001.png)