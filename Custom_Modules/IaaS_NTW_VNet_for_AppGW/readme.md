<!-- BEGIN_TF_DOCS -->

# Module VNet

This module is used to provision an Azure Virtual Network with subnets and NSGs

## Module description

This module deploys an Azure Virtual Network
It includes configuration for:

- The Vnet,
- Azure diagnostic settings for the Vnet,
- Subnets,
- NSGs,
- Azure diagnostic settings for the NSGs
- Flow Logs for the NSGs.

## How to call the module

Create Vnet:

```hcl


module "testvnet" {
    source = ""

    RgName = "rsg-demo1"
    CustomVnet = true
    AppName = "spokedemo"
    EnableVnetDiagSettings = true
    LawLogId = var.LawMonitorId
    StaLogId = var.StaMonitorId


    Vnet = {
      Name = ""
      AddressSpace = "172.21.0.0/25"
      DnsServers = []
    }

    Subnets = [ 
      {
        Name = "Subnet1"
        AllowCustomName = false
        EnableNsg = true
        Nsg = {
          Name = "Nsg-Subnet1"
          Rules = {}
        }
      },
      {
        Name = "Subnet2"
        AllowCustomName = false
        EnableNsg = true
        Nsg = {
          Name = ""
          Rules = {}
        }
      },
      {
        Name = "Subnet3"
        AllowCustomName = false
        EnableNsg = true

        Nsg = {
          Name = ""
          Rules = {}
        }
      },
      {
        Name = "Subnet4"
        AllowCustomName = false
        EnableNsg = true

        Nsg = {
          Name = ""
          Rules = {}
        }
      }

    ]
}

```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AppName"></a> [AppName](#input\_AppName) | Define the app name | `string` | `""` | no |
| <a name="input_CreateRG"></a> [CreateRG](#input\_CreateRG) | Is the rg created within the module. Default to false | `bool` | `false` | no |
| <a name="input_CustomVnet"></a> [CustomVnet](#input\_CustomVnet) | Define the Vnet type. If false, the subnets are following a regular pattern in size. If true, subnets follow specific patterns | `bool` | `false` | no |
| <a name="input_DefaultTags"></a> [DefaultTags](#input\_DefaultTags) | Define a set of default tags | `map(any)` | <pre>{<br>  "Company": "dfitc",<br>  "CostCenter": "lab",<br>  "Country": "fr",<br>  "Environment": "dev",<br>  "Project": "tfmodule",<br>  "ResourceOwner": "That would be me"<br>}</pre> | no |
| <a name="input_EnableVnetDiagSettings"></a> [EnableVnetDiagSettings](#input\_EnableVnetDiagSettings) | A bool to enable or disable the diagnostic settings | `bool` | `false` | no |
| <a name="input_Env"></a> [Env](#input\_Env) | Define the environment kind. Possible value are sbx, dev or prd | `string` | `"sbx"` | no |
| <a name="input_ExtraTags"></a> [ExtraTags](#input\_ExtraTags) | Define a set of additional optional tags. | `map(any)` | `{}` | no |
| <a name="input_IsTrafficAnalyticsEnabled"></a> [IsTrafficAnalyticsEnabled](#input\_IsTrafficAnalyticsEnabled) | Define if flow log is enabled wih traffic analytics | `bool` | `true` | no |
| <a name="input_LawLogId"></a> [LawLogId](#input\_LawLogId) | ID of the log analytics workspace containing the logs, if not specified, no diagnostic settings to log analytics is created | `string` | `"unspecified"` | no |
| <a name="input_Location"></a> [Location](#input\_Location) | The azure region | `string` | `"eastus"` | no |
| <a name="input_NetworkWatcherName"></a> [NetworkWatcherName](#input\_NetworkWatcherName) | Define the Network Watcher Name. If not specified, locals block create the default name for network watcher | `string` | `"unspecified"` | no |
| <a name="input_NetworkWatcherRGName"></a> [NetworkWatcherRGName](#input\_NetworkWatcherRGName) | Define the Resource group for Network Watcher. If not specified, locals block create the default resource group name for network watcher | `string` | `"unspecified"` | no |
| <a name="input_NsgLogCategories"></a> [NsgLogCategories](#input\_NsgLogCategories) | A list of log categories to activate on the Nsgs. If set to null, it will use a data source to enable all categories | `list(any)` | `null` | no |
| <a name="input_NsgMetricCategories"></a> [NsgMetricCategories](#input\_NsgMetricCategories) | A list of metric categories to activate on the Nsgs. If set to null, it will use a data source to enable all categories | `list(any)` | `null` | no |
| <a name="input_ObjectIndex"></a> [ObjectIndex](#input\_ObjectIndex) | Define the index of the resources | `number` | `1` | no |
| <a name="input_ResourceGroupPrefix"></a> [ResourceGroupPrefix](#input\_ResourceGroupPrefix) | Define the resource prexix, as define in the Cloud adoptio  framework. | `string` | `"rg"` | no |
| <a name="input_RgName"></a> [RgName](#input\_RgName) | A string to define the resource group name. If not define, the empty value is replace by a local construct | `string` | `""` | no |
| <a name="input_StaLogId"></a> [StaLogId](#input\_StaLogId) | Id of the storage account containing the logs, if not specified, no diagnostic settings to storage account is created | `string` | `"unspecified"` | no |
| <a name="input_Subnets"></a> [Subnets](#input\_Subnets) | An object containing the informations needed to create subnets, the rules object is optional and is used to add nsg rules on top of the default\_nsg\_rules | <pre>list(object({<br>    Name            = string<br>    AllowCustomName = bool<br>    EnableNsg       = bool<br>    Nsg = object({<br>      Name = string<br>      Rules = map(object({<br>        Name                     = string<br>        Priority                 = number<br>        Direction                = string<br>        Access                   = string<br>        Protocol                 = string<br>        SourcePortRange          = string<br>        DestinationPortRange     = string<br>        SourceAddressPrefix      = string<br>        DestinationAddressPrefix = string<br>      }))<br>    })<br>  }))</pre> | <pre>[<br>  {<br>    "AllowCustomName": false,<br>    "EnableNsg": true,<br>    "Name": "Subnet1",<br>    "Nsg": {<br>      "Name": "Nsg-Subnet1",<br>      "Rules": {}<br>    }<br>  }<br>]</pre> | no |
| <a name="input_Vnet"></a> [Vnet](#input\_Vnet) | An object containing the vnet name, address space and linked dns servers (defaults to Azure DNS), the number of subnets is automatically defined based on the address space's mask | <pre>object({<br>    Name         = string<br>    AddressSpace = string<br>    DnsServers   = list(string)<br>  })</pre> | <pre>{<br>  "AddressSpace": "172.21.0.0/24",<br>  "DnsServers": [],<br>  "Name": ""<br>}</pre> | no |
| <a name="input_VnetLogCategories"></a> [VnetLogCategories](#input\_VnetLogCategories) | A list of log categories to activate on the Virtual Network. If set to null, it will use a data source to enable all categories | `list(any)` | `null` | no |
| <a name="input_VnetMetricCategories"></a> [VnetMetricCategories](#input\_VnetMetricCategories) | A list of metric categories to activate on the Virtual Network. If set to null, it will use a data source to enable all categories | `list(any)` | `null` | no |
| <a name="input_VnetResourcePrefix"></a> [VnetResourcePrefix](#input\_VnetResourcePrefix) | Define the resource prexix, as define in the Cloud adoption  framework. | `string` | `"vnet"` | no |
| <a name="input_default_nsg_rules"></a> [default\_nsg\_rules](#input\_default\_nsg\_rules) | A map of object used to create dafault NSG rules for all NSGs inside the spoke | <pre>map(object({<br>    name                       = string<br>    priority                   = number<br>    direction                  = string<br>    access                     = string<br>    protocol                   = string<br>    source_port_range          = string<br>    destination_port_range     = string<br>    source_address_prefix      = string<br>    destination_address_prefix = string<br>  }))</pre> | `{}` | no |

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.LawMonitor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_diagnostic_setting.NsgDiagSettings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.VnetDiagSettings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_security_group.Nsgs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_watcher_flow_log.Flowlogs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_resource_group.VnetResourceGroup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.StaMonitor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_subnet.Subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.NsgtoSubnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.Vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [random_string.RandomAppName](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_log_analytics_workspace.LawLog](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_diagnostic_categories.Nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_monitor_diagnostic_categories.Vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_resource_group.RgVnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_RG"></a> [RG](#output\_RG) | Information on the Vnet RG |
| <a name="output_Subnets"></a> [Subnets](#output\_Subnets) | n/a |
| <a name="output_VNetFullOutput"></a> [VNetFullOutput](#output\_VNetFullOutput) | n/a |
| <a name="output_keylocalsubnet"></a> [keylocalsubnet](#output\_keylocalsubnet) | n/a |
| <a name="output_subprefix"></a> [subprefix](#output\_subprefix) | n/a |

## How to update this documentation

In the module folder, use the following command.

```bash

terraform-docs --config ./.config/.terraform-doc.yml .

```
<!-- END_TF_DOCS -->