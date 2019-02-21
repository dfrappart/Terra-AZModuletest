######################################################################
# This module create a keyvault resource
######################################################################



#Resource Creation

resource "azurerm_key_vault_secret" "TerraSecret" {
  name          = "${var.PasswordName}"
  value         = "${var.PasswordValue}"
  key_vault_id  = "${var.KeyVaultId}"

    tags {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}

