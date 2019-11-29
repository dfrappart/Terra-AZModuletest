######################################################################
# This module create a keyvault resource
######################################################################

#KeyVault Creation


resource "azurerm_key_vault" "TerraKeyVault" {
  name                = var.KeyVaultName
  location            = var.KeyVaultLocation
  resource_group_name = var.KeyVaultRGName
  sku_name            = var.KeyVaultSKUName
  tenant_id           = var.KeyVaultTenantID




  ########################
  #Others Keyvault param

  enabled_for_deployment          = var.KeyVaultEnabledforDeployment
  enabled_for_disk_encryption     = var.KeyVaultEnabledforDiskEncrypt
  enabled_for_template_deployment = var.KeyVaultEnabledforTempDeploy

  ########################
  #Tags

    tags = {
      application       = var.applicationTag
      costcenter        = var.costcenterTag
      businessunit      = var.businessunitTag
      managedby         = var.managedbyTag
      environvment      = var.environmentTag
      hostname          = var.hostnameTag
      owner             = var.ownerTag
      role              = var.keyvaultRole
      createdby         = var.createdbyTag
    }
}

