# Storage Account container module

## Module description

This module creates a container in a storage account

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| StorageContainerName | string | N/A | a suffix to add at the end of the storage account name |
| StorageAccountName | string | N/A | The name of the resource group in which to create the storage account. Changing this forces a new resource to be created. |
| AccessType | string | private | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |


### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|
| Full | `azurerm_storage_container.STC` | send all the resource information available in the output. In future version, this may be the only output and detailed informtion will probably be queried specifically from the root module |
| Name | `azurerm_storage_container.STC.name` | The resource name |
| Id | `azurerm_storage_container.STC.id` | The resource Id |
| ResourceManagerId | `azurerm_storage_container.STC.primary_blob_endpoint` | The primary Blob Endpoint |
| ImmutabilityStatus | `azurerm_storage_container.STC.primary_queue_endpoint` | The immutability status of the stc |
| LegalHoldStatus | `azurerm_storage_container.STC.primary_table_endpoint` | The legal hold status of the stc |
| STAName | `azurerm_storage_container.STC.primary_file_endpoint` | The storage account name in which the stc lives |


## How to call the module
 

Use as follow:

```bash

# Creating the STC

module "STATest" {

  #Module Location
  source                                = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//101_StorageAccountGP"
  #Module variable    
  STASuffix                             = "cpt_data"
  RGName                                = var.RGLocation
  StorageAccountLocation                = var.ResourceOwnerTag



}



```

## Sample display

terraform plan should gives the following output:

```powershell


```

Output should be similar to this:

```powershell



```

## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/STC001.png)

