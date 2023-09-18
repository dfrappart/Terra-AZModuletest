##############################################################
#Output for AppGW module

# Full output agw

output "AppGW" {
  value                   = azurerm_application_gateway.AGW
  sensitive               = true
}

# resource Id output

output "AppGW_Id" {
  value                   = azurerm_application_gateway.AGW.id
  sensitive               = true
}

#BE Pool Outputs

output "AppGW_BEPool" {
  value                   = azurerm_application_gateway.AGW.backend_address_pool
  sensitive               = true
}

output "AppGW_BEPoolId" {
  value                   = azurerm_application_gateway.AGW.backend_address_pool[*].id
  sensitive               = true
}

# Full output agw uai

output "AppGWUAI" {
  value                   = azurerm_user_assigned_identity.AppGatewayManagedId
  sensitive               = true
}

# Full output agw uai access policy onkv

output "AppGWUAIKV_AccessPolicy" {
  value                   = azurerm_key_vault_access_policy.KeyVaultAccessPolicy01
  sensitive               = true
}

# Full output agw pub ip

output "AppGWPubIP" {
  value                   = azurerm_public_ip.AppGWPIP
}

# Full output agw pub ip diag
/*
output "AppGWPubIPDiag" {
  value                   = azurerm_monitor_diagnostic_setting.AppGWPIPDiag
}

# Full output agw pub ip diag

output "AppGWDiag" {
  value                   = azurerm_monitor_diagnostic_setting.AppGWDiag
}*/

output "pubipdiag" {
  value = data.azurerm_monitor_diagnostic_categories.AgwPubIP
}