
###################################################################################
#Creating AG User Assigned Managed identity

resource "azurerm_user_assigned_identity" "AppGatewayManagedId" {
  resource_group_name = local.RgName
  location            = var.TargetLocation
  name                = "uai-agw${var.AGWSuffix}"

  tags = local.Tags
}

#Creating access policy for uai

resource "azurerm_key_vault_access_policy" "KeyVaultAccessPolicy01" {
  key_vault_id = var.KVId
  tenant_id    = data.azurerm_subscription.current.tenant_id
  object_id    = azurerm_user_assigned_identity.AppGatewayManagedId.principal_id
  certificate_permissions = [
    "Get",
    "List",
  ]
  key_permissions = []
  secret_permissions = [
    "Get",
    "List",
  ]
}