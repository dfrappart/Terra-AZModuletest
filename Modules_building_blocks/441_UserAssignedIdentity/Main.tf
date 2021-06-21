######################################################################
# This module create a User assign resource
######################################################################

#Resource Creation

resource "azurerm_user_assigned_identity" "UAI" {
  resource_group_name                   = var.TargetRG
  location                              = var.TargetLocation

  name                                  = local.UAIName

  ########################
  #Tags

  tags                                 = merge(local.DefaultTags, var.ExtraTags)
}