##############################################################
#module outputs
##############################################################

######################################################################
# Output for the UAI
######################################################################


# Module Output

output "FullUAIOutput" {
  value     = azurerm_user_assigned_identity.terraUAI
  sensitive = true
}
output "Id" {
  value     = azurerm_user_assigned_identity.terraUAI.id
  sensitive = true
}

output "Name" {
  value     = azurerm_user_assigned_identity.terraUAI.name
  sensitive = false
}

output "Location" {
  value     = azurerm_user_assigned_identity.terraUAI.location
  sensitive = false
}

output "RG" {
  value     = azurerm_user_assigned_identity.terraUAI.resource_group_name
  sensitive = false
}

output "PrincipalId" {
  value     = azurerm_user_assigned_identity.terraUAI.principal_id
  sensitive = true

}

output "ClientId" {
  value     = azurerm_user_assigned_identity.terraUAI.client_id
  sensitive = true

}

######################################################################
# Output RBAC Builtin assignment
######################################################################


output "RBACAssignmentFull" {
  value     = azurerm_role_assignment.TerraAssignedBuiltin
  sensitive = true
}
output "RBACAssignmentGuid" {
  value = azurerm_role_assignment.TerraAssignedBuiltin.name
}

output "RBACAssignmentScope" {
  value = azurerm_role_assignment.TerraAssignedBuiltin.scope
}

output "RBACAssignmentRoleName" {
  value = azurerm_role_assignment.TerraAssignedBuiltin.role_definition_name
}

output "RBACAssignmentPrincipalId" {
  value     = azurerm_role_assignment.TerraAssignedBuiltin.principal_id
  sensitive = true
}

output "RBACAssignmentId" {
  value = azurerm_role_assignment.TerraAssignedBuiltin.id
}

output "RBACAssignmentPrincipalType" {
  value = azurerm_role_assignment.TerraAssignedBuiltin.principal_type
}

######################################################################
# Output yaml files for kube resources
######################################################################

output "podidentitymanifest" {
  value = templatefile("${path.module}/yaml_template/podidentity-template.yaml",
    {
      UAIName     = azurerm_user_assigned_identity.terraUAI.name,
      UAIId       = azurerm_user_assigned_identity.terraUAI.id,
      UAIClientId = azurerm_user_assigned_identity.terraUAI.client_id,
    }
  )
}

output "podidentitybindingmanifest" {
  value = templatefile("${path.module}/yaml_template/podidentitybinding-template.yaml",
    {
      UAIName = azurerm_user_assigned_identity.terraUAI.name,
    }
  )

}