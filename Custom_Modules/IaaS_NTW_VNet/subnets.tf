resource "azurerm_subnet" "Subnets" {

  for_each             = local.Subnets
  name                 = each.value.Name #try(each.value.Name, lower(format("%s-%s-%s%s","subnet",var.Env,local.AppName,var.ObjectIndex)))
  resource_group_name  = var.RgName      #azurerm_resource_group.VnetResourceGroup[0].name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = [local.SubnetPrefixes[index(keys(local.Subnets), each.key)]]
}

resource "azurerm_ip_group" "SubnetsCidr" {
  for_each = local.Subnets
  name                = local.Subnets[each.key].IPGroupName
  location            = azurerm_virtual_network.Vnet.location
  resource_group_name = azurerm_virtual_network.Vnet.resource_group_name

  cidrs = [local.SubnetPrefixes[index(keys(local.Subnets), each.key)]]

  tags                = merge(var.DefaultTags, var.ExtraTags, { "StartDate" = local.StartDateTag })

  lifecycle {
    ignore_changes = [ tags["StartDate"] ]
  }
}

output "keylocalsubnet" {
  value = keys(local.Subnets)
}