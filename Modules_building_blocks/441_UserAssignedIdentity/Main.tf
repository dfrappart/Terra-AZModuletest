######################################################################
# This module create a User assign resource
######################################################################

#Resource Creation

resource "azurerm_user_assigned_identity" "terraUAI" {
  resource_group_name                   = var.TargetRG
  location                              = var.TargetLocation

  name                                  = "uai${lower(var.UAISuffix)}"

  ########################
  #Tags

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Environment                         = var.Environment
    Project                             = var.Project
    ManagedBy                           = "Terraform"
  }
}