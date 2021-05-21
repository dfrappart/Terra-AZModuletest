# Azure RBAC Builtin role assignment 

## Module description

This module assign a built in role to a principal.

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| RoleGuid | string | null | A unique UUID/GUID which identifies this role - one will be generated if not specified. Changing this forces a new resource to be created. |
| RoleName | string | N/A | The name of the Role Definition. Changing this forces a new resource to be created. |
| RoleScope | string | N/A | The scope at which the Role Definition applies too, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM. It is recommended to use the first entry of the assignable_scopes. Changing this forces a new resource to be created. |
| RoleDescription | string | "" | A description of the Role Definition. |
| RoleAssignableScopes | list | null | One or more assignable scopes for this Role Definition, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM. |
| Permission_Actions | string | null | One or more Allowed Actions, such as *, Microsoft.Resources/subscriptions/resourceGroups/read. See 'Azure Resource Manager resource provider operations' for details. |
| Permission_NotActions | string | null | One or more Disallowed  Actions, such as *, Microsoft.Resources/subscriptions/resourceGroups/read. See 'Azure Resource Manager resource provider operations' for details. |
| Permission_Data_Actions | string | null | One or more Allowed Data Actions, such as *, Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read. See 'Azure Resource Manager resource provider operations' for details. |
| Permission_Not_Data_Actions | string | null | One or more Disallowed Data Actions, such as *, Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read. See 'Azure Resource Manager resource provider operations' for details. |

### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|
| CustomRoleFull | `azurerm_role_definition.CustomRBACRole` | send all the resource information available in the output. In future version, this may be the only output and detailed informtion will probably be queried specifically from the root module |
| CustomRoleDefinitionId | `azurerm_role_definition.CustomRBACRole.role_definition_id` | This ID is specific to Terraform - and is of the format {roleDefinitionId}|{scope}. |
| CustomRoleName | `azurerm_role_definition.CustomRBACRole.name` | The role name |
| CustomRolePermissions | `azurerm_role_definition.CustomRBACRole.permisions` | The role permissions |
| CustomRolePermissionsJson | `jsonencore(azurerm_role_definition.CustomRBACRole.permisions)` | The role permissions in json format |
| CustomRoleScope | `azurerm_role_definition.CustomRBACRole.assignable_scopes` | The role scope |
| CustomRoleRoleDefinitionResourceId | `azurerm_role_definition.CustomRBACRole.role_definition_resource_id` |  The Azure Resource Manager ID for the resource. |
| CustomRoleRoleId | `azurerm_role_definition.CustomRBACRole.id` |  The Role definition Id. |  
  

## How to call the module
 

Use as follow:

```bash

# Creating an Assignment

module "CustomRole_Test" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//402_CustomRoleDefinition/"

  #Module variable
  RoleName                                = "Custom Compute role"
  RoleScope                               = "/subscriptions/{subscriptionId1}"
  Permission_Actions                      = ["Microsoft.Compute/*/"]
  Permission_NotActions                   = ["Microsoft.Compute/*/delete"]



}

```

## Sample display

terraform plan should gives the following output:

```powershell

PS C:\Users\user1\Documents\IaC\Azure\Terra-AZModuletest\Tests\RG> terraform plan
module.ResourceGroup.azurerm_resource_group.TerraRG: Refreshing state... [id=/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-lab-1]
module.UAI1.azurerm_user_assigned_identity.terraUAI: Refreshing state... [id=/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-lab-1/providers/Microsoft.ManagedIdentity/userAssignedIdentities/uailab1]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.AssignUAI_Test.azurerm_role_assignment.TerraAssignedBuiltin will be created
  + resource "azurerm_role_assignment" "TerraAssignedBuiltin" {
      + id                               = (known after apply)
      + name                             = (known after apply)
      + principal_id                     = (sensitive)
      + principal_type                   = (known after apply)
      + role_definition_id               = (known after apply)
      + role_definition_name             = "Virtual Machine Contributor"
      + scope                            = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-lab-1"
      + skip_service_principal_aad_check = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + Test_RBACAssignmentFull          = (sensitive value)
  + Test_RBACAssignmentGuid          = (known after apply)
  + Test_RBACAssignmentId            = (known after apply)
  + Test_RBACAssignmentPrincipalId   = (sensitive value)
  + Test_RBACAssignmentPrincipalType = (known after apply)
  + Test_RBACAssignmentRoleName      = "Virtual Machine Contributor"
  + Test_RBACAssignmentScope         = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-lab-1"

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.


```

Output should be similar to this:

```powershell

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

RGId = <sensitive>
RGLocation = "westeurope"
RGName = "rsg-lab-1"
Test_RBACAssignmentFull = <sensitive>
Test_RBACAssignmentGuid = "807e3816-6e73-f254-64c0-39f403e9e53e"
Test_RBACAssignmentId = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-lab-1/providers/Microsoft.Authorization/roleAssignments/807e3816-6e73-f254-64c0-39f403e9e53e"
Test_RBACAssignmentPrincipalId = <sensitive>
Test_RBACAssignmentPrincipalType = "ServicePrincipal"
Test_RBACAssignmentRoleName = "Virtual Machine Contributor"
UAI1_FullOutput = <sensitive>
UAI1_Id = <sensitive>
UAI1_Location = "westeurope"
UAI1_Name = "uailab1"
UAI1_PrincipalId = <sensitive>
UAI1_RG = "rsg-lab-1"

```

## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/RBAC001.png)

