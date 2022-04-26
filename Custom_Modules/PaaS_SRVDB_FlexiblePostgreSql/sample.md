# Azure Database for PostgresSQL Flexible Module
  
## How to call the module

Use as follow:

```bash



```

## Sample display

terraform plan should gives the following output:

```powershell

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.psqlflex.azurerm_monitor_diagnostic_setting.AzurePSQLDiagToLAWA[0] will be created
  + resource "azurerm_monitor_diagnostic_setting" "AzurePSQLDiagToLAWA" {
      + id                         = (known after apply)
      + log_analytics_workspace_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rsg-dffr-lab-subsetupconsulconslog/providers/Microsoft.OperationalInsights/workspaces/law-dffr-lab-subsetupconsulconslog16e85b36"       
      + name                       = "mon-psql-diag-to-Law-1"
      + target_resource_id         = (known after apply)

      + log {
          + category = "PostgreSQLLogs"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }

      + metric {
          + category = "AllMetrics"
          + enabled  = false
        }
    }

  # module.psqlflex.azurerm_monitor_diagnostic_setting.AzurePSQLDiagToSTA[0] will be created
  + resource "azurerm_monitor_diagnostic_setting" "AzurePSQLDiagToSTA" {
      + id                 = (known after apply)
      + name               = "mon-psql-diag-to-STA-1"
      + storage_account_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rsg-dffr-lab-subsetupconsulconslog/providers/Microsoft.Storage/storageAccounts/stdffrlab16e85b36conslog"
      + target_resource_id = (known after apply)

      + log {
          + category = "PostgreSQLLogs"
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

  # module.psqlflex.azurerm_postgresql_flexible_server.PostGreSQLFlexServer will be created
  + resource "azurerm_postgresql_flexible_server" "PostGreSQLFlexServer" {
      + administrator_login           = "sqladmin"
      + administrator_password        = (sensitive value)
      + backup_retention_days         = 7
      + create_mode                   = "Default"
      + delegated_subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rsg-consul-spkaks/providers/Microsoft.Network/virtualNetworks/psqlflexiblentw/subnets/psqlsubnet"
      + fqdn                          = (known after apply)
      + geo_redundant_backup_enabled  = false
      + id                            = (known after apply)
      + location                      = "westeurope"
      + name                          = "psql-flex1"
      + private_dns_zone_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rsg-consul-spkaks/providers/Microsoft.Network/privateDnsZones/dfrpsqltest.postgres.database.azure.com"
      + public_network_access_enabled = (known after apply)
      + resource_group_name           = "rsg-consul-data"
      + sku_name                      = "GP_Standard_D4s_v3"
      + storage_mb                    = 32768
      + tags                          = {
          + "CostCenter"    = "labtf"
          + "Country"       = "fr"
          + "Environment"   = "lab"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "tfmodule"
          + "ResourceOwner" = "That would be me"
        }
      + version                       = "11"

      + high_availability {
          + mode = "ZoneRedundant"
        }
    }

Plan: 3 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.

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
