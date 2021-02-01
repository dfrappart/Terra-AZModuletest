######################################################################
# This module create a role assigmnet for a builtin role
######################################################################

#Resource Creation

resource "azurerm_role_assignment" "TerraAssignedBuiltin" {
  scope                               = var.RBACScope
  role_definition_name                = var.BuiltinRoleName
  principal_id                        = var.ObjectId
}


