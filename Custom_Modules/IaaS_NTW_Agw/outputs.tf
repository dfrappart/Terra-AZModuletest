##############################################################
#Output for AppGW module

# Full output agw

output "AppGw" {
  value       = azurerm_application_gateway.AGW
  sensitive   = true
  description = "The full Agw module output"
}

# resource Id output

output "AppGw_Id" {
  value       = azurerm_application_gateway.AGW.id
  sensitive   = true
  description = "The Application Gateway Id"

}

#BE Pool Outputs

output "AppGW_BEPool" {
  value       = azurerm_application_gateway.AGW.backend_address_pool
  sensitive   = true
  description = "The Application Gateway backend address pools"
}

output "AppGW_BEPoolId" {
  value       = azurerm_application_gateway.AGW.backend_address_pool[*].id
  sensitive   = true
  description = "The Application Gateway backend pool ids"
}

# Full output agw uai

output "AppGWUAI" {
  value       = azurerm_user_assigned_identity.AppGatewayManagedId
  sensitive   = true
  description = "The Agw User Assign Identity full output"
}

# Full output agw uai access policy onkv
/*
output "AppGWUAIKV_AccessPolicy" {
  value       = azurerm_key_vault_access_policy.KeyVaultAccessPolicy01
  sensitive   = true
  description = "The Agw Key Vault full output"
}
*/
# Full output agw pub ip

output "AppGWPubIP" {
  value       = azurerm_public_ip.AppGWPIP
  description = "The Pub Ip full output"
}

# Full output agw pub ip diag

output "AgwWPubIpDiagConfig" {
  value       = azurerm_monitor_diagnostic_setting.PubIpAgwDiagSettings
  description = "The Diagnostic settings configuration for the Agw public Ip"
}

# Full output agw pub ip diag

output "AgwDiagConfig" {
  value       = azurerm_monitor_diagnostic_setting.AgwDiagSettings
  description = "The diagnostic settings configuration for the Agw"
}

output "PubIpDiagInfo" {
  value       = data.azurerm_monitor_diagnostic_categories.AgwPubIP
  description = "The list of diagnostic settings categories available for the Agw Public Ip"
}

output "AgwDiagInfo" {
  value       = data.azurerm_monitor_diagnostic_categories.Agw
  description = "the list of diagnistic settings categories available for the Agw"
}