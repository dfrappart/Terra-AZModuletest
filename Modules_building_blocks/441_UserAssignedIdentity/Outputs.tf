######################################################################
# Output for the UAI
######################################################################


# Module Output

output "FullUAIOutput" {
  value                 = azurerm_user_assigned_identity.terraUAI
  sensitive             = true
}
output "Id" {
  value                 = azurerm_user_assigned_identity.terraUAI.id
  sensitive             = true
}

output "Name" {
  value                 = azurerm_user_assigned_identity.terraUAI.name
  sensitive             = false
}

output "Location" {
  value                 = azurerm_user_assigned_identity.terraUAI.location
  sensitive             = false
}

output "RG" {
  value                 = azurerm_user_assigned_identity.terraUAI.resource_group_name
  sensitive             = false 
}

output "PrincipalId" {
  value                 = azurerm_user_assigned_identity.terraUAI.principal_id
  sensitive             = true

}

output "ClientId" {
  value                 = azurerm_user_assigned_identity.terraUAI.client_id
  sensitive             = true

}

