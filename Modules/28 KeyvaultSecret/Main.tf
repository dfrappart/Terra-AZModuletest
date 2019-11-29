######################################################################
# This module create a keyvault resource
######################################################################



#Resource Creation

resource "azurerm_key_vault_secret" "TerraSecret" {
  name          = var.PasswordName
  value         = var.PasswordValue
  key_vault_id  = var.KeyVaultId

    tags = {
      applicationTag            = var.applicationTag
      costcenterTag             = var.costcenterTag
      businessunitTag           = var.businessunitTag
      managedbyTag              = var.managedbyTag
      environmentTag            = var.environmentTag
      hostnameTag               = var.hostnameTag
      ownerTag                  = var.ownerTag
      roleTag                   = var.roleTag
      createdbyTag              = var.createdbyTag
    }
}