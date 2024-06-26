
resource "azurerm_application_security_group" "NodePoolAsg" {
  name                = local.NodePoolAsg
  location            = var.AKSLocation
  resource_group_name = var.AKSRGName

  tags = local.Tags
}