
module "psqlflex" {
    source = "../../Terra-AZModuletest/Custom_Modules/PaaS_SRVDB_FlexiblePostgreSql"

    for_each                        = var.TrainingConfig

    RgName                          = azurerm_resource_group.RG[each.key].name
    PostgrePwd                      = "password00Sql"
    TenantId                        = data.azurerm_subscription.current.tenant_id

    PostgreSkuName                  = "GP_Standard_D2s_v3"
    Location                        = var.AzureRegion



}