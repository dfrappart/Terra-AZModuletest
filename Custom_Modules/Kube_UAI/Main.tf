########################################################################
# UAI in Azure + its counter part in kube yaml def file
########################################################################

resource "azurerm_user_assigned_identity" "terraUAI" {
  resource_group_name = var.TargetRG
  location            = var.TargetLocation

  name = "uai${lower(var.UAISuffix)}"

  ########################
  #Tags

  tags = {
    ResourceOwner = var.ResourceOwnerTag
    Country       = var.CountryTag
    CostCenter    = var.CostCenterTag
    Environment   = var.Environment
    Project       = var.Project
    ManagedBy     = "Terraform"
  }
}

######################################################################
# Create a role assignment for a builtin role
######################################################################

#Resource Creation

resource "azurerm_role_assignment" "TerraAssignedBuiltin" {
  scope                = var.RBACScope
  role_definition_name = var.BuiltinRoleName
  principal_id         = azurerm_user_assigned_identity.terraUAI.principal_id
}