

locals {

  StartingDate   = timeadd(timestamp(), "1m")
  ExpirationDate = timeadd(timestamp(), "8760h")
  StartDateTag   = formatdate("YYYY-MM-DD", local.StartingDate)

  Tags = merge(var.DefaultTags, var.ExtraTags, { "StartDate" = local.StartDateTag })

  AppName    = var.AppName == "" ? random_string.RandomAppName[0].result : var.AppName
  RgName     = var.RgName == "" ? lower(format("%s-%s-%s%s", var.ResourceGroupPrefix, var.Env, local.AppName, var.ObjectIndex)) : var.RgName
  VnetName   = var.Vnet.Name == "" ? lower(format("%s-%s-%s%s", var.VnetResourcePrefix, var.Env, local.AppName, var.ObjectIndex)) : var.Vnet.Name
  VnetFlowLogName = "flowlog-${local.VnetName}"
  VnetSuffix = lower(format("%s-%s-%s%s", var.VnetResourcePrefix, var.Env, local.AppName, var.ObjectIndex))

  VnetPrefix            = split("/", var.Vnet.AddressSpace)[1]
  SubnetPrefixesRegular = local.VnetPrefix == "24" ? cidrsubnets(var.Vnet.AddressSpace, 2, 2, 2, 2) : (local.VnetPrefix == "25" || local.VnetPrefix == "26" ? cidrsubnets(var.Vnet.AddressSpace, 1, 1) : [var.Vnet.AddressSpace])
  Subnets = { for subnet in var.Subnets : subnet.Name => {
    Name             = subnet.AllowCustomName ? subnet.Name : lower(format("%s%s-%s", "sub", index(var.Subnets, subnet) + 1, local.VnetSuffix))
    EnableNsg        = subnet.EnableNsg
    EnableNsgDiagSet = subnet.EnableNsgDiagSet
    IPGroupName      = subnet.AllowCustomName ? format("%s-%s", local.VnetName, subnet.Name) : lower(format("%s%s-%s", "sub", index(var.Subnets, subnet) + 1, local.VnetSuffix))
    Nsg = {
      Name             = subnet.AllowCustomName ? format("%s-%s-%s", "nsg", local.VnetName, subnet.Name) : lower(format("%s-%s%s-%s", "nsg", "sub", index(var.Subnets, subnet) + 1, local.VnetSuffix))
      DiagSettingsName = subnet.AllowCustomName ? format("%s-%s-%s-%s", "diag", "nsg", local.VnetName, subnet.Name) : lower(format("%s-%s-%s%s-%s", "diag", "nsg", "sub", index(var.Subnets, subnet) + 1, local.VnetSuffix))
      DefaultRules     = local.DefaultNsgRules
      DefaultRulesWithBastion = subnet.Name == "AzureBastionSubnet" && subnet.AllowCustomName ? merge(local.DefaultNsgRules, var.BastionNsgRules) : local.DefaultNsgRules
      #Rules            = merge(try(subnet.Nsg.Rules, {}), local.DefaultNsgRules)
      Rules = merge(try(subnet.Nsg.Rules, {}),(subnet.Name == "AzureBastionSubnet" && subnet.AllowCustomName ? merge(local.DefaultNsgRules, var.BastionNsgRules) : local.DefaultNsgRules))


    }
    Delegation    = try(subnet.Delegation, null)
    AddressPrefix = try(subnet.AddressPrefix, null)
    }
  }



  DefaultNsgRules = var.EnableNsgDenyAll ? merge(var.DefaultNsgRules, var.SecureNsgRules) : var.DefaultNsgRules

  NsgRules = flatten([for SubnetKey, SubnetValue in local.Subnets :
    [ for v in SubnetValue.Nsg.Rules : {
      Name                           = v.Name
      Priority                       = v.Priority
      Direction                      = v.Direction
      Access                         = v.Access
      Protocol                       = v.Protocol
      SourcePortRange                = try(v.SourcePortRange, null)
      SourcePortRanges               = try(v.SourcePortRanges, null)
      DestinationPortRange           = try(v.DestinationPortRange, null)
      DestinationPortRanges          = try(v.DestinationPortRanges, null)
      SourceAddressPrefix            = try(v.SourceAddressPrefix, null)
      SourceAddressPrefixes          = try(v.SourceAddressPrefixes, null)
      DestinationAddressPrefix       = try(v.DestinationAddressPrefix, null)
      DestinationAddressPrefixes     = try(v.DestinationAddressPrefixes, null)
      Description                    = try(v.Description, "")
      SubnetName                     = SubnetKey
    }]
  ])





/*
  NsgRules = tolist(flatten([
    for subnet in var.Subnets : [
      for rule in subnet.Nsg.Rules : merge(rule, { "subnet" : subnet.Name })
    ]
  ]))
*/


  CreateLocalRG = var.RgName == "unspecified" && var.CreateRG ? true : false

  SubnetPrefixesCustom = local.VnetPrefix == "24" ? cidrsubnets(var.Vnet.AddressSpace, 2, 3, 3, 3) : (local.VnetPrefix == "25" ? cidrsubnets(var.Vnet.AddressSpace, 1, 3, 3, 3) : cidrsubnets(var.Vnet.AddressSpace, 1, 1))
  SubnetPrefixes       = var.CustomVnet ? local.SubnetPrefixesCustom : local.SubnetPrefixesRegular

 
  StaLogId       = var.CreateLocalSta ? azurerm_storage_account.StaMonitor[0].id : var.StaLogId
  LawLogId       = var.CreateLocalLaw ? azurerm_log_analytics_workspace.LawMonitor[0].id : var.LawLogId
  LawWorkspaceId = var.CreateLocalLaw ? azurerm_log_analytics_workspace.LawMonitor[0].workspace_id : data.azurerm_log_analytics_workspace.LawLog[0].workspace_id
  LawWorkspaceLocation= var.CreateLocalLaw ? azurerm_log_analytics_workspace.LawMonitor[0].location : data.azurerm_log_analytics_workspace.LawLog[0].location

  VnetLogCategories    = var.VnetLogCategories != null ? toset(sort(var.VnetLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Vnet.log_category_types)
  VnetMetricCategories = var.VnetMetricCategories != null ? toset(sort(var.VnetMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.Vnet.metrics)

  NetworkWatcherRGName = var.NetworkWatcherRGName == "unspecified" ? "NetworkWatcherRG" : var.NetworkWatcherRGName
  NetworkWatcherName   = var.NetworkWatcherName == "unspecified" ? format("%s%s", "NetworkWatcher_", azurerm_virtual_network.Vnet.location) : var.NetworkWatcherName



}

