## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_bastion_host.SpokeBastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |
| [azurerm_monitor_diagnostic_setting.AZBastionDiag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.AZBastionPIPDiag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.AppGWSubnetNSGDiag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.AzureBastionNSGDiag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.BESubnetNSGDiag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.FESubnetNSGDiag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.SpokeVNetDiagToLaw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.SpokeVNetDiagtoSTA](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_security_group.AppGWSubnetNSG](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.AzureBastionNSG](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.BESubnetNSG](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.FESubnetNSG](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.Default_AllowAzureBastionCommunicationOut](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_AllowAzureBastionGetSessionInformationOut](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_AllowAzureCloudHTTPSOut](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_AppGWSubnet_GatewayManager](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_BESubnet_AllowLB](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_BESubnet_AllowRDPSSHFromBastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_BastionSubnet_AllowAzureLB](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_BastionSubnet_AllowBastionCommunicationIn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_BastionSubnet_AllowGatewayManager](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_BastionSubnet_AllowHTTPSBastionIn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_BastionSubnet_AllowRemoteBastionOut](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_BastionSubnet_DenyInternetOut](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_BastionSubnet_DenyVNetOut](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_FESubnet_AllowLB](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_FESubnet_AllowRDPSSHFromBastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.Default_FESubnet_DenyVNetSSHRDPIn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_watcher_flow_log.AppGWSubnetNSGFlowLog](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_network_watcher_flow_log.AzureBastionNSGFlowLog](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_network_watcher_flow_log.BESubnetNSGFlowLog](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_network_watcher_flow_log.FESubnetNSGFlowLog](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_public_ip.BastionPublicIP](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet.AppGWSubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.AzBastionmanagedSubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.BESubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.FESubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.AppGWSubnetNSGAssociation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.BESubnetNSGAssociation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.BastionSubnetNSGAssociation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.FESubnetNSGAssociation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.SpokeVNet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_log_analytics_workspace.LawSubLog](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_resource_group.RGLogs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AGWSubnetPosition"></a> [AGWSubnetPosition](#input\_AGWSubnetPosition) | A integer used in the function cidrsubnet to position the subnet range | `string` | `1` | no |
| <a name="input_BESubnetPosition"></a> [BESubnetPosition](#input\_BESubnetPosition) | A integer used in the function cidrsubnet to position the subnet range | `string` | `3` | no |
| <a name="input_BastionSubnetPosition"></a> [BastionSubnetPosition](#input\_BastionSubnetPosition) | A integer used in the function cidrsubnet to position the subnet range | `string` | `0` | no |
| <a name="input_CidrDividerAppSubnet"></a> [CidrDividerAppSubnet](#input\_CidrDividerAppSubnet) | The divider used for the function cidrsubnet. Default to 2 with a default CIDR to /24 | `string` | `2` | no |
| <a name="input_CidrDividerInfraSubnet"></a> [CidrDividerInfraSubnet](#input\_CidrDividerInfraSubnet) | The divider used for the function cidrsubnet. Default to 2 with a default CIDR to /24 | `string` | `2` | no |
| <a name="input_DefaultTags"></a> [DefaultTags](#input\_DefaultTags) | Define a set of default tags | `map` | <pre>{<br>  "CostCenter": "labtf",<br>  "Country": "fr",<br>  "Environment": "lab",<br>  "ManagedBy": "Terraform",<br>  "Project": "tfmodule",<br>  "ResourceOwner": "That would be me"<br>}</pre> | no |
| <a name="input_ExtraTags"></a> [ExtraTags](#input\_ExtraTags) | Define a set of additional optional tags. | `map` | `{}` | no |
| <a name="input_FESubnetPosition"></a> [FESubnetPosition](#input\_FESubnetPosition) | A integer used in the function cidrsubnet to position the subnet range | `string` | `2` | no |
| <a name="input_IsBastionEnabled"></a> [IsBastionEnabled](#input\_IsBastionEnabled) | Define if Bastion is enabled or not | `bool` | `false` | no |
| <a name="input_IsTrafficAnalyticsEnabled"></a> [IsTrafficAnalyticsEnabled](#input\_IsTrafficAnalyticsEnabled) | Define if Traffic Analytics is enabled or not | `bool` | `true` | no |
| <a name="input_LawLogId"></a> [LawLogId](#input\_LawLogId) | The Id of the Log Analytics workspace used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0 | `string` | `"unspecified"` | no |
| <a name="input_LawSubLogName"></a> [LawSubLogName](#input\_LawSubLogName) | name of the log analytics workspace containing the logs | `string` | n/a | yes |
| <a name="input_NetworkWatcherName"></a> [NetworkWatcherName](#input\_NetworkWatcherName) | The name of the network watcher, in the appropriate region | `string` | `"NetworkWatcher_westeurope"` | no |
| <a name="input_NetworkWatcherRGName"></a> [NetworkWatcherRGName](#input\_NetworkWatcherRGName) | The name of the network watcher resource group | `string` | `"NetworkWatcherRG"` | no |
| <a name="input_RGLogName"></a> [RGLogName](#input\_RGLogName) | name of the RG containing the logs collector objects (sta and log analytics) | `string` | n/a | yes |
| <a name="input_STALogId"></a> [STALogId](#input\_STALogId) | The Id of the storage account used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0 | `string` | `"unspecified"` | no |
| <a name="input_SubnetEndpointLists"></a> [SubnetEndpointLists](#input\_SubnetEndpointLists) | The list of Service endpoints to associate with the subnet. | `list` | <pre>[<br>  "Microsoft.Sql",<br>  "Microsoft.ContainerRegistry"<br>]</pre> | no |
| <a name="input_TargetLocation"></a> [TargetLocation](#input\_TargetLocation) | Location of the resources to be deployed | `string` | n/a | yes |
| <a name="input_TargetRG"></a> [TargetRG](#input\_TargetRG) | name of the RG targeted for the deployment | `string` | n/a | yes |
| <a name="input_VNetAddressSpace"></a> [VNetAddressSpace](#input\_VNetAddressSpace) | The IP address range for the VNet. It is a list and can thus contain more than 1 ip ranges | `list` | <pre>[<br>  "172.20.0.0/24"<br>]</pre> | no |
| <a name="input_VNetLogCategories"></a> [VNetLogCategories](#input\_VNetLogCategories) | Define The logs categories | <pre>map(object({<br>                                            LogCatName                = string<br>                                            IsLogCatEnabledForLAW     = bool<br>                                            IsLogCatEnabledForSTA     = bool<br>                                            IsRetentionEnabled        = bool<br>                                            RetentionDaysValue        = number<br>  }))</pre> | <pre>{<br>  "Category1": {<br>    "IsLogCatEnabledForLAW": true,<br>    "IsLogCatEnabledForSTA": true,<br>    "IsRetentionEnabled": true,<br>    "LogCatName": "VMProtectionAlerts",<br>    "RetentionDaysValue": 365<br>  }<br>}</pre> | no |
| <a name="input_VNetMetricCategories"></a> [VNetMetricCategories](#input\_VNetMetricCategories) | Define The metric categories | <pre>map(object({<br>                                            MetricCatName             = string<br>                                            IsMetricCatEnabledForLAW  = bool<br>                                            IsMetricCatEnabledForSTA  = bool<br>                                            IsRetentionEnabled        = bool<br>                                            RetentionDaysValue        = number<br>  }))</pre> | <pre>{<br>  "Metric1": {<br>    "IsMetricCatEnabledForLAW": false,<br>    "IsMetricCatEnabledForSTA": true,<br>    "IsRetentionEnabled": true,<br>    "MetricCatName": "AllMetrics",<br>    "RetentionDaysValue": 365<br>  }<br>}</pre> | no |
| <a name="input_VNetSuffix"></a> [VNetSuffix](#input\_VNetSuffix) | The suffix for the module spoke, something like spoke01 | `string` | `"Spoke"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_AGWSubnetFullOutput"></a> [AGWSubnetFullOutput](#output\_AGWSubnetFullOutput) | n/a |
| <a name="output_AGWSubnetNSGFullOutput"></a> [AGWSubnetNSGFullOutput](#output\_AGWSubnetNSGFullOutput) | n/a |
| <a name="output_AzureBastionNSGId"></a> [AzureBastionNSGId](#output\_AzureBastionNSGId) | n/a |
| <a name="output_AzureBastionNSGName"></a> [AzureBastionNSGName](#output\_AzureBastionNSGName) | n/a |
| <a name="output_AzureBastionSubnetFullId"></a> [AzureBastionSubnetFullId](#output\_AzureBastionSubnetFullId) | n/a |
| <a name="output_BESubnetFullOutput"></a> [BESubnetFullOutput](#output\_BESubnetFullOutput) | n/a |
| <a name="output_BESubnetNSGFullOutput"></a> [BESubnetNSGFullOutput](#output\_BESubnetNSGFullOutput) | n/a |
| <a name="output_FESubnetFullOutput"></a> [FESubnetFullOutput](#output\_FESubnetFullOutput) | n/a |
| <a name="output_FESubnetNSGFullOutput"></a> [FESubnetNSGFullOutput](#output\_FESubnetNSGFullOutput) | n/a |
| <a name="output_LAWFullOutput"></a> [LAWFullOutput](#output\_LAWFullOutput) | n/a |
| <a name="output_SpokeBastionIpConfig"></a> [SpokeBastionIpConfig](#output\_SpokeBastionIpConfig) | n/a |
| <a name="output_SpokeBastionName"></a> [SpokeBastionName](#output\_SpokeBastionName) | n/a |
| <a name="output_SpokeBastionRG"></a> [SpokeBastionRG](#output\_SpokeBastionRG) | n/a |
| <a name="output_VNetFullOutput"></a> [VNetFullOutput](#output\_VNetFullOutput) | n/a |
