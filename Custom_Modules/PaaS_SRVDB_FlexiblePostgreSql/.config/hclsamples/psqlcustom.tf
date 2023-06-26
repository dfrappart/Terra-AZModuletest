module "psqlflex" {

  source = ""

    RgName                          = azurerm_resource_group.RG.name                                #
    PostgrePwd                      = var.PostgreSQLPWD                                             # The local admin password of the server
    PostgreSkuName                  = "GP_Standard_D2s_v3"                                          #
    Location                        = var.AzureRegion                                               #
    IsAadAdminEnabled               = true                                                          #
    TenantId                        = data.azurerm_subscription.current.tenant_id                   # Reference the AAD tenant Id to identify the group assigned to the admin role
    PsqlAdminGroupObjectId          = var.PsqlAADAdminObjectId                                      # An object Id (GUID) of an Azure AD group assigned to the addmin role

    PSQLPrivateDNSZoneId            = var.dnszoneid                                                 # The DNS zone resource ID for the psql servers. Note that if not specified, a DNS zone is created by default
    PSQLSubnetId                    = var.psqlsubnetid                                              # The Subnet Id targeted to host the server. If not specified, the module creates a dedicated VNet and subnet.

}