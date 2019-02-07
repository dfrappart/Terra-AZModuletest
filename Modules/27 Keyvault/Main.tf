######################################################################
# This module create a keyvault resource
######################################################################

#Resource Creation

resource "azurerm_key_vault" "TerraKeyVault" {
  name                = "${lower(var.KeyVaultName)}"
  location            = "${var.KeyVaultLocation}"
  resource_group_name = "${var.KeyVaultRG}"

  sku {
    name = "${var.KeyVaultSKUName}"
  }

  tenant_id = "${var.KeyVaultTenantID}"

  ########################
  #Access Policy 1 for user

  access_policy {
    object_id = "${var.KeyVaultObjectIDPolicy1}"
    tenant_id = "${var.KeyVaultTenantID}"

    #application_id          = "${var.KeyVaultApplicationID}"
    certificate_permissions = ["${var.KeyVaultCertpermlistPolicy1}"]
    key_permissions         = ["${var.KeyVaultKeyPermlistPolicy1}"]
    secret_permissions      = ["${var.KeyVaultSecretPermlistPolicy1}"]
  }

  ########################
  #Access Policy 2 for app

  access_policy {
    object_id = "${var.KeyVaultObjectIDPolicy2}"
    tenant_id = "${var.KeyVaultTenantID}"

    #application_id          = "${var.KeyVaultApplicationID}"
    certificate_permissions = ["${var.KeyVaultCertpermlistPolicy2}"]
    key_permissions         = ["${var.KeyVaultKeyPermlistPolicy2}"]
    secret_permissions      = ["${var.KeyVaultSecretPermlistPolicy2}"]
  }

  ########################
  #Others Keyvault param

  enabled_for_deployment          = "${var.KeyVaultEnabledforDeployment}"
  enabled_for_disk_encryption     = "${var.KeyVaultEnabledforDiskEncrypt}"
  enabled_for_template_deployment = "${var.KeyVaultEnabledforTempDeploy}"

  ########################
  #Tags

    tags {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}


