/*
resource "azurerm_private_endpoint" "AppSvcPe" {
  for_each = {for k, v in var.AppSvc : k => v if v.EnablePrivateEndpoint}
  name                = format("pe-%s", azurerm_linux_web_app.App[each.key].name)
  location            = azurerm_resource_group.RgAppsvc.location
  resource_group_name = azurerm_resource_group.RgAppsvc.name
  subnet_id           = data.azurerm_subnet.AppSvcPeSubnet.id

  private_service_connection {
    name                           = format("psc-%s", azurerm_linux_web_app.App[each.key].name)
    private_connection_resource_id = azurerm_linux_web_app.App[each.key].id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.AppSvcDnsZone.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.AppSvcDnsZone.id]
  }
}
*/