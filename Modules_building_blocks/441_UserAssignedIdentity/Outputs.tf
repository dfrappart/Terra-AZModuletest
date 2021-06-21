######################################################################
# Output for the UAI
######################################################################


# Module Output

output "FullUAIOutput" {
  value                 = azurerm_user_assigned_identity.UAI
  sensitive             = true
}
output "Id" {
  value                 = azurerm_user_assigned_identity.UAI.id
  sensitive             = true
}

output "Name" {
  value                 = azurerm_user_assigned_identity.UAI.name
  sensitive             = false
}

output "Location" {
  value                 = azurerm_user_assigned_identity.UAI.location
  sensitive             = false
}

output "RG" {
  value                 = azurerm_user_assigned_identity.UAI.resource_group_name
  sensitive             = false 
}

output "PrincipalId" {
  value                 = azurerm_user_assigned_identity.UAI.principal_id
  sensitive             = true

}

output "ClientId" {
  value                 = azurerm_user_assigned_identity.UAI.client_id
  sensitive             = true

}

