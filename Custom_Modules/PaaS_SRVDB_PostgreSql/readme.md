# Azure Database for PostGreSQL Module

## Module description

This module deploys a Azure DataBase for PostGresql Server.
It includes configuration for:

- Threat detection
- Azure AD Administrator
- database(s) with a count functionnality
- virtual network rules with a count functionnality

It is also configured to create Azure monitor Alert on the following metrics:

- Database connection threshold
- Database storage threshold
- Database CPU Threshold

In order to send alert, it relies on a existing Azure Action Group.

Lastly, it is configured to send diagnostic to a storage account and a log analytic workspace

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| RgName | string | N/A | The name of the resource group in which the resources are deployed |
| Location | string | N/A | The Azure region|
| PSQLSuffix | string | "1" | A suffix to be added to the Server resource name |
| LawLogId | string | "unspecified" | The Id of the Log Analytics workspace used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0 |
| STALogId | string | "unspecified" | The Id of the storage account used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0 |
| LogCategory | map(object()) | See variables.tf | A map used to feed the log categories of the diagnostic settings |
| MetricCategory | map(object()) | See variables.tf | A map used to feed the log categories of the diagnostic settings |
| PostgreSkuName | string | "GP_Gen5_2" | Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8). For more information see the product documentation. |
| PostgreVersion | number | "11" | Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, 10, 10.0, and 11. Changing this forces a new resource to be created |
| PostgreLogin | string | "psqladmin" | The Administrator Login for the PostGreSQL Server. Required when create_mode is Default. Changing this forces a new resource to be created. |
| PostgrePwd | string | N/A | The Password associated with the administrator_login for the PostGreSQL Server. Required when create_mode is Default. |
| PostgreAutoGrow | bool | false | Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true. |
| PostgreStorage | string | 5120 | Max storage (in MB) allowed for a server. Possible values are between 5120 MB (5GB) and 1048576 MB (1TB) for the Basic SKU and between 5120 MB (5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs. |
| PostgreRetentionDays | number | 7 | Backup retention days for the server. Supported values are between 7 and 35 days. |
| PostgreGeoRedundantBackup | bool | false | Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not support for the Basic tier. Changing this forces a new resource to be created. |
| IsManagedIdentityEnabled | bool | false | A boolean to activate the MSI. Default to true |
| PostgreMSIType | string | "SystemAssigned" | Specifies the type of Managed Service Identity that should be configured on this PostgreSQL Server. The only possible value is SystemAssigned. |
| PostgreCreateMode | string | "Default" | The creation mode. Can be used to restore or replicate existing servers. Possible values are Default, Replica, GeoRestore, and PointInTimeRestore. Defaults to Default. |
| PostgreCreationSrcSrvId | string | null | For creation modes other then default the source server ID to use. |
| PostgreRestorePIT | string | null | When create_mode is PointInTimeRestore, specifies the point in time to restore from creation_source_server_id. |
| IsPublicAccessEnabledEnabled | bool | true | Whether or not public network access is allowed for this server. Defaults to true. |
| IsInfrastructureEncryptionEnabled | bool | false | Whether or not infrastructure is encrypted for this server. Defaults to false. Changing this forces a new resource to be created. |
| IsSSLEnforcementEnabled | bool | true | Specifies if SSL should be enforced on connections. Possible values are true and false. |
| PostgreTLSVer | string | "TLS1_2" | The minimum TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLSEnforcementDisabled in API, forced to . |
| IsthreatDetectionPolicyEnabled | bool | true | Define if Threat Detection Policy is enabled |
| PostgreThreatDetectionDisabledAlertList | list | null | Specifies a list of alerts which should be disabled. Possible values include Access_Anomaly, Sql_Injection and Sql_Injection_Vulnerability. |
| PostgreThreatDetectionEmailAdminAccount | bool | null | Should the account administrators be emailed when this alert is triggered? |
| PostgreThreatDetectionEmailRecipientsList | list | null | A list of email addresses which alerts should be sent to |
| PostgreThreatDetectionRetention | string | 365 | Specifies the number of days to keep in the Threat Detection audit logs. |
| PostgreThreatDetectionSTAKey | string | null | Specifies the identifier key of the Threat Detection audit storage account. |
| PostgreThreatDetectionSTAEP | string | null | Specifies the identifier key of the Threat Detection audit storage account |
| PostGreADAdminObjectId | string | N/A | Specifies the ID of the principal to set as the server administrator |
| PostGreADAdminLogin | string | mysqlaadadmin | The login name of the principal to set as the server administrator |
| PostgreDbList | list | [] | List of PostGreSQL databases names. |
| PostgreDbCharset | string | latin2 | Specifies the Charset for the PostGreSQL Database, which needs to be a valid PostGreSQL Charset. Changing this forces a new resource to be created. |
| PostgreDbCollation | string | latin2_general_ci | Specifies the Collation for the PostGreSQL Database, which needs to be a valid PostGreSQL Collation. Changing this forces a new resource to be created. |
| SubnetIds | list | [] | List of Subnet Ids to authorize on the PostGreSQL Server |
| AllowedPubIPs | list | [] | Public IP list to allow on Servers |
| ACGIds | set(string) | [] | A set of Action GroupResource Id |
| DBLowConnectionThreshold | string | 3 | threshold for Memory server load on DB |
| DBHighConnectionThreshold | string | 200 | threshold for Memory server load on DB |
| DBFailedConnectionThreshold | string | 10 | threshold for failed connection on DB |
| DBStoragePercentHighThreshold | string | 80 | threshold for Storage high threshold on DB |
| DBCPUPercentHighThreshold | string | 80 | threshold for CPU high threshold on DB |
| DefaultTags |  map(object()) | See variables.tfstring | A map to define mandatory tags |
| ExtraTags | map(object()) | See variables.tf | A map to add custom tags if needed |


### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|


## How to call the module

Use as follow:

```bash



```

## Sample display

terraform plan should gives the following output:

```powershell



```

output should be similar to this:

```powershell



```

## Sample deployment

After deployment, something simlilar is visible in the portal:


