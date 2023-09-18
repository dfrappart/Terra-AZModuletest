
resource "azurerm_resource_group" "RgAgw" {
    count = var.TargetRG == "unspecified" ? 1 : 0
    name = local.RgName
    location = var.TargetLocation

    tags = local.Tags
  
}

