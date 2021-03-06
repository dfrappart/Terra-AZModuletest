########################################################################
# Spoke VNet isolated and peered
########################################################################

###################################################################################
############################## Creating a VNet ####################################
###################################################################################


resource "azurerm_virtual_network" "SpokeVNet" {
  name                                  = "vnet${lower(var.VNetSuffix)}"
  resource_group_name                   = var.TargetRG
  address_space                         = var.VNetAddressSpace
  location                              = var.TargetLocation

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Project                             = var.Project
    Environment                         = var.Environment
    ManagedBy                           = "Terraform"
  }
}

#Diagnostic settings on VNet

resource "azurerm_monitor_diagnostic_setting" "SpokeVNetDiag" {
  name                                  = "${azurerm_virtual_network.SpokeVNet.name}diag"
  target_resource_id                    = azurerm_virtual_network.SpokeVNet.id
  storage_account_id                    = data.azurerm_storage_account.STASubLog.id
  log_analytics_workspace_id            = data.azurerm_log_analytics_workspace.LawSubLog.id

  log {
    category                            = "VMProtectionAlerts"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  metric {
    category                            = "AllMetrics"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    }    

  }
}


###################################################################################
############################## Subnets & NSG ######################################
###################################################################################


###################################################################################
#Azure managed Bastion

resource "azurerm_network_security_group" "AzureBastionNSG" {
  name                                  = "nsg-bst${lower(var.VNetSuffix)}"
  location                              = var.TargetLocation
  resource_group_name                   = var.TargetRG

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Project                             = var.Project
    Environment                         = var.Environment
    ManagedBy                           = "Terraform"
  }
}

#Diagnostic settings on the Bastion nsg

resource "azurerm_monitor_diagnostic_setting" "AzureBastionNSGDiag" {
  name                                  = "${azurerm_network_security_group.AzureBastionNSG.name}diag"
  target_resource_id                    = azurerm_network_security_group.AzureBastionNSG.id
  storage_account_id                    = data.azurerm_storage_account.STASubLog.id
  log_analytics_workspace_id            = data.azurerm_log_analytics_workspace.LawSubLog.id

  log {
    category                            = "NetworkSecurityGroupEvent"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "NetworkSecurityGroupRuleCounter"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

}

#NSG Flow logs on the Bastion nsg

resource "azurerm_network_watcher_flow_log" "AzureBastionNSGFlowLog" {
  network_watcher_name                  = var.NetworkWatcherName
  resource_group_name                   = var.NetworkWatcherRGName

  network_security_group_id             = azurerm_network_security_group.AzureBastionNSG.id
  storage_account_id                    = data.azurerm_storage_account.STASubLog.id
  enabled                               = true
  version                               = 2

  retention_policy {
    enabled                             = true
    days                                = 365
  }

  traffic_analytics {
    enabled                             = true
    workspace_id                        = data.azurerm_log_analytics_workspace.LawSubLog.workspace_id
    workspace_region                    = data.azurerm_log_analytics_workspace.LawSubLog.location
    workspace_resource_id               = data.azurerm_log_analytics_workspace.LawSubLog.id
    interval_in_minutes                 = 10
  }
}

resource "azurerm_subnet" "AzBastionmanagedSubnet" {


    name                                = "AzureBastionSubnet"
    resource_group_name                 = var.TargetRG
    virtual_network_name                = azurerm_virtual_network.SpokeVNet.name
    address_prefixes                    = [cidrsubnet(var.VNetAddressSpace[0],2,0)]


}

resource "azurerm_subnet_network_security_group_association" "BastionSubnetNSGAssociation" {
    subnet_id                           = azurerm_subnet.AzBastionmanagedSubnet.id
    network_security_group_id           = azurerm_network_security_group.AzureBastionNSG.id
}

###################################################################################
#Application Gateway Subnet

#NSG

resource "azurerm_network_security_group" "AppGWSubnetNSG" {
  name                                  = "nsg-agw${lower(var.VNetSuffix)}"
  location                              = var.TargetLocation
  resource_group_name                   = var.TargetRG

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Project                             = var.Project
    Environment                         = var.Environment
    ManagedBy                           = "Terraform"
  }
}

#Diagnostic settings on the AppGW nsg

