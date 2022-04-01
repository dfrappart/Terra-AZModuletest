# Storage Account module

## Module description

This module deploys a storage account.

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| STASuffix | string | N/A | a suffix to add at the end of the storage account name |
| RGName | string | N/A | TThe name of the resource group in which to create the storage account. Changing this forces a new resource to be created. |
| StorageAccountLocation | string | N/A | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| StorageAccountTier | string | Standard | Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. |
| StorageReplicationType | string | LRS | "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. |
| StorageAccessTier | string | null | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot. |
| HTTPSSetting | string | true | Boolean flag which forces HTTPS if enabled, see here for more information. Defaults to true. |
| TLSVer | string | TLS1_2 | The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. |
| DefaultTags | map | See `Variables.tf` | A map used to define default tags. |
| ExtraTags | map | {} | A map to add custom tags |
| LogCategories | map | See `Variables.tf` | A map used to define log categories in diagnostic settings |
| MetricCategories | map | See `Variables.tf` | A map used to define log categories in diagnostic settings |
| AllowedIPList | list | [] | List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed. |
| AllowedSubnetIdList | list | [] | A list of virtual network subnet ids to to secure the storage account. |
| ByPassConfig | list |  ["Logging","Metrics"] | Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None. |
  
### Module outputs
  
| Output name | value | Description |
|:------------|:------|:------------|
| STAFull | `azurerm_storage_account.STOA` | send all the resource information available in the output. In future version, this may be the only output and detailed informtion will probably be queried specifically from the root module |
| Name | `azurerm_storage_account.STOA.name` | The resource name |
| Id | `azurerm_storage_account.STOA.id` | The resource Id |
| PrimaryBlobEP | `azurerm_storage_account.STOA.primary_blob_endpoint` | The primary Blob Endpoint |
| PrimaryQueueEP | `azurerm_storage_account.STOA.primary_queue_endpoint` | The primary Queue Endpoint |
| PrimaryTableEP | `azurerm_storage_account.STOA.primary_table_endpoint` | The primary Table Endpoint |
| PrimaryFileEP | `azurerm_storage_account.STOA.primary_file_endpoint` | The primary File Endpoint |
| PrimaryAccessKey | `azurerm_storage_account.STOA.primary_access_key` | The primary access key |
| SecondaryAccessKey | `azurerm_storage_account.STOA.secondary_access_key` | The secondary access key |
| ConnectionURI | `azurerm_storage_account.STOA.primary_blob_connection_string` | The blob connection string |
| RGName | `azurerm_storage_account.STOA.resource_group_name` | The resource group containing the sta |

## How to call the module
  
Use as follow:

```bash

# Creating the STA

module "STA" {

  #Module Location
  source                                = "github.com/dfrappart/Terra-AZModuletest/Modules_building_blocks/101_StorageAccountGP"
  #Module variable    
  STASuffix                             = var.ResourcesSuffix
  RGName                                = module.ResourceGroup[1].RGName
  StorageAccountLocation                = var.AzureRegion
  DefaultTags                           = var.DefaultTags
  LawLogId                              = data.azurerm_log_analytics_workspace.LAWLog.id
  STALogId                              = data.azurerm_storage_account.STALog.id

}



```

## Sample display

terraform plan should gives the following output:

