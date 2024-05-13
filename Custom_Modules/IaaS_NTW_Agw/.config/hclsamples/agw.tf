######################################################################
# Creating an Application Gateway

locals {

  SitesConf = {
    "Site 1" = {
      SiteIdentifier                                = data.azurerm_key_vault_certificate.akscert.name 
      AppGWSSLCertNameSite                          = data.azurerm_key_vault_certificate.akscert.name 
      AppGwPublicCertificateSecretIdentifierSite    = data.azurerm_key_vault_secret.akscertsecret.id
      HostnameSite                                  = "aks.teknews.cloud"
      RoutingRulePriority                           = 1
    }
  }
}


module "AGW" {

  for_each = var.TrainingConfig
  source                                        = "../../Terra-AZModuletest/Custom_Modules/232_AppGW_w_dynamicblock"

  TargetRG                                      = azurerm_resource_group.RG[each.key].name
  TargetLocation                                = azurerm_resource_group.RG[each.key].location
  LawSubLogId                                   = data.azurerm_log_analytics_workspace.monitorlaw.id
  STASubLogId                                   = data.azurerm_storage_account.STALog.id
  TargetSubnetId                                = azurerm_subnet.subnetagic[each.key].id
  KVId                                          = data.azurerm_key_vault.SharedKv.id
  SitesConf                                     = local.SitesConf
  AGWSuffix                                     = "agw${each.key}"
  TargetSubnetAddressPrefix                     = azurerm_subnet.subnetagic[each.key].address_prefixes[0]



}