resource "azurerm_monitor_diagnostic_setting" "AppGWSubnetNSGDiag" {
  name                                  = "${azurerm_network_security_group.AppGWSubnetNSG.name}diag"
  target_resource_id                    = azurerm_network_security_group.AppGWSubnetNSG.id
  storage_account_id                    = data.azurerm_storage_account.STASubLog.id
  log_analytics_workspace_id            = data.azurerm_log_analytics_workspace.LawSubLog.id

  log {
    category                            = "NetworkSecurityGroupEvent"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "NetworkSecurityGroupRuleCounter"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

}

#Flow Logs on AppGW NSG

resource "azurerm_network_watcher_flow_log" "AppGWSubnetNSGFlowLog" {
  network_watcher_name                  = var.NetworkWatcherName
  resource_group_name                   = var.NetworkWatcherRGName
  network_security_group_id             = azurerm_network_security_group.AppGWSubnetNSG.id
  storage_account_id                    = data.azurerm_storage_account.STASubLog.id
  enabled                               = true
  version                               = 2

  retention_policy {
    enabled                             = true
    days                                = 365
  }

  traffic_analytics {
    enabled                             = true
    workspace_id                        = data.azurerm_log_analytics_workspace.LawSubLog.workspace_id
    workspace_region                    = data.azurerm_log_analytics_workspace.LawSubLog.location
    workspace_resource_id               = data.azurerm_log_analytics_workspace.LawSubLog.id
    interval_in_minutes                 = 10
  }
}

#AppGW Subnet

resource "azurerm_subnet" "AppGWSubnet" {
    name                                = "subAGW${lower(var.VNetSuffix)}"
    resource_group_name                 = var.TargetRG
    virtual_network_name                = azurerm_virtual_network.SpokeVNet.name
    address_prefixes                    = [cidrsubnet(var.VNetAddressSpace[0],2,1)]

}

#AppGW Subnet NSG Association

resource "azurerm_subnet_network_security_group_association" "AppGWSubnetNSGAssociation" {
    subnet_id                           = azurerm_subnet.AppGWSubnet.id
    network_security_group_id           = azurerm_network_security_group.AppGWSubnetNSG.id
}


###################################################################################
#FE Subnet

#NSG FE Subnet

resource "azurerm_network_security_group" "FESubnetNSG" {
  name                                  = "nsg-subFE${lower(var.VNetSuffix)}"
  location                              = var.TargetLocation
  resource_group_name                   = var.TargetRG

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Project                             = var.Project
    Environment                         = var.Environment
    ManagedBy                           = "Terraform"
  }
}

#Diagnostic settings on FE nsg

resource "azurerm_monitor_diagnostic_setting" "FESubnetNSGDiag" {
  name                                  = "${azurerm_network_security_group.FESubnetNSG.name}diag"
  target_resource_id                    = azurerm_network_security_group.FESubnetNSG.id
  storage_account_id                    = data.azurerm_storage_account.STASubLog.id
  log_analytics_workspace_id            = data.azurerm_log_analytics_workspace.LawSubLog.id

  log {
    category                            = "NetworkSecurityGroupEvent"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "NetworkSecurityGroupRuleCounter"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

}

#Flow Logs on FE NSG

resource "azurerm_network_watcher_flow_log" "FESubnetNSGFlowLog" {
  network_watcher_name                  = var.NetworkWatcherName
  resource_group_name                   = var.NetworkWatcherRGName
  network_security_group_id             = azurerm_network_security_group.FESubnetNSG.id
  storage_account_id                    = data.azurerm_storage_account.STASubLog.id
  enabled                               = true
  version                               = 2

  retention_policy {
    enabled                             = true
    days                                = 365
  }

  traffic_analytics {
    enabled                             = true
    workspace_id                        = data.azurerm_log_analytics_workspace.LawSubLog.workspace_id
    workspace_region                    = data.azurerm_log_analytics_workspace.LawSubLog.location
    workspace_resource_id               = data.azurerm_log_analytics_workspace.LawSubLog.id
    interval_in_minutes                 = 10
  }
}

resource "azurerm_subnet" "FESubnet" {
    name                                = "subFE${lower(var.VNetSuffix)}"
    resource_group_name                 = var.TargetRG
    virtual_network_name                = azurerm_virtual_network.SpokeVNet.name
    address_prefixes                    = [cidrsubnet(var.VNetAddressSpace[0],2,2)]
    service_endpoints                   = var.SubnetEndpointLists

}


resource "azurerm_subnet_network_security_group_association" "FESubnetNSGAssociation" {
    subnet_id                           = azurerm_subnet.FESubnet.id
    network_security_group_id           = azurerm_network_security_group.FESubnetNSG.id
}

###################################################################################
#BE Subnet

#NSG BE

resource "azurerm_network_security_group" "BESubnetNSG" {
  name                                  = "nsg-subBE${lower(var.VNetSuffix)}"
  location                              = var.TargetLocation
  resource_group_name                   = var.TargetRG

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Project                             = var.Project
    Environment                         = var.Environment
    ManagedBy                           = "Terraform"
  }
}

