resource "azurerm_subnet" "Subnets" {

  lifecycle {
    ignore_changes = [delegation]
  }

  for_each             = local.Subnets
  name                 = each.value.Name #try(each.value.Name, lower(format("%s-%s-%s%s","subnet",var.Env,local.AppName,var.ObjectIndex)))
  resource_group_name  = var.RgName      #azurerm_resource_group.VnetResourceGroup[0].name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = each.value.AddressPrefix == null ? [local.SubnetPrefixes[index(keys(local.Subnets), each.key)]] : [each.value.AddressPrefix]
  service_endpoints    = each.value.ServiceEndpoints
  private_endpoint_network_policies = each.value.PrivateEndpointNetworkPolicies
  private_link_service_network_policies = each.value.PrivateLinkServiceNetworkPolicies
  default_outbound_access_enabled = each.value.DefaultOutboundAccessEnabled

  dynamic "delegation" {
    for_each = each.value.Delegation != null ? [each.value.Delegation] : []
    content {
      name = delegation.value.DelegationName
      service_delegation {
        name    = delegation.value.ServiceDelegationName
        actions = delegation.value.ServiceDelegationActions
      }
    }
  }

}

resource "azurerm_ip_group" "SubnetsCidr" {
  for_each            = local.Subnets
  name                = each.value.Name #local.Subnets[each.key].IPGroupName
  location            = azurerm_virtual_network.Vnet.location
  resource_group_name = azurerm_virtual_network.Vnet.resource_group_name

  cidrs = each.value.AddressPrefix == null ? [local.SubnetPrefixes[index(keys(local.Subnets), each.key)]] : [each.value.AddressPrefix]

  tags = merge(var.DefaultTags, var.ExtraTags, { "StartDate" = local.StartDateTag })

  lifecycle {
    ignore_changes = [tags["StartDate"]]
  }
}

output "testsubnet" {
  value = local.Subnets
}

output "varsubnet" {
  value = var.Subnets
}