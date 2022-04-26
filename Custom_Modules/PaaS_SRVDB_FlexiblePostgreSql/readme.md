## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.8 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.AzurePSQLDiagToLAWA](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.AzurePSQLDiagToSTA](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_metric_alert.DBCPU](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.DBConnectThreshold](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.DBStorage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_postgresql_flexible_server.PostGreSQLFlexServer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_private_dns_zone.PSQLPrivateDNSZoneId](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_subnet.psqlsubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.psqlflexiblentw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ACGIds"></a> [ACGIds](#input\_ACGIds) | A set of Action GroupResource Id | `set(string)` | `[]` | no |
| <a name="input_CustomMaintenanceWindow"></a> [CustomMaintenanceWindow](#input\_CustomMaintenanceWindow) | A booleen used to activate the dynamic block for maintenance windiws | `bool` | `false` | no |
| <a name="input_CustomMaintenanceWindowDay"></a> [CustomMaintenanceWindowDay](#input\_CustomMaintenanceWindowDay) | The day of week for maintenance window, where the week starts on a Sunday, i.e. Sunday = 0, Monday = 1. Defaults to 0. | `number` | `null` | no |
| <a name="input_CustomMaintenanceWindowHour"></a> [CustomMaintenanceWindowHour](#input\_CustomMaintenanceWindowHour) | The start hour for maintenance window. Defaults to 0 | `number` | `null` | no |
| <a name="input_CustomMaintenanceWindowMinute"></a> [CustomMaintenanceWindowMinute](#input\_CustomMaintenanceWindowMinute) | The start minute for maintenance window. Defaults to 0. | `number` | `null` | no |
| <a name="input_DefaultTags"></a> [DefaultTags](#input\_DefaultTags) | Define a set of default tags | `map` | <pre>{<br>  "CostCenter": "labtf",<br>  "Country": "fr",<br>  "Environment": "lab",<br>  "ManagedBy": "Terraform",<br>  "Project": "tfmodule",<br>  "ResourceOwner": "That would be me"<br>}</pre> | no |
| <a name="input_ExtraTags"></a> [ExtraTags](#input\_ExtraTags) | Define a set of additional optional tags. | `map` | `{}` | no |
| <a name="input_HAMode"></a> [HAMode](#input\_HAMode) | The high availability mode for the PostgreSQL Flexible Server. The only possible value is ZoneRedundant. | `string` | `"ZoneRedundant"` | no |
| <a name="input_HAStandbyAZ"></a> [HAStandbyAZ](#input\_HAStandbyAZ) | The ID of the private dns zone to create the PostgreSQL Flexible Server. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_LawLogId"></a> [LawLogId](#input\_LawLogId) | The Id of the Log Analytics workspace used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0 | `string` | `"unspecified"` | no |
| <a name="input_Location"></a> [Location](#input\_Location) | Azure region. | `string` | `"westeurope"` | no |
| <a name="input_LogCategory"></a> [LogCategory](#input\_LogCategory) | A map to feed the log categories of the diagnostic settings | <pre>map(object({<br>                                                  LogCatName                  = string<br>                                                  IsLogCatEnabledForLAW       = bool<br>                                                  IsLogCatEnabledForSTA       = bool<br>                                                  IsRetentionEnabled          = bool<br>                                                  RetentionDaysValue          = number<br>  }))</pre> | <pre>{<br>  "Category1": {<br>    "IsLogCatEnabledForLAW": true,<br>    "IsLogCatEnabledForSTA": true,<br>    "IsRetentionEnabled": true,<br>    "LogCatName": "PostgreSQLLogs",<br>    "RetentionDaysValue": 365<br>  }<br>}</pre> | no |
| <a name="input_MetricCategory"></a> [MetricCategory](#input\_MetricCategory) | A map to feed the log categories of the diagnostic settings | <pre>map(object({<br>                                                  MetricCatName               = string<br>                                                  IsMetricCatEnabledForLAW    = bool<br>                                                  IsMetricCatEnabledForSTA    = bool<br>                                                  IsRetentionEnabled          = bool<br>                                                  RetentionDaysValue          = number<br>  }))</pre> | <pre>{<br>  "Category1": {<br>    "IsMetricCatEnabledForLAW": false,<br>    "IsMetricCatEnabledForSTA": true,<br>    "IsRetentionEnabled": true,<br>    "MetricCatName": "AllMetrics",<br>    "RetentionDaysValue": 365<br>  }<br>}</pre> | no |
| <a name="input_PSQLPrivateDNSZoneId"></a> [PSQLPrivateDNSZoneId](#input\_PSQLPrivateDNSZoneId) | The ID of the private dns zone to create the PostgreSQL Flexible Server. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | <pre>[<br>  "unspecified"<br>]</pre> | no |
| <a name="input_PSQLSubnetId"></a> [PSQLSubnetId](#input\_PSQLSubnetId) | The ID of the virtual network subnet to create the PostgreSQL Flexible Server. The provided subnet should not have any other resource deployed in it and this subnet will be delegated to the PostgreSQL Flexible Server, if not already delegated. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | <pre>[<br>  "unspecified"<br>]</pre> | no |
| <a name="input_PSQLSuffix"></a> [PSQLSuffix](#input\_PSQLSuffix) | a suffix to add to the composed name, changing this change the name and thus recreate the resource | `string` | `"1"` | no |
| <a name="input_PostgreCreateMode"></a> [PostgreCreateMode](#input\_PostgreCreateMode) | The creation mode. Can be used to restore or replicate existing servers. Possible values are Default, Replica, GeoRestore, and PointInTimeRestore. Defaults to Default. | `string` | `"Default"` | no |
| <a name="input_PostgreCreationSrcSrvId"></a> [PostgreCreationSrcSrvId](#input\_PostgreCreationSrcSrvId) | For creation modes other then default the source server ID to use. | `string` | `null` | no |
| <a name="input_PostgreGeoRedundantBackup"></a> [PostgreGeoRedundantBackup](#input\_PostgreGeoRedundantBackup) | Choice whether enabling Geo-redundant server backups. This is not support for the Basic tier. Possible values are true or false. | `bool` | `false` | no |
| <a name="input_PostgreLogin"></a> [PostgreLogin](#input\_PostgreLogin) | Administrator login for the PostgreSQL server. | `string` | `"sqladmin"` | no |
| <a name="input_PostgrePwd"></a> [PostgrePwd](#input\_PostgrePwd) | Password associated with the administrator\_login for the PostgreSQL server. | `string` | n/a | yes |
| <a name="input_PostgreRestorePIT"></a> [PostgreRestorePIT](#input\_PostgreRestorePIT) | When create\_mode is PointInTimeRestore the point in time to restore from creation\_source\_server\_id. | `string` | `null` | no |
| <a name="input_PostgreRetentionDays"></a> [PostgreRetentionDays](#input\_PostgreRetentionDays) | Backup retention days for the server. Supported values are between 7 and 35 days. | `string` | `7` | no |
| <a name="input_PostgreSkuName"></a> [PostgreSkuName](#input\_PostgreSkuName) | The SKU Name for the PostgreSQL Flexible Server. The name of the SKU, follows the tier + name pattern (e.g. B\_Standard\_B1ms, GP\_Standard\_D2s\_v3, MO\_Standard\_E4s\_v3). | `string` | `"B_Standard_B1ms"` | no |
| <a name="input_PostgreStorage"></a> [PostgreStorage](#input\_PostgreStorage) | The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, and 33554432. | `number` | `32768` | no |
| <a name="input_PostgreVersion"></a> [PostgreVersion](#input\_PostgreVersion) | The version of PostgreSQL Flexible Server to use. Possible values are 11,12 and 13. Required when create\_mode is Default. Changing this forces a new PostgreSQL Flexible Server to be created. | `number` | `11` | no |
| <a name="input_PostgreZone"></a> [PostgreZone](#input\_PostgreZone) | Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located. | `string` | `null` | no |
| <a name="input_RgName"></a> [RgName](#input\_RgName) | Resource Group name provided as a string. chaning this input will recreate everything | `string` | n/a | yes |
| <a name="input_STALogId"></a> [STALogId](#input\_STALogId) | The Id of the storage account used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0 | `string` | `"unspecified"` | no |

## Outputs

No outputs.
