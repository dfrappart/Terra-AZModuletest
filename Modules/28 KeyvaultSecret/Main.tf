######################################################################
# This module create a keyvault resource
######################################################################



#Resource Creation

resource "azurerm_key_vault_secret" "TerraSecret" {
  name      = "${var.PasswordName}"
  value     = "${var.PasswordValue}"
  vault_uri = "${var.VaultURI}"

    tags {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}

