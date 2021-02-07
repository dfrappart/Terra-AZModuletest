######################################################################
# This module create a keyvault resource
######################################################################

#Resource Creation

resource "azurerm_key_vault" "TerraKeyVault" {

  lifecycle {
    ignore_changes                        = [
      
      name

    ]
  }

  name                                      = "akv${lower(var.KeyVaultSuffix)}"
  location                                  = var.TargetLocation
  resource_group_name                       = var.TargetRG

  sku_name                                  = var.KeyVaultSKUName
  tenant_id                                 = var.KeyVaultTenantID

  enable_rbac_authorization                 = var.IsKVEnabledForRBAC
  purge_protection_enabled                  = var.IsKVPurgeProtectEnabled
  soft_delete_retention_days                = var.KVSoftDeleteRetention


  ########################
  #Others Keyvault param

  enabled_for_deployment                    = var.KeyVaultEnabledforDeployment
  enabled_for_disk_encryption               = var.KeyVaultEnabledforDiskEncrypt
  enabled_for_template_deployment           = var.KeyVaultEnabledforTempDeploy

  ########################
  #Tags

    tags = {
        ResourceOwner                       = var.ResourceOwnerTag
        Country                             = var.CountryTag
        CostCenter                          = var.CostCenterTag
        Environment                         = var.Environment
        Project                             = var.Project
        ManagedBy                           = "Terraform"
    }
}


resource "azurerm_monitor_diagnostic_setting" "KVDiag" {
  name                                  = "${azurerm_key_vault.TerraKeyVault.name}diag"
  target_resource_id                    = azurerm_key_vault.TerraKeyVault.id
  storage_account_id                    = var.STASubLogId
  log_analytics_workspace_id            = var.LawSubLogId

  log {
    category                            = "AuditEvent"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  metric {
    category                            = "AllMetrics"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    }    

  }

}

