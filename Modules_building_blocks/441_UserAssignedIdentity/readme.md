# Azure User Assigned Identity

## Module description

This module deploys a User Assigned Identity.


### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| UAISuffix | string | "1" | A suffix added to the UAI name |
| TargetLocation | string | west europe | The Azure region for the resource |
| TargetRG | string | N/A | The resource group in which the resources will be deployed |
| ResourceOwnerTag | string | That would be me | Tag describing the owner |
| CountryTag | string | fr | Tag describing the Country |
| CostCenterTag | string | tflab | Tag describing the Cost Center |
| Company | string | dfitc | The Company owner of the resources |
| Project | string | tfmodule | The name of the project |
| Environment | string | dev | The environment, dev, prod... |  
  


### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|
| FullUAIOutput | `azurerm_user_assigned_identity.terraUAI` |send all the resource information available in the output. In future version, this may be the only output and detailed information will probably be queried specifically from the root module |
| Id | `azurerm_user_assigned_identity.terraUAI.id` | The resource id of the UAI |
| Name | `azurerm_user_assigned_identity.terraUAI.name` | The name of the UAI |
| Location | `azurerm_user_assigned_identity.terraUAI.location` | The region in which the resource are deployed |
| RG | `azurerm_user_assigned_identity.terraUAI.resource_group_name` | The region in which the resource are deployed |
| PrincipalId | `azurerm_user_assigned_identity.terraUAI.principal_id` | The principal Id of the UAI |
| ClientId | `azurerm_user_assigned_identity.terraUAI.client_id` | The client id of the UAI |

  
  

## How to call the module
 

Use as follow:

```bash

# Creating the ResourceGroup

module "ResourceGroup" {

  #Module Location
  source                             = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//003_ResourceGroup/"
  #Module variable
  RGSuffix                           = "-lab-1"
  RGLocation                         = "westeurope"
  ResourceOwnerTag                   = "david@teknews.cloud"
  CountryTag                         = "fr"
  CostCenterTag                      = "labtf"
  EnvironmentTag                     = "dev"

}

module "UAI1" {

  #Module Location
  source                             = "../../Modules_building_blocks/441_UserAssignedIdentity/"

  #Module variable
  UAISuffix                          = "lab1"
  TargetLocation                     = module.ResourceGroup.RGLocation
  TargetRG                           = module.ResourceGroup.RGName
  ResourceOwnerTag                   = "david@teknews.cloud"
  CountryTag                         = "fr"
  CostCenterTag                      = "labtf"
  Company                            = "dfitc"
  Project                            = "aks"
  Environment                        = "dev"


}

```

## Sample display

terraform plan should gives the following output:

```powershell

PS C:\Users\user1\Documents\IaC\Azure\Terra-AZModuletest\Tests\RG> terraform plan

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
          + "ResourceOwner" = "david@teknews.cloud"
        }
    }

  # module.UAI1.azurerm_user_assigned_identity.terraUAI will be created
  + resource "azurerm_user_assigned_identity" "terraUAI" {
      + client_id           = (known after apply)
      + id                  = (known after apply)
      + location            = "westeurope"
      + name                = "uailab1"
      + principal_id        = (known after apply)
      + resource_group_name = "rsg-lab-1"
      + tags                = {
          + "CostCenter"    = "labtf"
          + "Country"       = "fr"
          + "Environment"   = "dev"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "aks"
          + "ResourceOwner" = "david@teknews.cloud"
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + RGId             = (sensitive value)
  + RGLocation       = "westeurope"
  + RGName           = "rsg-lab-1"
  + UAI1_ClientId    = (sensitive value)
  + UAI1_FullOutput  = (sensitive value)
  + UAI1_Id          = (sensitive value)
  + UAI1_Location    = "westeurope"
  + UAI1_Name        = "uailab1"
  + UAI1_PrincipalId = (sensitive value)

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.


```

Output should be similar to this:

```powershell

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

RGId = <sensitive>
RGLocation = "westeurope"
RGName = "rsg-lab-1"
UAI1_ClientId = <sensitive>
UAI1_FullOutput = <sensitive>
UAI1_Id = <sensitive>
UAI1_Location = "westeurope"
UAI1_Name = "uailab1"
UAI1_PrincipalId = <sensitive>
UAI1_RG = "rsg-lab-1"

```

## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/UAI001.png)


