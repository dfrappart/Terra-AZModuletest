###################################################################################
# NSG Default rules

resource "azurerm_network_security_rule" "nsg_spoke_rules" {
  count                        = length(local.NsgRules)
  name                         = local.NsgRules[count.index].Name
  priority                     = local.NsgRules[count.index].Priority
  direction                    = local.NsgRules[count.index].Direction
  access                       = local.NsgRules[count.index].Access
  protocol                     = local.NsgRules[count.index].Protocol
  source_port_range            = local.NsgRules[count.index].SourcePortRange
  destination_port_range       = local.NsgRules[count.index].DestinationPortRange
  destination_port_ranges      = local.NsgRules[count.index].DestinationPortRanges
  source_address_prefix        = local.NsgRules[count.index].SourceAddressPrefix
  source_address_prefixes      = local.NsgRules[count.index].SourceAddressPrefixes
  destination_address_prefix   = local.NsgRules[count.index].DestinationAddressPrefix
  destination_address_prefixes = local.NsgRules[count.index].DestinationAddressPrefixes
  resource_group_name          = azurerm_virtual_network.Vnet.resource_group_name
  network_security_group_name  = azurerm_network_security_group.Nsgs[local.NsgRules[count.index].subnet].name


}


###################################################################################
# NSG required & Default rules for bastion

# NSG Ingress Rules

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

