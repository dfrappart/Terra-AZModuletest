

resource "azurerm_public_ip" "LbPubIp" {
  count                   = var.LbConfig.IsLbPublic ? 1 : 0
  name                    = local.LbPubIpName
  location                = var.TargetLocation
  resource_group_name     = local.RgName
  allocation_method       = "Static"
  sku                     = "Standard"
  sku_tier                = var.LbConfig.PubIpSkuTier
  zones                   = var.LbConfig.Zones
  domain_name_label       = lower(local.LbPubIpName)
  ddos_protection_mode    = var.LbConfig.DDosProtectionMode
  ddos_protection_plan_id = var.LbConfig.DDosProtectionPlanId
}

resource "azurerm_lb" "Lb" {
  name                = local.LbName
  location            = var.TargetLocation
  resource_group_name = local.RgName
  sku                 = var.LbConfig.Sku
  sku_tier            = var.LbConfig.SkuTier

  frontend_ip_configuration {
    name                          = local.LbFrontendIpConfigurationName
    public_ip_address_id          = local.LbFrontendIpConfigurationPubIpId
    subnet_id                     = local.LbFrontendIpConfigurationSubnetId
    private_ip_address_allocation = var.LbConfig.PrivateIpAddressAllocation
    private_ip_address            = var.LbConfig.PrivateIpAddress
    zones                         = local.LbZones
  }
}
