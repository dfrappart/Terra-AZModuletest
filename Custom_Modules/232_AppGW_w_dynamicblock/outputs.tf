##############################################################
#Output for AppGW module

# Full output agw

output "AppGW" {
    value = azurerm_application_gateway.SpokeAppGW
}

# resource Id output

output "AppGW_Id" {
  value = azurerm_application_gateway.SpokeAppGW.id
}

#BE Pool Outputs

output "AppGW_BEPool" {
  value = azurerm_application_gateway.SpokeAppGW.backend_address_pool
}

output "AppGW_BEPoolId" {
  value = azurerm_application_gateway.SpokeAppGW.backend_address_pool[*].id
}

# Full output agw uai

output "AppGWUAI" {
  value = azurerm_user_assigned_identity.AppGatewayManagedId
}

# Full output agw uai access policy onkv

output "AppGWUAIKV_AccessPolicy" {
  value = azurerm_key_vault_access_policy.KeyVaultAccessPolicy01
}

# Full output agw pub ip

output "AppGWPubIP" {
  value = azurerm_public_ip.AppGWPIP
}

# Full output agw pub ip diag

output "AppGWPubIPDiag" {
  value = azurerm_monitor_diagnostic_setting.AppGWPIPDiag
}

# Full output agw pub ip diag

output "AppGWDiag" {
  value = azurerm_monitor_diagnostic_setting.AppGWDiag
}