# Azure Database for PostgresSQL Flexible Module

## Module description

This module deploys a Azure DataBase for PostGreSQL Flexible Server.

- database(s) with a count functionnality

It is also configured to create Azure monitor Alert on the following metrics:

- Database connection threshold
- Database storage threshold
- Database CPU Threshold

In order to send alert, it relies on a existing Azure Action Group.

Lastly, it is configured to send diagnostic to a storage account and a log analytic workspace

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| RgName | string | N/A | The name of the Resource Group where the PostgreSQL Flexible Server should exist. Changing this forces a new PostgreSQL Flexible Server to be created. |
| Location | string | N/A | The Azure Region where the PostgreSQL Flexible Server should exist. Changing this forces a new PostgreSQL Flexible Server to be created. |
| PSQLSuffix | string | "-01" | a suffix to add to the composed name, changing this change the name and thus recreate the resource |
| LawLogId | string | "unspecified" | The Id of the Log Analytics workspace used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0 |
| STALogId | string | "unspecified" | The Id of the storage account used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0 |
| LogCategory | map(object()) | See variables.tf | A map to feed the log categories of the diagnostic settings |
| MetricCategory | map(object()) | See variables.tf | A map to feed the log categories of the diagnostic settings |
| PostgreLogin | string | "psqladmin" | The Administrator Login for the PostgreSQL Flexible Server. Required when create_mode is Default. Changing this forces a new PostgreSQL Flexible Server to be created. |
| PostgrePwd | string | N/A | The Password associated with the administrator_login for the PostgreSQL Flexible Server. Required when create_mode is Default. |
| PostgreRetentionDays | number | 7 | Backup retention days for the server, supported values are between 7 and 35 days. |
| PostgreGeoRedundantBackup | bool | false | Is Geo-Redundant backup enabled on the PostgreSQL Flexible Server. Defaults to false. Changing this forces a new PostgreSQL Flexible Server to be created. |
| PostgreCreateMode | string | "Default" | The creation mode. Can be used to restore or replicate existing servers. Possible values are Default, Replica, GeoRestore, and PointInTimeRestore. Defaults to Default. |
| PostgreCreationSrcSrvId | string | null | For creation modes other than Default, the source server ID to use. |
| PostgreRestorePIT | string | null | When create_mode is PointInTimeRestore the point in time to restore from creation_source_server_id. |
| PSQLSubnetId | string | N/A | The ID of the virtual network subnet to create the PostgreSQL Flexible Server. The provided subnet should not have any other resource deployed in it and this subnet will be delegated to the PostgreSQL Flexible Server, if not already delegated. Changing this forces a new PostgreSQL Flexible Server to be created. |
| PSQLPrivateDNSZoneId | string | N/A | The ID of the private dns zone to create the PostgreSQL Flexible Server. Changing this forces a new PostgreSQL Flexible Server to be created. |
| HAMode | string | "ZoneRedundant" | The high availability mode for the PostgreSQL Flexible Server. The only possible value is ZoneRedundant. |
| HAStandbyAZ | string | null | The ID of the private dns zone to create the PostgreSQL Flexible Server. Changing this forces a new PostgreSQL Flexible Server to be created. |
| PostgreZone | string | null | Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located. |
| PostgreSkuName | string | "B_Standard_B1ms" | The SKU Name for the PostgreSQL Flexible Server. The name of the SKU, follows the tier + name pattern (e.g. B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3). |
| PostgreStorage | number | 32768 | The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, and 33554432. |
| PostgreVersion | number | 11 | The version of PostgreSQL Flexible Server to use. Possible values are 11,12 and 13. Required when create_mode is Default. Changing this forces a new PostgreSQL Flexible Server to be created. |
| CustomMaintenanceWindow | bool | false | A booleen used to activate the dynamic block for maintenance windows |
| CustomMaintenanceWindowDay | number | null | The day of week for maintenance window, where the week starts on a Sunday, i.e. Sunday = 0, Monday = 1. Defaults to 0. |
| CustomMaintenanceWindowHour | number | null | The start hour for maintenance window. Defaults to 0 |
| CustomMaintenanceWindowMinute | number | null | The start minute for maintenance window. Defaults to 0. |
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

![Illustration 1](./Img/postgresql01.png)

![Illustration 2](./Img/postgresql02.png)

![Illustration 3](./Img/postgresql03.png)

![Illustration 4](./Img/postgresql04.png)

![Illustration 5](./Img/postgresql05.png)
