######################################################################
# This module create a RBAC Builtin assignment
######################################################################


#Module Outputs

output "RBACAssignmentFull" {
  value           = azurerm_role_assignment.TerraAssignedBuiltin
  sensitive       = true
}
output "RBACAssignmentGuid" {
  value           = azurerm_role_assignment.TerraAssignedBuiltin.name
}

output "RBACAssignmentScope" {
  value           = azurerm_role_assignment.TerraAssignedBuiltin.scope
}

output "RBACAssignmentRoleName" {
  value           = azurerm_role_assignment.TerraAssignedBuiltin.role_definition_name
}

output "RBACAssignmentPrincipalId" {
  value           = azurerm_role_assignment.TerraAssignedBuiltin.principal_id
  sensitive       = true
}

output "RBACAssignmentId" {
  value           = azurerm_role_assignment.TerraAssignedBuiltin.id
}

output "RBACAssignmentPrincipalType" {
  value           = azurerm_role_assignment.TerraAssignedBuiltin.principal_type
}