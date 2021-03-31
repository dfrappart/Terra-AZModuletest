# Resource Group Module

## Module description

This module deploys a resource group

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| RGSuffix | string | N/A | a suffix to add at the end of the resource group name |
| RGLocation | string | N/A | The regionin which the resource group is located. Changing this forces a new resource to be created. |
| ResourceOwnerTag | string | That would be me | Tag describing the owner |
| CountryTag | string | fr | Tag describing the Country |
| CostCenterTag | string | tflab | Tag describing the Cost Center |
| Project | string | tfmodule | The name of the project |
| Environment | string | dev | The environment, dev, prod... |  


### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|
| RGFull | `azurerm_resource_group.RG` | send all the resource information available in the output. In future version, this may be the only output and detailed informtion will probably be queried specifically from the root module |
| RGName | `azurerm_resource_group.RG.name` | The resource name |
| RGLocation | `azurerm_resource_group.RG.id` | The resource location |
| RGId | `azurerm_resource_group.RG.primary_blob_endpoint` | The resource id |

## How to call the module

Use as follow:

```bash

# Creating the ResourceGroup

module "ResourceGroup" {

    #Module Location
    source                            = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//01 ResourceGroup/"
    #Module variable
    RGSuffix                          = "-lab-1"
    RGLocation                        = "westeurope"
    ResourceOwnerTag                  = "DFR"
    CountryTag                        = "fr"
    CostCenterTag                     = "labtf"
    EnvironmentTag                     = "dev"

}

```

### Sample display

terraform plan should gives the following output:

```powershell

PS C:\Users\user1\Documents\IaC\Azure\Terra-AZModuletest\Tests\RG> terraform plan
Acquiring state lock. This may take a few moments...
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.ResourceGroup.azurerm_resource_group.TerraRG will be created
  + resource "azurerm_resource_group" "TerraRG" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "rsg-lab-1"
      + tags     = {
          + "CostCenter"    = "labtf"
          + "Country"       = "fr"
          + "Environment"   = "dev"
          + "ManagedBy"     = "Terraform"
          + "ResourceOwner" = "DFR"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

output should be similar to this:

```powershell

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

RGId = <sensitive>
RGLocation = westeurope
RGName = rsg-lab-1

```

## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/RG001.png)