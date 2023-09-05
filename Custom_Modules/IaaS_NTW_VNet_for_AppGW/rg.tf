###################################################################################
# Resource group

resource "random_string" "RandomAppName" {
  length           = 4
  special          = false
  numeric = true
  
}


resource "azurerm_resource_group" "VNetResourceGroup" {

  lifecycle {
    ignore_changes = [
      tags["StartDate"]
    ]
  }

  count    = var.Rg.CreateRG ? 1 : 0
  name     = local.RgName
  location = var.Rg.Location
  tags     = merge(var.DefaultTags, var.ExtraTags, { "StartDate" = local.StartDateTag })
}