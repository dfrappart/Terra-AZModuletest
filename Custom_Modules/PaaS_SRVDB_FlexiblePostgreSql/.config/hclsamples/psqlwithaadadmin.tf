
module "psqlflex" {
    source = "../../Terra-AZModuletest/Custom_Modules/PaaS_SRVDB_FlexiblePostgreSql"

    
    RgName                          = azurerm_resource_group.RG.name                                #
    PostgrePwd                      = var.PostgreSQLPWD                                             # The local admin password of the server
    PostgreSkuName                  = "GP_Standard_D2s_v3"                                          #
    Location                        = var.AzureRegion                                               #
    IsAadAdminEnabled               = true                                                          #
    TenantId                        = data.azurerm_subscription.current.tenant_id                   # Reference the AAD tenant Id to identify the group assigned to the admin role
    PsqlAdminGroupObjectId          = var.PsqlAADAdminObjectId                                      # An object Id (GUID) of an Azure AD group assigned to the addmin role


}