#Diagnostic settings on the BE nsg

resource "azurerm_monitor_diagnostic_setting" "BESubnetNSGDiag" {
  name                                  = "${azurerm_network_security_group.BESubnetNSG.name}diag"
  target_resource_id                    = azurerm_network_security_group.BESubnetNSG.id
  storage_account_id                    = data.azurerm_storage_account.STASubLog.id
  log_analytics_workspace_id            = data.azurerm_log_analytics_workspace.LawSubLog.id

  log {
    category                            = "NetworkSecurityGroupEvent"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "NetworkSecurityGroupRuleCounter"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

}

#Flow Logs on BE NSG

resource "azurerm_network_watcher_flow_log" "BESubnetNSGFlowLog" {
  network_watcher_name                  = var.NetworkWatcherName
  resource_group_name                   = var.NetworkWatcherRGName
  network_security_group_id             = azurerm_network_security_group.BESubnetNSG.id
  storage_account_id                    = data.azurerm_storage_account.STASubLog.id
  enabled                               = true
  version                               = 2

  retention_policy {
    enabled                             = true
    days                                = 365
  }

  traffic_analytics {
    enabled                             = true
    workspace_id                        = data.azurerm_log_analytics_workspace.LawSubLog.workspace_id
    workspace_region                    = data.azurerm_log_analytics_workspace.LawSubLog.location
    workspace_resource_id               = data.azurerm_log_analytics_workspace.LawSubLog.id
    interval_in_minutes                 = 10
  }
}

#BE Subnet

resource "azurerm_subnet" "BESubnet" {
    name                                = "subBE${lower(var.VNetSuffix)}"
    resource_group_name                 = var.TargetRG
    virtual_network_name                = azurerm_virtual_network.SpokeVNet.name
    address_prefixes                    = [cidrsubnet(var.VNetAddressSpace[0],2,3)]
    service_endpoints                   = var.SubnetEndpointLists

}

#BE Subnet NSG Association

resource "azurerm_subnet_network_security_group_association" "BESubnetNSGAssociation" {
    subnet_id                           = azurerm_subnet.BESubnet.id
    network_security_group_id           = azurerm_network_security_group.BESubnetNSG.id
}

###################################################################################
################################## NSG rules ######################################
###################################################################################

###################################################################################
# NSG Default rules for FE Subnet

#Inbound

resource "azurerm_network_security_rule" "Default_FESubnet_AllowRDPSSHFromBastion" {
  name                                  = "Default_FESubnet_AllowRDPSSHFromBastion"
  priority                              = 2010
  direction                             = "Inbound"
  access                                = "Allow"
  protocol                              = "Tcp"
  source_port_range                     = "*"
  destination_port_ranges               = ["22","3389"]
  source_address_prefixes               = azurerm_subnet.AzBastionmanagedSubnet.address_prefixes
  destination_address_prefix            = "*"
  resource_group_name                   = var.TargetRG
  network_security_group_name           = azurerm_network_security_group.FESubnetNSG.name
}

resource "azurerm_network_security_rule" "Default_FESubnet_AllowLB" {
  name                                  = "Default_FESubnet_AllowLB"
  priority                              = 2020
  direction                             = "Inbound"
  access                                = "Allow"
  protocol                              = "*"
  source_port_range                     = "*"
  destination_port_range                = "*"
  source_address_prefix                 = "AzureLoadBalancer"
  destination_address_prefix            = "*"
  resource_group_name                   = var.TargetRG
  network_security_group_name           = azurerm_network_security_group.FESubnetNSG.name
}

resource "azurerm_network_security_rule" "Default_FESubnet_DenyVNetSSHRDPIn" {
  name                                  = "Default_FESubnet_DenyVNetSSHRDPIn"
  priority                              = 2510
  direction                             = "Inbound"
  access                                = "Deny"
  protocol                              = "Tcp"
  source_port_range                     = "*"
  destination_port_ranges               = ["22","3389"]
  source_address_prefix                 = "VirtualNetwork"
  destination_address_prefix            = "*"
  resource_group_name                   = var.TargetRG
  network_security_group_name           = azurerm_network_security_group.FESubnetNSG.name
}

# Outbound

###################################################################################
# NSG Default rules for BE Subnet

# Inbound

resource "azurerm_network_security_rule" "Default_BESubnet_AllowRDPSSHFromBastion" {
  name                                  = "Default_BESubnet_AllowRDPSSHFromBastion"
  priority                              = 2010
  direction                             = "Inbound"
  access                                = "Allow"
  protocol                              = "Tcp"
  source_port_range                     = "*"
  destination_port_ranges               = ["22","3389"]
  source_address_prefixes               = azurerm_subnet.AzBastionmanagedSubnet.address_prefixes
  destination_address_prefix            = "*"
  resource_group_name                   = var.TargetRG
  network_security_group_name           = azurerm_network_security_group.BESubnetNSG.name
}

resource "azurerm_network_security_rule" "Default_BESubnet_AllowLB" {
  name                                  = "Default_BESubnet_AllowLB"
  priority                              = 2020
  direction                             = "Inbound"
  access                                = "Allow"
  protocol                              = "*"
  source_port_range                     = "*"
  destination_port_range                = "*"
  source_address_prefix                 = "AzureLoadBalancer"
  destination_address_prefix            = "*"
  resource_group_name                   = var.TargetRG
  network_security_group_name           = azurerm_network_security_group.BESubnetNSG.name
}

# Outbound

###################################################################################
# NSG Required and Default rules for AppGW Subnet

# NSG Ingress Rules

resource "azurerm_network_security_rule" "Default_AppGWSubnet_GatewayManager" {
  name                                  = "Default_AppGWSubnet_GatewayManager"
  priority                              = 2010
  direction                             = "Inbound"
  access                                = "Allow"
  protocol                              = "*"
  source_port_range                     = "*"
  destination_port_ranges               = ["65200-65535"]
  source_address_prefix                 = "GatewayManager"
  destination_address_prefix            = "*"
  resource_group_name                   = var.TargetRG
  network_security_group_name           = azurerm_network_security_group.AppGWSubnetNSG.name
}

###################################################################################
# NSG required & Default rules for bastion

# NSG Ingress Rules

resource "azurerm_network_security_rule" "Default_BastionSubnet_AllowHTTPSBastionIn" {
  name                                  = "Default_BastionSubnet_AllowHTTPSBastionIn"
  priority                              = 2010
  direction                             = "Inbound"
  access                                = "Allow"
  protocol                              = "Tcp"
  source_port_range                     = "*"
  destination_port_range                = "443"
  source_address_prefix                 = "Internet"
  destination_address_prefix            = "*"
  resource_group_name                   = var.TargetRG
  network_security_group_name           = azurerm_network_security_group.AzureBastionNSG.name
}

resource "azurerm_network_security_rule" "Default_BastionSubnet_AllowGatewayManager" {
  name                                  = "Default_BastionSubnet_AllowGatewayManager"
  priority                              = 2020
  direction                             = "Inbound"
  access                                = "Allow"
  protocol                              = "Tcp"
  source_port_range                     = "*"
  destination_port_ranges               = ["443","4443"]
  source_address_prefix                 = "GatewayManager"
  destination_address_prefix            = "*"
  resource_group_name                   = var.TargetRG
  network_security_group_name           = azurerm_network_security_group.AzureBastionNSG.name
}


# NSG Egress Rules

resource "azurerm_network_security_rule" "Default_BastionSubnet_AllowRemoteBastionOut" {
  name                                  = "Default_BastionSubnet_AllowRemoteBastionOut"
  priority                              = 2010
  direction                             = "Outbound"
  access                                = "Allow"
  protocol                              = "Tcp"
  source_port_range                     = "*"
  destination_port_ranges               = ["22","3389"]
  source_address_prefix                 = "*"
  destination_address_prefix            = "VirtualNetwork"
  resource_group_name                   = var.TargetRG
  network_security_group_name           = azurerm_network_security_group.AzureBastionNSG.name
}

resource "azurerm_network_security_rule" "Default_AllowAzureCloudHTTPSOut" {
  name                                  = "Default_AllowAzureCloudHTTPSOut"
  priority                              = 2020
  direction                             = "Outbound"
  access                                = "Allow"
  protocol                              = "Tcp"
  source_port_range                     = "*"
  destination_port_range                = "443"
  source_address_prefix                 = "*"
  destination_address_prefix            = "AzureCloud"
  resource_group_name                   = var.TargetRG
  network_security_group_name           = azurerm_network_security_group.AzureBastionNSG.name
}

resource "azurerm_network_security_rule" "Default_BastionSubnet_DenyVNetOut" {
  name                                  = "Default_BastionSubnet_DenyVNetOut"
  priority                              = 2510
  direction                             = "Outbound"
  access                                = "Deny"
  protocol                              = "Tcp"
  source_port_range                     = "*"
  destination_port_range                = "*"
  source_address_prefix                 = "*"
  destination_address_prefix            = "VirtualNetwork"
  resource_group_name                   = var.TargetRG
  network_security_group_name           = azurerm_network_security_group.AzureBastionNSG.name
}

resource "azurerm_network_security_rule" "Default_BastionSubnet_DenyInternetOut" {
  name                                  = "Default_BastionSubnet_DenyInternetOut"
  priority                              = 2520
  direction                             = "Outbound"
  access                                = "Deny"
  protocol                              = "*"
  source_port_range                     = "*"
  destination_port_range                = "*"
  source_address_prefix                 = "*"
  destination_address_prefix            = "Internet"
  resource_group_name                   = var.TargetRG
  network_security_group_name           = azurerm_network_security_group.AzureBastionNSG.name
}

###################################################################################
################################## Bastion ########################################
###################################################################################

# Azure Bastion

resource "azurerm_public_ip" "BastionPublicIP" {
  name                                  = "bst-pubip"
  location                              = var.TargetLocation
  resource_group_name                   = var.TargetRG
  allocation_method                     = "Static"
  sku                                   = "standard"
  domain_name_label                     = "bst-pubip${lower(var.VNetSuffix)}"


  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Project                             = var.Project
    Environment                         = var.Environment
    ManagedBy                           = "Terraform"
  }
}


