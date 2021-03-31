# NSG Module

## Module description

This module deploys a Network Security Group

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| NSGSuffix | string | "" | A suffix to add at the end of the nsg name |
| NSGLocation | string | N/A | The region in which the resource lives. Changing this forces a new resource to be created. |
| RGName | string | N/A | The name of the resource group in which the NSG lives. Changing this forces a new resource to be created. |
| NICId | string | null | The Nic id associated to the nsg, default to null |
| SubnetId | string | null | The Subnet id associated to the nsg, default to null |
| ResourceOwnerTag | string | That would be me | Tag describing the owner |
| CountryTag | string | fr | Tag describing the Country |
| CostCenterTag | string | tflab | Tag describing the Cost Center |
| Project | string | tfmodule | The name of the project |
| Environment | string | dev | The environment, dev, prod... |  


### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|
| NSGFull | `azurerm_network_security_group.NSG` | send all the resource information available in the output. In future version, this may be the only output and detailed informtion will probably be queried specifically from the root module |
| Name | `azurerm_network_security_group.NSG.name` | The resource name |
| Location | `azurerm_network_security_group.NSG.location` | The resource location |
| Id | `azurerm_network_security_group.NSG.id` | The resource id |

## How to call the module

Use as follow:

```bash



```

### Sample display

terraform plan should gives the following output:

```powershell



```

output should be similar to this:

```powershell



```

## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/NSG001.png)