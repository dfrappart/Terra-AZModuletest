# Storage Account module

## Module description

This module assign a built in role to a principal.

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| STASuffix | string | N/A | a suffix to add at the end of the storage account name |
| RGName | string | N/A | TThe name of the resource group in which to create the storage account. Changing this forces a new resource to be created. |
| StorageAccountLocation | string | N/A | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| StorageAccountTier | string | Standard | Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. |
| StorageReplicationType | string | LRS | "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. |
| StorageAccessTier | string | null | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot. |
| HTTPSSetting | string | true | Boolean flag which forces HTTPS if enabled, see here for more information. Defaults to true. |
| TLSVer | string | TLS1_2 | The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. |
| ResourceOwnerTag | string | That would be me | Tag describing the owner |
| CountryTag | string | fr | Tag describing the Country |
| CostCenterTag | string | tflab | Tag describing the Cost Center which is the same as the one on the EA |
| Company | string | dfitc | The Company owner of the resources |
| Project | string | tfmodule | The name of the project |
| Environment | string | dev | The environment, dev, prod... |  

### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|
| STAFull | `azurerm_storage_account.Terra_STOA` | send all the resource information available in the output. In future version, this may be the only output and detailed informtion will probably be queried specifically from the root module |
| Name | `azurerm_storage_account.Terra_STOA.name` | The resource name |
| Id | `azurerm_storage_account.Terra_STOA.id` | The resource Id |
| PrimaryBlobEP | `azurerm_storage_account.Terra_STOA.primary_blob_endpoint` | The primary Blob Endpoint |
| PrimaryQueueEP | `azurerm_storage_account.Terra_STOA.primary_queue_endpoint` | The primary Queue Endpoint |
| PrimaryTableEP | `azurerm_storage_account.Terra_STOA.primary_table_endpoint` | The primary Table Endpoint |
| PrimaryFileEP | `azurerm_storage_account.Terra_STOA.primary_file_endpoint` | The primary File Endpoint |
| PrimaryAccessKey | `azurerm_storage_account.Terra_STOA.primary_access_key` | The primary access key |
| SecondaryAccessKey | `azurerm_storage_account.Terra_STOA.secondary_access_key` | The secondary access key |
| ConnectionURI | `azurerm_storage_account.Terra_STOA.primary_blob_connection_string` | The blob connection string |
| RGName | `azurerm_storage_account.Terra_STOA.resource_group_name` | The primary File Endpoint |

## How to call the module
 

Use as follow:

```bash

# Creating the STA

module "STATest" {

  #Module Location
  source                                = "../../Modules/002_ResourceGroup/"
  #Module variable    
  STASuffix                             = "cpt_data"
  RGName                                = var.RGLocation
  StorageAccountLocation                = var.ResourceOwnerTag



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