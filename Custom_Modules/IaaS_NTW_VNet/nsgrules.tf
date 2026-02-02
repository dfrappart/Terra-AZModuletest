###################################################################################
# NSG Default rules

resource "azurerm_network_security_rule" "nsg_spoke_rules" {
  count                        = length(local.NsgRules)
  name                         = local.NsgRules[count.index].Name
  priority                     = local.NsgRules[count.index].Priority
  direction                    = local.NsgRules[count.index].Direction
  access                       = local.NsgRules[count.index].Access
  protocol                     = local.NsgRules[count.index].Protocol
  source_port_range            = try(local.NsgRules[count.index].SourcePortRange, null)
  destination_port_range       = try(local.NsgRules[count.index].DestinationPortRange, null)
  destination_port_ranges      = try(local.NsgRules[count.index].DestinationPortRanges, null)
  source_address_prefix        = try(local.NsgRules[count.index].SourceAddressPrefix, null)
  source_address_prefixes      = try(local.NsgRules[count.index].SourceAddressPrefixes, null)
  destination_address_prefix   = try(local.NsgRules[count.index].DestinationAddressPrefix, null)
  destination_address_prefixes = try(local.NsgRules[count.index].DestinationAddressPrefixes, null)
  resource_group_name          = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name  = azurerm_network_security_group.Nsgs[local.NsgRules[count.index].SubnetName].name


}

/*
resource "azurerm_network_security_rule" "nsg_spoke_rules" {
  for_each = local.NsgRules
  name                         = each.value.Name
  priority                     = each.value.Priority
  direction                    = each.value.Direction
  access                       = each.value.Access
  protocol                     = each.value.Protocol
  source_port_range            = each.value.SourcePortRange
  destination_port_range       = each.value.DestinationPortRange
  destination_port_ranges      = each.value.DestinationPortRanges
  source_address_prefix        = each.value.SourceAddressPrefix
  source_address_prefixes      = each.value.SourceAddressPrefixes
  destination_address_prefix   = each.value.DestinationAddressPrefix
  destination_address_prefixes = each.value.DestinationAddressPrefixes
  resource_group_name          = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name  = azurerm_network_security_group.Nsgs[each.key].name
}

###################################################################################
# NSG required & Default rules for bastion

# NSG Ingress Rules
/*
resource "azurerm_network_security_rule" "Default_BastionSubnet_AllowHTTPSBastionIn" {
  for_each                    = { for k, v in local.Subnets : k => v if v.Name == "AzureBastionSubnet" }
  name                        = "Default_BastionSubnet_AllowHTTPSBastionIn"
  priority                    = 2010
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name = azurerm_network_security_group.Nsgs[each.key].name
}



resource "azurerm_network_security_rule" "Default_BastionSubnet_AllowGatewayManager" {
  for_each                    = { for k, v in local.Subnets : k => v if v.Name == "AzureBastionSubnet" }
  name                        = "Default_BastionSubnet_AllowGatewayManager"
  priority                    = 2020
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443"]
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name = azurerm_network_security_group.Nsgs[each.key].name
}

resource "azurerm_network_security_rule" "Default_BastionSubnet_AllowAzureLB" {
  for_each                    = { for k, v in local.Subnets : k => v if v.Name == "AzureBastionSubnet" }
  name                        = "Default_BastionSubnet_AllowAzureLB"
  priority                    = 2030
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443"]
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name = azurerm_network_security_group.Nsgs[each.key].name
}

resource "azurerm_network_security_rule" "Default_BastionSubnet_AllowBastionCommunicationIn" {
  for_each                    = { for k, v in local.Subnets : k => v if v.Name == "AzureBastionSubnet" }
  name                        = "Default_BastionSubnet_AllowBastionCommunicationIn"
  priority                    = 2040
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["8080", "5701"]
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name = azurerm_network_security_group.Nsgs[each.key].name
}

# NSG Egress Rules

resource "azurerm_network_security_rule" "Default_BastionSubnet_AllowRemoteBastionOut" {
  for_each                    = { for k, v in local.Subnets : k => v if v.Name == "AzureBastionSubnet" }
  name                        = "Default_BastionSubnet_AllowRemoteBastionOut"
  priority                    = 2010
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22", "3389"]
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name = azurerm_network_security_group.Nsgs[each.key].name
}

resource "azurerm_network_security_rule" "Default_AllowAzureCloudHTTPSOut" {
  for_each                    = { for k, v in local.Subnets : k => v if v.Name == "AzureBastionSubnet" }
  name                        = "Default_AllowAzureCloudHTTPSOut"
  priority                    = 2020
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "AzureCloud"
  resource_group_name         = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name = azurerm_network_security_group.Nsgs[each.key].name
}

resource "azurerm_network_security_rule" "Default_AllowAzureBastionCommunicationOut" {
  for_each                    = { for k, v in local.Subnets : k => v if v.Name == "AzureBastionSubnet" }
  name                        = "Default_AllowAzureBastionCommunicationOut"
  priority                    = 2030
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["8080", "5701"]
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name = azurerm_network_security_group.Nsgs[each.key].name
}

resource "azurerm_network_security_rule" "Default_AllowAzureBastionGetSessionInformationOut" {
  for_each                    = { for k, v in local.Subnets : k => v if v.Name == "AzureBastionSubnet" }
  name                        = "Default_AllowAzureBastionGetSessionInformationOut"
  priority                    = 2040
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80"]
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name = azurerm_network_security_group.Nsgs[each.key].name
}

resource "azurerm_network_security_rule" "Default_BastionSubnet_DenyVNetOut" {
  for_each                    = { for k, v in local.Subnets : k => v if v.Name == "AzureBastionSubnet" }
  name                        = "Default_BastionSubnet_DenyVNetOut"
  priority                    = 2510
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name = azurerm_network_security_group.Nsgs[each.key].name
}

resource "azurerm_network_security_rule" "Default_BastionSubnet_DenyInternetOut" {
  for_each                    = { for k, v in local.Subnets : k => v if v.Name == "AzureBastionSubnet" }
  name                        = "Default_BastionSubnet_DenyInternetOut"
  priority                    = 2520
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name = azurerm_network_security_group.Nsgs[each.key].name
}

*/