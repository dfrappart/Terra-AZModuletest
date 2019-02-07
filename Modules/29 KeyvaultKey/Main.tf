######################################################################
# This module create a keyvault resource
######################################################################



#Resource Creation

resource "azurerm_key_vault_key" "TerraKey" {
  name      = "${var.KeyName}"
  vault_uri = "${var.VaultURI}"
  key_type = "${var.KeyType}"
  key_size = "${var.KeySize}"
  key_opts  = "${var.KeyOpts}"

    tags {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}

