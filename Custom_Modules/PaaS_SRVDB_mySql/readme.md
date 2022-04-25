# Azure Database for MySQL Module

## Module description

This module deploys a Azure DataBase for MySQL Server.
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
| RGLogName | string | N/A | The name of the RG containing the logs collector objects (sta and log analytics) |
| RGLogName | string | N/A | The name of the RG containing the logs collector objects (sta and log analytics) |
| RGLogLawSubLogNameName | string | N/A | The name of the log analytics workspace containing the logs |
| STASubLogName | string | N/A | The name of the storage account containing the logs |
| mysqlsuffix | string | "-01" | A suffix to be added to the Server resource name |
| MySQLSkuName | string | "GP_Gen5_2" | Specifies the SKU Name for this MySQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8). |
| MySQLVersion | string | "5.7" | Specifies the version of MySQL to use. Valid values are 5.6, 5.7, and 8.0. Changing this forces a new resource to be created. |
| MySQLLogin | string | "sqladmin" | The Administrator Login for the MySQL Server. Required when create_mode is Default. Changing this forces a new resource to be created. |
| MySQLPwd | string | N/A | The Password associated with the administrator_login for the MySQL Server. Required when create_mode is Default. |
| MySQLRetentionDays | string | 35 | Backup retention days for the server, supported values are between 7 and 35 days. |
| MySQLCreateMode | string | null | The creation mode. Can be used to restore or replicate existing servers. Possible values are Default, Replica, GeoRestore, and PointInTimeRestore. Defaults to Default. |
| SRCSRVId | string | null | For creation modes other than Default, the source server ID to use. |
| MySQLGeoRedundantBackup | string | null | Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not supported for the Basic tier. |
| IsInfraEncrypted | string | null | Whether or not infrastructure is encrypted for this server. Defaults to false. Changing this forces a new resource to be created. |
| IsPublicAccessEnabled | string | null | Whether or not public network access is allowed for this server. Defaults to true. |
| RestorePIT | string | null | When create_mode is PointInTimeRestore, specifies the point in time to restore from creation_source_server_id. |
| IsSSLEnforcementEnabled | bool | true | Specifies if SSL should be enforced on connections. Possible values are true and false. |
| TLSVersion | bool | null | The minimum TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLSEnforcementDisabled. |
| MySQLStorageSize | string | 5120 | Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs. For more information see the product documentation. |
| IsThreatDetectionEnabled | bool | true | Is the policy enabled? |
| DisabledThreatAlertList | list | null | Specifies a list of alerts which should be disabled. Possible values include Access_Anomaly, Sql_Injection and Sql_Injection_Vulnerability. |
| EmailAccountAdminEnabled | bool | null | Should the account administrators be emailed when this alert is triggered? |
| ThreatAlertEmail | list | N/A | A list of email addresses which alerts should be sent to |
| ThreatAlertRetentionDays | string | 365 | Specifies the number of days to keep in the Threat Detection audit logs. |
| ThreatAlertTargetStorageKey | string | N/A | Specifies the identifier key of the Threat Detection audit storage account. |
| ThreatAlertTargetEP | string | N/A | Specifies the identifier key of the Threat Detection audit storage account |
| MySQLADAdminObjectId | string | N/A | Specifies the ID of the principal to set as the server administrator |
| MySQLADAdminLogin | string | mysqlaadadmin | The login name of the principal to set as the server administrator |
| MySQLDbList | list | ["defaultdbrws"] | List of MySQL databases names. |
| MySQLDbCharset | string | latin2 | Specifies the Charset for the MySQL Database, which needs to be a valid MySQL Charset. Changing this forces a new resource to be created. |
| MySQLDbCollation | string | latin2_general_ci | Specifies the Collation for the MySQL Database, which needs to be a valid MySQL Collation. Changing this forces a new resource to be created. |
| SubnetIds | list | ["empty"] | List of Subnet Ids to authorize on the MySql Server |
| AllowedPubIPs | list | ["empty"] | Public IP list to allow on Servers |
| ACG1Id | string | N/A | Resource Id of the 1st action group |
| DBLowConnectionThreshold | string | 3 | threshold for Memory server load on DB |
| DBHighConnectionThreshold | string | 200 | threshold for Memory server load on DB |
| DBFailedConnectionThreshold | string | 10 | threshold for failed connection on DB |
| DBStoragePercentHighThreshold | string | 80 | threshold for Storage high threshold on DB |
| DBCPUPercentHighThreshold | string | 80 | threshold for CPU high threshold on DB |
| ResourceOwnerTag | string | That would be me | Tag describing the owner |
| CountryTag | string | fr | Tag describing the Country |
| CostCenterTag | string | rxldefaultcostcenter | Tag describing the Cost Center |
| Company | string | dfitc | The Company owner of the resources |
| Project | string | tflab | The name of the project |
| Environment | string | dev | The environment, dev, prod... |
| ManagedByTag | string | Terraform | Resource provisioner |

### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|
| FullMySQLServerOutput | `azurerm_mysql_server.MySQLServer` | send all the resource information available in the output. In future version, this may be the only output and detailed informtion will probably be queried specifically from the root module |
| ServerName | `azurerm_mysql_server.MySQLServer.name` | The name of the MySQL server |
| SkuName | `azurerm_mysql_server.MySQLServer.name` | The sku name of the MySQL |
| Storage | `azurerm_mysql_server.MySQLServer.storage_mb` | The storage in MB of the MySQL server |
| RetentionDays | `azurerm_mysql_server.MySQLServer.backup_retention_days` | The retention for backup |
| ServerVersion | `azurerm_mysql_server.MySQLServer.version` | The MySQL version |
| SslEnforcementEnabled | `azurerm_mysql_server.MySQLServer.ssl_enforcement_enabled` | Configuration of SSL Enforcement |
| ServerId | `azurerm_mysql_server.MySQLServer.id` | MySQL Server resource Id |
| ServerFQDN | `azurerm_mysql_server.MySQLServer.fqdn` | MySQL Server fqdn |
| DBId | `azurerm_mysql_database.MySQLDB.*.id` | MySQL Database Ids |
| MySQLADADminId | `var.MySQLCreateMode !="Replica" ? azurerm_mysql_active_directory_administrator.MySQLServerADAdmin[0].id : "Not Applicable, Replica Server"` | MySQL AAD Admin Id if applicable |
| MySQLADADminId | `var.MySQLCreateMode !="Replica" ? azurerm_mysql_active_directory_administrator.MySQLServerADAdmin[0].login : "Not Applicable, Replica Server"` | MySQL AAD Admin login if applicable |

## How to call the module

Use as follow:

```bash

# Creating the ResourceGroup

module "ResourceGroup" {

  #Module Location
  source                             = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//003_ResourceGroup/"
  #Module variable
  RGSuffix                           = "-lab-1"
  RGLocation                         = "westeurope"
  ResourceOwnerTag                   = "DFR"
  CountryTag                         = "fr"
  CostCenterTag                      = "labtf"
  EnvironmentTag                     = "dev"

}

# Creating a random string for the root password of mysql

module "PSQLPWD" {
  #Module Location
  source                                  = "../../Modules_building_blocks/002_RandomPassword/"

  #Module variable
  stringlenght                               = 16

}

# Creating a MySQL Server

module "MySQL" {
  source                              = "../../Custom_Modules/PaaS_SRVDB_mySql"

  # Global variables
  Location                            = module.ResourceGroup.RGLocation
  RGName                              = module.ResourceGroup.RGName
  LawId                               = ""
  STAId                               = ""

  # MySQL - Globals
  MySQLSkuName                        = "GP_Gen5_2"
  MySQLVersion                        = "8.0"
  MySQLPwd                            = module.PSQLPWD.Result
  #MySql threat protection
  ThreatAlertEmail                    = [""]
  ThreatAlertTargetStorageKey         = ""
  ThreatAlertTargetEP                 = ""
  
  MySQLADAdminObjectId                = ""
  
  SubnetIds                           = ["/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-cpdp-dev-ldzhub-1/providers/Microsoft.Network/virtualNetworks/vnet-cpdp-dev-ldzhub-1/subnets/sub-cpdp-dev-ldzazadds"]

  # Monitoring

  ACG1Id                              = module.ProjectMonitoringACG.ACGId

  # Tags
    ResourceOwnerTag                  = "DFR"
    CountryTag                        = "fr"
    CostCenterTag                     = "labtf"
    EnvironmentTag                    = "dev"

}

#Action Group for monitoring

module "ProjectMonitoringACG" {

  #Module Location
  source                              = "../../Modules_building_blocks/520_ActionGroup/"

  #Module variable
  acgsuffix                           = 1
  TargetRG                            = module.ResourceGroup.RGName
  ActionGroupContact                  = ""
  TeamChannelAddress                  = ""
  
  ResourceOwnerTag                    = "DFR"
  CountryTag                          = "fr"
  CostCenterTag                       = "labtf"
  EnvironmentTag                      = "dev"


}

```

## Sample display

terraform plan should gives the following output:

```powershell

PS C:\Users\davidfrappart\Documents\IaC\Azure\Terra-AZModuletest\Tests\RG> terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

module.MySQL.data.azurerm_resource_group.RGLogs: Refreshing state...
module.MySQL.data.azurerm_subscription.current: Refreshing state...
module.MySQL.data.azurerm_log_analytics_workspace.LawSubLog: Refreshing state...
module.MySQL.data.azurerm_storage_account.STASubLog: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.MySQL.azurerm_monitor_diagnostic_setting.AzureMSQLDiag will be created
  + resource "azurerm_monitor_diagnostic_setting" "AzureMSQLDiag" {
      + id                         = (known after apply)
      + log_analytics_workspace_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsg-cpdp-dev-subsetup-log/providers/microsoft.operationalinsights/workspaces/law-cpdp-dev-subsetup-log49816259"
      + name                       = "diag-msql-1"
      + storage_account_id         = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-cpdp-dev-subsetup-log/providers/Microsoft.Storage/storageAccounts/stcpdpdev49816259log"
      + target_resource_id         = (known after apply)

      + log {
          + category = "MySqlAuditLogs"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
      + log {
          + category = "MySqlSlowLogs"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }

      + metric {
          + category = "AllMetrics"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
    }

  # module.MySQL.azurerm_monitor_metric_alert.DBCPU will be created
  + resource "azurerm_monitor_metric_alert" "DBCPU" {
      + auto_mitigate            = true
      + description              = "msql-1-DBDBCPUThreshold"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-DBDBCPUThreshold-msql-1-DBDBCPUThreshold"
      + resource_group_name      = "rsg-lab-1"
      + scopes                   = (known after apply)
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "labtf"
          + "Country"       = "fr"
          + "Environment"   = "dev"
          + "ManagedBy"     = "Terraform"
          + "ResourceOwner" = "DFR"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT1M"

      + action {
          + action_group_id = (known after apply)
        }

      + criteria {
          + aggregation      = "Average"
          + metric_name      = "cpu_percent"
          + metric_namespace = "Microsoft.DBforMySQL/servers"
          + operator         = "GreaterThan"
          + threshold        = 80
        }
    }

  # module.MySQL.azurerm_monitor_metric_alert.DBConnectThreshold will be created
  + resource "azurerm_monitor_metric_alert" "DBConnectThreshold" {
      + auto_mitigate            = true
      + description              = "msql-1-DBConnectThreshold"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-DBConnectThreshold-msql-1"
      + resource_group_name      = "rsg-lab-1"
      + scopes                   = (known after apply)
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "labtf"
          + "Country"       = "fr"
          + "Environment"   = "dev"
          + "ManagedBy"     = "Terraform"
          + "ResourceOwner" = "DFR"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT1M"

      + action {
          + action_group_id = (known after apply)
        }

      + criteria {
          + aggregation      = "Average"
          + metric_name      = "active_connections"
          + metric_namespace = "Microsoft.DBforMySQL/servers"
          + operator         = "Equals"
          + threshold        = 3
        }
      + criteria {
          + aggregation      = "Average"
          + metric_name      = "active_connections"
          + metric_namespace = "Microsoft.DBforMySQL/servers"
          + operator         = "GreaterThan"
          + threshold        = 200
        }
      + criteria {
          + aggregation      = "Total"
          + metric_name      = "connections_failed"
          + metric_namespace = "Microsoft.DBforMySQL/servers"
          + operator         = "GreaterThan"
          + threshold        = 10
        }
    }

  # module.MySQL.azurerm_monitor_metric_alert.DBStorage will be created
  + resource "azurerm_monitor_metric_alert" "DBStorage" {
      + auto_mitigate            = true
      + description              = "msql-1-DBStorageThreshold"
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "malt-DBStorageThreshold-msql-1"
      + resource_group_name      = "rsg-lab-1"
      + scopes                   = (known after apply)
      + severity                 = 3
      + tags                     = {
          + "CostCenter"    = "labtf"
          + "Country"       = "fr"
          + "Environment"   = "dev"
          + "ManagedBy"     = "Terraform"
          + "ResourceOwner" = "DFR"
        }
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT1M"

      + action {
          + action_group_id = (known after apply)
        }

      + criteria {
          + aggregation      = "Average"
          + metric_name      = "storage_percent"
          + metric_namespace = "Microsoft.DBforMySQL/servers"
          + operator         = "GreaterThan"
          + threshold        = 80
        }
    }

  # module.MySQL.azurerm_mysql_active_directory_administrator.MySQLServerADAdmin will be created
  + resource "azurerm_mysql_active_directory_administrator" "MySQLServerADAdmin" {
      + id                  = (known after apply)
      + login               = "mysqlaadadmin"
      + object_id           = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      + resource_group_name = "rsg-lab-1"
      + server_name         = "msql-1"
      + tenant_id           = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    }

  # module.MySQL.azurerm_mysql_database.MySQLDB[0] will be created
  + resource "azurerm_mysql_database" "MySQLDB" {
      + charset             = "latin2"
      + collation           = "latin2_general_ci"
      + id                  = (known after apply)
      + name                = "mysql-db-1-defaultdbrws"
      + resource_group_name = "rsg-lab-1"
      + server_name         = "msql-1"
    }

  # module.MySQL.azurerm_mysql_server.MySQLServer will be created
  + resource "azurerm_mysql_server" "MySQLServer" {
      + administrator_login              = "dbadmin"
      + administrator_login_password     = (sensitive value)
      + auto_grow_enabled                = (known after apply)
      + backup_retention_days            = 35
      + create_mode                      = "Default"
      + fqdn                             = (known after apply)
      + geo_redundant_backup_enabled     = (known after apply)
      + id                               = (known after apply)
      + location                         = "westeurope"
      + name                             = "msql-1"
      + public_network_access_enabled    = true
      + resource_group_name              = "rsg-lab-1"
      + sku_name                         = "GP_Gen5_2"
      + ssl_enforcement                  = (known after apply)
      + ssl_enforcement_enabled          = true
      + ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"
      + storage_mb                       = 5120
      + tags                             = {
          + "CostCenter"    = "labtf"
          + "Country"       = "fr"
          + "Environment"   = "dev"
          + "ManagedBy"     = "Terraform"
          + "ResourceOwner" = "DFR"
        }
      + version                          = "8.0"

      + storage_profile {
          + auto_grow             = (known after apply)
          + backup_retention_days = (known after apply)
          + geo_redundant_backup  = (known after apply)
          + storage_mb            = (known after apply)
        }

      + threat_detection_policy {
          + email_addresses            = [
              + "david@teknews.cloud",
            ]
          + enabled                    = true
          + retention_days             = 365
          + storage_account_access_key = (sensitive value)
          + storage_endpoint           = "https://stxxxxxlog.blob.core.windows.net/"
        }
    }

  # module.MySQL.azurerm_mysql_virtual_network_rule.MySQLServerVNetRule[0] will be created
  + resource "azurerm_mysql_virtual_network_rule" "MySQLServerVNetRule" {
      + id                  = (known after apply)
      + name                = "mysql-vnrul-1-0"
      + resource_group_name = "rsg-lab-1"
      + server_name         = "msql-1"
      + subnet_id           = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-cpdp-dev-ldzhub-1/providers/Microsoft.Network/virtualNetworks/vnet-cpdp-dev-ldzhub-1/subnets/sub-cpdp-dev-ldzazadds"
    }

  # module.PSQLPWD.random_password.TerraRandomPWD will be created
  + resource "random_password" "TerraRandomPWD" {
      + id          = (known after apply)
      + length      = 16
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + result      = (sensitive value)
      + special     = true
      + upper       = true
    }

  # module.ProjectMonitoringACG.azurerm_monitor_action_group.TerraActionGroup will be created
  + resource "azurerm_monitor_action_group" "TerraActionGroup" {
      + enabled             = true
      + id                  = (known after apply)
      + name                = "acg-1"
      + resource_group_name = "rsg-lab-1"
      + short_name          = "acg1"
      + tags                = {
          + "CostCenter"    = "labtf"
          + "Country"       = "fr"
          + "Environment"   = "dev"
          + "ManagedBy"     = "Terraform"
          + "ResourceOwner" = "DFR"
        }

      + email_receiver {
          + email_address = ""
          + name          = "senttosubcontactlist"
        }
      + email_receiver {
          + email_address = ""
          + name          = "senttoteams"
        }
    }

  # module.ResourceGroup.azurerm_resource_group.TerraRG will be created
  + resource "azurerm_resource_group" "TerraRG" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "rsg-lab-1"
      + tags     = {
          + "CostCenter"    = "labtf"
          + "Country"       = "fr"
          + "Environment"   = "dev"
          + "ManagedBy"     = "Terraform"
          + "ResourceOwner" = "DFR"
        }
    }

Plan: 11 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

output should be similar to this:

```powershell

Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

Outputs:

DBId = <sensitive>
MySQLADADminId = <sensitive>
MySQLADADminLogin = mysqlaadadmin
RGId = <sensitive>
RGLocation = westeurope
RGName = rsg-lab-1
RetentionDays = 35
ServerFQDN = msql-1.mysql.database.azure.com
ServerId = <sensitive>
ServerName = msql-1
ServerVersion = 8.0
SkuName = GP_Gen5_2
SslEnforcementEnabled = true
Storage = 5120

```

## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/mysql01.png)

![Illustration 2](./Img/mysql02.png)

![Illustration 3](./Img/mysql03.png)

![Illustration 4](./Img/mysql04.png)

![Illustration 5](./Img/mysql05.png)