#Diagnostic settings on the Bastion pip

resource "azurerm_monitor_diagnostic_setting" "AZBastionPIPDiag" {
  name                                  = "${azurerm_public_ip.BastionPublicIP.name}diag"
  target_resource_id                    = azurerm_public_ip.BastionPublicIP.id
  storage_account_id                    = data.azurerm_storage_account.STASubLog.id
  log_analytics_workspace_id            = data.azurerm_log_analytics_workspace.LawSubLog.id

  log {
    category                            = "DDoSProtectionNotifications"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "DDoSMitigationFlowLogs"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  log {
    category                            = "DDoSMitigationReports"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }

  metric {
    category                            = "AllMetrics"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    }    

  }
}

resource "azurerm_bastion_host" "SpokeBastion" {
  name                                  = "bst${lower(var.VNetSuffix)}"
  location                              = var.TargetLocation
  resource_group_name                   = var.TargetRG

  ip_configuration {
    name                                = "bst-ipconfig${lower(var.VNetSuffix)}"
    subnet_id                           = azurerm_subnet.AzBastionmanagedSubnet.id
    public_ip_address_id                = azurerm_public_ip.BastionPublicIP.id
  }

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Project                             = var.Project
    Environment                         = var.Environment
    ManagedBy                           = "Terraform"
  }

}

resource "azurerm_monitor_diagnostic_setting" "AZBastionDiag" {
  name                                  = "${azurerm_bastion_host.SpokeBastion.name}diag"
  target_resource_id                    = azurerm_bastion_host.SpokeBastion.id
  storage_account_id                    = data.azurerm_storage_account.STASubLog.id
  log_analytics_workspace_id            = data.azurerm_log_analytics_workspace.LawSubLog.id

  log {
    category                            = "BastionAuditLogs"
    enabled                             = true
    retention_policy {
      enabled                           = true
      days                              = 365
    } 
  }


}

