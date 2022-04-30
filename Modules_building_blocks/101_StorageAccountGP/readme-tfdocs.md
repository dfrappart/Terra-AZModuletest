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
| [azurerm_monitor_diagnostic_setting.STADiag_ToLAW](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.STADiag_ToSTA](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_storage_account.STOA](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_network_rules.STANTWDefaultRule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AllowedIPList"></a> [AllowedIPList](#input\_AllowedIPList) | List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed. | `list` | `[]` | no |
| <a name="input_AllowedSubnetIdList"></a> [AllowedSubnetIdList](#input\_AllowedSubnetIdList) | A list of virtual network subnet ids to to secure the storage account. | `list` | `[]` | no |
| <a name="input_ByPassConfig"></a> [ByPassConfig](#input\_ByPassConfig) | Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None. | `list` | <pre>[<br>  "Logging",<br>  "Metrics"<br>]</pre> | no |
| <a name="input_DefaultTags"></a> [DefaultTags](#input\_DefaultTags) | Define a set of default tags | `map` | <pre>{<br>  "CostCenter": "labtf",<br>  "Country": "fr",<br>  "Environment": "lab",<br>  "ManagedBy": "Terraform",<br>  "Project": "tfmodule",<br>  "ResourceOwner": "That would be me"<br>}</pre> | no |
| <a name="input_ExtraTags"></a> [ExtraTags](#input\_ExtraTags) | Define a set of additional optional tags. | `map` | `{}` | no |
| <a name="input_HTTPSSetting"></a> [HTTPSSetting](#input\_HTTPSSetting) | Boolean flag which forces HTTPS if enabled, see here for more information. Defaults to true. | `string` | `true` | no |
| <a name="input_IsHNSEnabled"></a> [IsHNSEnabled](#input\_IsHNSEnabled) | Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see here for more information). Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_LawLogId"></a> [LawLogId](#input\_LawLogId) | The Id of the Log Analytics workspace used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0 | `string` | `"unspecified"` | no |
| <a name="input_LogCategories"></a> [LogCategories](#input\_LogCategories) | Define The logs categories | <pre>map(object({<br>                                            LogCatName                = string<br>                                            IsLogCatEnabledForLAW     = bool<br>                                            IsLogCatEnabledForSTA     = bool<br>                                            IsRetentionEnabled        = bool<br>                                            RetentionDaysValue        = number<br>  }))</pre> | <pre>{<br>  "Category1": {<br>    "IsLogCatEnabledForLAW": false,<br>    "IsLogCatEnabledForSTA": true,<br>    "IsRetentionEnabled": true,<br>    "LogCatName": "StorageRead",<br>    "RetentionDaysValue": 365<br>  },<br>  "Category2": {<br>    "IsLogCatEnabledForLAW": false,<br>    "IsLogCatEnabledForSTA": true,<br>    "IsRetentionEnabled": true,<br>    "LogCatName": "StorageWrite",<br>    "RetentionDaysValue": 365<br>  },<br>  "Category3": {<br>    "IsLogCatEnabledForLAW": false,<br>    "IsLogCatEnabledForSTA": true,<br>    "IsRetentionEnabled": true,<br>    "LogCatName": "StorageDelete",<br>    "RetentionDaysValue": 365<br>  }<br>}</pre> | no |
| <a name="input_MetricCategories"></a> [MetricCategories](#input\_MetricCategories) | Define The metric categories | <pre>map(object({<br>                                            MetricCatName             = string<br>                                            IsMetricCatEnabledForLAW  = bool<br>                                            IsMetricCatEnabledForSTA  = bool<br>                                            IsRetentionEnabled        = bool<br>                                            RetentionDaysValue        = number<br>  }))</pre> | <pre>{<br>  "Metric": {<br>    "IsMetricCatEnabledForLAW": true,<br>    "IsMetricCatEnabledForSTA": true,<br>    "IsRetentionEnabled": true,<br>    "MetricCatName": "Capacity",<br>    "RetentionDaysValue": 365<br>  },<br>  "Metric1": {<br>    "IsMetricCatEnabledForLAW": true,<br>    "IsMetricCatEnabledForSTA": true,<br>    "IsRetentionEnabled": true,<br>    "MetricCatName": "Transaction",<br>    "RetentionDaysValue": 365<br>  }<br>}</pre> | no |
| <a name="input_RGName"></a> [RGName](#input\_RGName) | The name of the resource group in which to create the storage account. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_STALogId"></a> [STALogId](#input\_STALogId) | The Id of the storage account used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0 | `string` | `"unspecified"` | no |
| <a name="input_STANTWRuleDefaultAction"></a> [STANTWRuleDefaultAction](#input\_STANTWRuleDefaultAction) | Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow. | `string` | `"Deny"` | no |
| <a name="input_STASuffix"></a> [STASuffix](#input\_STASuffix) | a suffix to add at the end of the storage account name | `string` | n/a | yes |
| <a name="input_StorageAccessTier"></a> [StorageAccessTier](#input\_StorageAccessTier) | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot. | `string` | `null` | no |
| <a name="input_StorageAccountLocation"></a> [StorageAccountLocation](#input\_StorageAccountLocation) | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_StorageAccountTier"></a> [StorageAccountTier](#input\_StorageAccountTier) | Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_StorageAccoutKind"></a> [StorageAccoutKind](#input\_StorageAccoutKind) | Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to StorageV2. | `string` | `null` | no |
| <a name="input_StorageReplicationType"></a> [StorageReplicationType](#input\_StorageReplicationType) | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. | `string` | `"LRS"` | no |
| <a name="input_TLSVer"></a> [TLSVer](#input\_TLSVer) | The minimum supported TLS version for the storage account. Possible values are TLS1\_0, TLS1\_1, and TLS1\_2. | `string` | `"TLS1_2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ConnectionURI"></a> [ConnectionURI](#output\_ConnectionURI) | n/a |
| <a name="output_Id"></a> [Id](#output\_Id) | n/a |
| <a name="output_Name"></a> [Name](#output\_Name) | n/a |
| <a name="output_PrimaryAccessKey"></a> [PrimaryAccessKey](#output\_PrimaryAccessKey) | n/a |
| <a name="output_PrimaryBlobEP"></a> [PrimaryBlobEP](#output\_PrimaryBlobEP) | n/a |
| <a name="output_PrimaryFileEP"></a> [PrimaryFileEP](#output\_PrimaryFileEP) | n/a |
| <a name="output_PrimaryQueueEP"></a> [PrimaryQueueEP](#output\_PrimaryQueueEP) | n/a |
| <a name="output_PrimaryTableEP"></a> [PrimaryTableEP](#output\_PrimaryTableEP) | n/a |
| <a name="output_RGName"></a> [RGName](#output\_RGName) | n/a |
| <a name="output_STAFull"></a> [STAFull](#output\_STAFull) | n/a |
| <a name="output_SecondaryAccessKey"></a> [SecondaryAccessKey](#output\_SecondaryAccessKey) | n/a |
