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

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.subnet.azurerm_subnet.Subnet will be created
  + resource "azurerm_subnet" "Subnet" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "10.0.0.0/26",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "subagw"
      + resource_group_name                            = "rsgvaultlab"
      + virtual_network_name                           = "vnetaci"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

```  


## Sample display

terraform plan should gives the following output:

```powershell



```


## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/sub001.png)