```powershell

PS C:\Users\jubei.yagyu> terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # module.STA1.azurerm_monitor_diagnostic_setting.STADiag_ToLAW[0] will be created
  + resource "azurerm_monitor_diagnostic_setting" "STADiag_ToLAW" {
      + id                         = (known after apply)
      + log_analytics_workspace_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rsg-fr-poc-taflog/providers/Microsoft.OperationalInsights/workspaces/law-fr-poc-taflog00000000"
      + name                       = "sttafdiag"
      + target_resource_id         = (known after apply)

      + metric {
          + category = "Transaction"
          + enabled  = false
        }
    }

  # module.STA1.azurerm_monitor_diagnostic_setting.STADiag_ToSTA[0] will be created
  + resource "azurerm_monitor_diagnostic_setting" "STADiag_ToSTA" {
      + id                 = (known after apply)
      + name               = "sttafdiag"
      + storage_account_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rsg-fr-poc-taflog/providers/Microsoft.Storage/storageAccounts/stfrpoc00000000taflog"
      + target_resource_id = (known after apply)

      + metric {
          + category = "Transaction"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
    }

  # module.STA1.azurerm_storage_account.STOA will be created
  + resource "azurerm_storage_account" "STOA" {
      + access_tier                       = (known after apply)
      + account_kind                      = "StorageV2"
      + account_replication_type          = "LRS"
      + account_tier                      = "Standard"
      + allow_nested_items_to_be_public   = true
      + enable_https_traffic_only         = true
      + id                                = (known after apply)
      + infrastructure_encryption_enabled = false
      + is_hns_enabled                    = false
      + large_file_share_enabled          = (known after apply)
      + location                          = "francecentral"
      + min_tls_version                   = "TLS1_2"
      + name                              = "sttaf"
      + nfsv3_enabled                     = false
      + primary_access_key                = (sensitive value)
      + primary_blob_connection_string    = (sensitive value)
      + primary_blob_endpoint             = (known after apply)
      + primary_blob_host                 = (known after apply)
      + primary_connection_string         = (sensitive value)
      + primary_dfs_endpoint              = (known after apply)
      + primary_dfs_host                  = (known after apply)
      + primary_file_endpoint             = (known after apply)
      + primary_file_host                 = (known after apply)
      + primary_location                  = (known after apply)
      + primary_queue_endpoint            = (known after apply)
      + primary_queue_host                = (known after apply)
      + primary_table_endpoint            = (known after apply)
      + primary_table_host                = (known after apply)
      + primary_web_endpoint              = (known after apply)
      + primary_web_host                  = (known after apply)
      + queue_encryption_key_type         = "Service"
      + resource_group_name               = "rsgtafcptdata"
      + secondary_access_key              = (sensitive value)
      + secondary_blob_connection_string  = (sensitive value)
      + secondary_blob_endpoint           = (known after apply)
      + secondary_blob_host               = (known after apply)
      + secondary_connection_string       = (sensitive value)
      + secondary_dfs_endpoint            = (known after apply)
      + secondary_dfs_host                = (known after apply)
      + secondary_file_endpoint           = (known after apply)
      + secondary_file_host               = (known after apply)
      + secondary_location                = (known after apply)
      + secondary_queue_endpoint          = (known after apply)
      + secondary_queue_host              = (known after apply)
      + secondary_table_endpoint          = (known after apply)
      + secondary_table_host              = (known after apply)
      + secondary_web_endpoint            = (known after apply)
      + secondary_web_host                = (known after apply)
      + shared_access_key_enabled         = true
      + table_encryption_key_type         = "Service"
      + tags                              = {
          + "CostCenter"    = "taf"
          + "Country"       = "fr"
          + "Environment"   = "dev"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "taf"
          + "ResourceOwner" = "That would be me"
        }

      + blob_properties {
          + change_feed_enabled      = (known after apply)
          + default_service_version  = (known after apply)
          + last_access_time_enabled = (known after apply)
          + versioning_enabled       = (known after apply)

          + container_delete_retention_policy {
              + days = (known after apply)
            }

          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + delete_retention_policy {
              + days = (known after apply)
            }
        }

      + network_rules {
          + bypass                     = (known after apply)
          + default_action             = (known after apply)
          + ip_rules                   = (known after apply)
          + virtual_network_subnet_ids = (known after apply)

          + private_link_access {
              + endpoint_resource_id = (known after apply)
              + endpoint_tenant_id   = (known after apply)
            }
        }

      + queue_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + hour_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }

          + logging {
              + delete                = (known after apply)
              + read                  = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
              + write                 = (known after apply)
            }

          + minute_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }
        }

      + routing {
          + choice                      = (known after apply)
          + publish_internet_endpoints  = (known after apply)
          + publish_microsoft_endpoints = (known after apply)
        }

      + share_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + retention_policy {
              + days = (known after apply)
            }

          + smb {
              + authentication_types            = (known after apply)
              + channel_encryption_type         = (known after apply)
              + kerberos_ticket_encryption_type = (known after apply)
              + versions                        = (known after apply)
            }
        }
    }

  # module.STA1.azurerm_storage_account_network_rules.STANTWDefaultRule will be created
  + resource "azurerm_storage_account_network_rules" "STANTWDefaultRule" {
      + bypass                     = [
          + "Logging",
          + "Metrics",
        ]
      + default_action             = "Deny"
      + id                         = (known after apply)
      + ip_rules                   = (known after apply)
      + storage_account_id         = (known after apply)
      + virtual_network_subnet_ids = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + STAFull = (sensitive value)
  + STAId   = (sensitive value)
  + STAName = (sensitive value)

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/STA001.png)
