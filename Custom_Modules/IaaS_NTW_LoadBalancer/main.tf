
resource "azurerm_resource_group" "Rg" {
  count    = var.TargetRG == "unspecified" ? 1 : 0
  name     = local.RgName
  location = var.TargetLocation

  tags = local.RgLbTags

}




