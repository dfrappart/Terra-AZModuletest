

locals {

  StartingDate   = timeadd(timestamp(), "1m")
  ExpirationDate = timeadd(timestamp(), "8760h")
  StartDateTag   = formatdate("YYYY-MM-DD", local.StartingDate)

  Tags = merge(var.DefaultTags, var.ExtraTags, { "StartDate" = local.StartDateTag })

  AppName    = var.AppName == "" ? random_string.RandomAppName[0].result : var.AppName
  RgName     = var.RgName == "" ? lower(format("%s-%s-%s%s", var.ResourceGroupPrefix, var.Env, local.AppName, var.ObjectIndex)) : var.RgName
  VnetName   = var.Vnet.Name == "" ? lower(format("%s-%s-%s%s", var.VnetResourcePrefix, var.Env, local.AppName, var.ObjectIndex)) : var.Vnet.Name
  VnetSuffix = lower(format("%s-%s-%s%s", var.VnetResourcePrefix, var.Env, local.AppName, var.ObjectIndex))

  VnetPrefix            = split("/", var.Vnet.AddressSpace)[1]
  SubnetPrefixesRegular = local.VnetPrefix == "24" ? cidrsubnets(var.Vnet.AddressSpace, 2, 2, 2, 2) : (local.VnetPrefix == "25" || local.VnetPrefix == "26" ? cidrsubnets(var.Vnet.AddressSpace, 1, 1) : [var.Vnet.AddressSpace])
  Subnets = { for subnet in var.Subnets : subnet.Name => {
    Name             = subnet.AllowCustomName ? subnet.Name : lower(format("%s%s-%s", "sub", index(var.Subnets, subnet) + 1, local.VnetSuffix))
    FlowLogName      = subnet.AllowCustomName ? format("%s-%s-%s", "flowlogs", local.VnetName, subnet.Name) : lower(format("%s-%s%s-%s", "flowlogs", "sub", index(var.Subnets, subnet) + 1, local.VnetSuffix))
    EnableNsg        = subnet.EnableNsg
    EnableFlowlogs   = subnet.EnableFlowlogs
    EnableNsgDiagSet = subnet.EnableNsgDiagSet
    IPGroupName      = subnet.AllowCustomName ? format("%s-%s", local.VnetName, subnet.Name) : lower(format("%s%s-%s", "sub", index(var.Subnets, subnet) + 1, local.VnetSuffix))
    Nsg = {
      Name             = subnet.AllowCustomName ? format("%s-%s-%s", "nsg", local.VnetName, subnet.Name) : lower(format("%s-%s%s-%s", "nsg", "sub", index(var.Subnets, subnet) + 1, local.VnetSuffix))
      DiagSettingsName = subnet.AllowCustomName ? format("%s-%s-%s-%s", "diag", "nsg", local.VnetName, subnet.Name) : lower(format("%s-%s-%s%s-%s", "diag", "nsg", "sub", index(var.Subnets, subnet) + 1, local.VnetSuffix))
      FlowLogName      = subnet.AllowCustomName ? format("%s-%s-%s-%s", "flowlogs", "nsg", local.VnetName, subnet.Name) : lower(format("%s-%s%s-%s", "flowlogs", "sub", index(var.Subnets, subnet) + 1, local.VnetSuffix))
      DefaultRules     = var.DefaultNsgRule #merge(try(subnet.Nsg.Rules, {}), var.default_nsg_rules)
      CustomRules      = try(subnet.Nsg.Rules, {})
      Rules            = merge(try(subnet.Nsg.Rules, {}), var.DefaultNsgRule)


    }
    Delegation    = try(subnet.Delegation, null)
    AddressPrefix = try(subnet.AddressPrefix, null)
    }
  }

  NsgRules = tolist(flatten([
    for subnet in var.Subnets : [
      for rule in merge(try(subnet.Nsg.Rules, {}), var.DefaultNsgRule) : merge(rule, { "subnet" : subnet.Name })
    ]
  ]))


  CreateLocalRG = var.RgName == "unspecified" && var.CreateRG ? true : false

  SubnetPrefixesCustom = local.VnetPrefix == "24" ? cidrsubnets(var.Vnet.AddressSpace, 2, 3, 3, 3) : (local.VnetPrefix == "25" ? cidrsubnets(var.Vnet.AddressSpace, 1, 3, 3, 3) : cidrsubnets(var.Vnet.AddressSpace, 1, 1))
  SubnetPrefixes       = var.CustomVnet ? local.SubnetPrefixesCustom : local.SubnetPrefixesRegular

  CreateLocalLaw = var.LawLogId == "unspecified" && var.EnableVnetDiagSettings ? true : false
  CreateLocalSta = var.StaLogId == "unspecified" && var.EnableVnetDiagSettings ? true : false
  StaLogId       = var.StaLogId == "unspecified" && local.CreateLocalSta ? azurerm_storage_account.StaMonitor[0].id : var.StaLogId
  LawLogId       = var.LawLogId == "unspecified" && local.CreateLocalLaw ? azurerm_log_analytics_workspace.LawMonitor[0].id : var.LawLogId

  VnetLogCategories    = var.VnetLogCategories != null ? toset(sort(var.VnetLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Vnet.log_category_types)
  VnetMetricCategories = var.VnetMetricCategories != null ? toset(sort(var.VnetMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Vnet.metrics)

  #NsgLogCategories    = var.NsgLogCategories != null ? toset(sort(var.NsgLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Nsg.log_category_types)
  #NsgMetricCategories = var.NsgMetricCategories != null ? toset(sort(var.NsgMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Nsg.metrics)

  NetworkWatcherRGName = var.NetworkWatcherRGName == "unspecified" ? "NetworkWatcherRG" : var.NetworkWatcherRGName
  NetworkWatcherName   = var.NetworkWatcherName == "unspecified" ? format("%s%s", "NetworkWatcher_", azurerm_virtual_network.Vnet.location) : var.NetworkWatcherName



}