# Azure Virtual Network Module

## Module description

This module deploys an Azure Virtual Network

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| SubnetSuffix | string | N/A | A suffix forthe subnet. Changing this forces a new resource to be created. |
| RGName | string | N/A | The name of the resource group in which to create the subnet. Changing this forces a new resource to be created. |
| VNetName | string | N/A | TThe name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created. | 
| Subnetaddressprefixes | list | N/A |  "The address prefixes to use for the subnet." |  


### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|
| Name | `azurerm_subnet.Subnet.name`| The resource name |
| Id | `azurerm_subnet.Subnet.id` | The resource id|
| AddressPrefix | `azurerm_subnet.Subnet.address_prefix[0]` | The virtualnetwork address space|
| FullSubnet |`azurerm_subnet.Subnet` | Send all the information of the resource in the output|
  

## How to call the module

An existing RG is required, so use of data source is recommanded.
Use as follow:

```bash



```  


## Sample display

terraform plan should gives the following output:

```powershell



```


## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/sub001.png)