

locals {

  StartingDate                    = timeadd(timestamp(), "1m")
  ExpirationDate                  = timeadd(timestamp(), "8760h")
  StartDateTag                    = formatdate("YYYY-MM-DD", local.StartingDate)

  Tags = merge(var.DefaultTags, var.ExtraTags, { "StartDate" = local.StartDateTag })

  AppName                         = var.AppName == "" ? random_string.RandomAppName[0].result : var.AppName 
  RgName                          = var.Rg.Name == "" ? lower(format("%s-%s-%s%s","rg",var.Env,local.AppName,var.ObjectIndex)) : var.RgName
  VnetName                        = var.Vnet.Name == "" ? lower(format("%s-%s-%s%s","vnet",var.Env,local.AppName,var.ObjectIndex)) : var.Vnet.Name

  VnetPrefix                      = split("/", var.Vnet.AddressSpace)[1]
  SubnetPrefixesRegular           = local.VnetPrefix == "24" ? cidrsubnets(var.Vnet.AddressSpace, 2, 2, 2, 2) : (local.VnetPrefix == "25" || local.VnetPrefix == "26" ? cidrsubnets(var.Vnet.AddressSpace, 1, 1) : [var.Vnet.AddressSpace])
  Subnets = { for subnet in var.Subnets : subnet.Name => {
    Name = subnet.AllowCustomName ? subnet.Name : lower(format("%s%s-%s","subnet",index(var.Subnets,subnet)+1,local.VnetName))
    #Nsg = {
    #  Name  = Subnet.Nsg.Name
    #  Rules = merge(try(subnet.nsg.rules, {}), var.default_nsg_rules)
    #}
    } 
  }

  SubnetPrefixesCustom                  = local.VnetPrefix == "24" ? cidrsubnets(var.Vnet.AddressSpace, 2, 3, 3, 3) : (local.VnetPrefix == "25" ? cidrsubnets(var.Vnet.AddressSpace, 1, 3, 3, 3) : cidrsubnets(var.Vnet.AddressSpace, 1, 1))
  SubnetPrefixes = var.CustomVnet ? local.SubnetPrefixesCustom : local.SubnetPrefixesRegular

  CreateLocalLaw = var.LawLogId == "unspecified" && var.EnableVnetDiagSettings ? true : false
  CreateLocalSta = var.StaLogId == "unspecified" && var.EnableVnetDiagSettings ? true : false
  StaLogId = var.StaLogId == "unspecified" && local.CreateLocalSta ? azurerm_storage_account.StaMonitor[0].id : var.StaLogId
  LawLogId = var.LawLogId == "unspecified" && local.CreateLocalLaw ? azurerm_log_analytics_workspace.LawMonitor[0].id : var.LawLogId

  VnetLogCategories    = var.VnetLogCategories != null ? toset(sort(var.VnetLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Vnet.log_category_types)
  VnetMetricCategories = var.VnetMetricCategories != null ? toset(sort(var.VnetMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Vnet.metrics)

  #NsgLogCategories    = var.NsgLogCategories != null ? toset(sort(var.NsgLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Nsg.log_category_types)
  #NsgMetricCategories = var.NsgMetricCategories != null ? toset(sort(var.NsgMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Nsg.metrics)


}

/*
output "subprefix" {
  value = local.SubnetPrefixes
}

output "subnetprefixnotsorted" {
  value = cidrsubnets(var.Vnet.AddressSpace, 2, 2, 2, 2)
}
*/

output "Subnets" {
  value = local.Subnets
}