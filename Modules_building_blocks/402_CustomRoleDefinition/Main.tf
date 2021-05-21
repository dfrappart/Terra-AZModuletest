######################################################################
# This module create a role assigmnet for a builtin role
######################################################################

#Resource Creation

resource "azurerm_role_definition" "CustomRBACRole" {
  
  role_definition_id                  = var.RoleGuid
  name                                = var.RoleName
  scope                               = var.RoleScope
  description                         = var.RoleDescription != "" ? var.RoleDescription : var.RoleName
  assignable_scopes                   = var.RoleAssignableScopes

  permissions {
    actions                           = var.Permission_Actions
    not_actions                       = var.Permission_NotActions
    data_actions                      = var.Permission_Data_Actions
    not_data_actions                  = var.Permission_Not_Data_Actions
  }
}


