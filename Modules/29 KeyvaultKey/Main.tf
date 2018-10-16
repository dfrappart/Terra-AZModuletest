######################################################################
# This module create a keyvault resource
######################################################################



#Resource Creation

resource "azurerm_key_vault_key" "TerraKey" {
  name      = "${var.KeyName}"
  vault_uri = "${var.VaultURI}"
  key_type = "${var.KeyType}"
  key_size = "${var.KeySize}"

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

