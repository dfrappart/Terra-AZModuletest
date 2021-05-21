######################################################################
# This module create a RBAC Builtin assignment
######################################################################


#Module Outputs

output "CustomRoleFull" {
  value           = azurerm_role_definition.CustomRBACRole
  sensitive       = true
}
output "CustomRoleGuid" {
  value           = azurerm_role_definition.CustomRBACRole.role_definition_id
  sensitive       = true
}

output "CustomRoleName" {
  value           = azurerm_role_definition.CustomRBACRole.name
  sensitive       = true
}

output "CustomRolePermissions" {
  value           = azurerm_role_definition.CustomRBACRole.permisions
  sensitive       = true
}

output "CustomRolePermissionsJson" {
  value           = jsonencore(azurerm_role_definition.CustomRBACRole.permisions)
  sensitive       = true
}

output "CustomRoleScope" {
  value           = azurerm_role_definition.CustomRBACRole.assignable_scopes
  sensitive       = true
}

output "CustomRoleRoleDefinitionResourceId" {
  value           = azurerm_role_definition.CustomRBACRole.role_definition_resource_id
  sensitive       = true
}

output "CustomRoleRoleId" {
  value           = azurerm_role_definition.CustomRBACRole.id
  sensitive       = true
}