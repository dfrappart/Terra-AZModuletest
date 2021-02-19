# Logic App Module

## Module description

This module creates a simple logic app

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| LGASuffix | string | N/A | a suffix to add at the end of the Logic app name |
| RGName | string | N/A | TThe name of the resource group in which to create the resources. Changing this forces a new resource to be created. |
| LGALocation | string | N/A | Specifies the supported Azure location where the Logic App Workflow exists. Changing this forces a new resource to be created. |
| LGAISEId | string | null | The ID of the Integration Service Environment to which this Logic App Workflow belongs. Changing this forces a new Logic App Workflow to be created. |
| LGAIAId | string | null | The ID of the integration account linked by this Logic App Workflow. |
| LGASchema | string | null | Specifies the Schema to use for this Logic App Workflow. Defaults to https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#. Changing this forces a new resource to be created. |
| LGAWorkflowVersion | string | null | Specifies the version of the Schema used for this Logic App Workflow. Defaults to 1.0.0.0. Changing this forces a new resource to be created. |
| LGAParam | map | null | TA map of Key-Value pairs. |
| ResourceOwnerTag | string | That would be me | Tag describing the owner |
| CountryTag | string | fr | Tag describing the Country |
| CostCenterTag | string | tflab | Tag describing the Cost Center |
| Company | string | dfitc | The Company owner of the resources |
| Project | string | tfmodule | The name of the project |
| Environment | string | dev | The environment, dev, prod... |  

### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|
| LGAFull | `azurerm_logic_app_workflow.Terra_LGA` | send all the resource information available in the output. In future version, this may be the only output and detailed informtion will probably be queried specifically from the root module |

## How to call the module
 

Use as follow:

```bash



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

![Illustration 1](./Img/LGA001.png)

