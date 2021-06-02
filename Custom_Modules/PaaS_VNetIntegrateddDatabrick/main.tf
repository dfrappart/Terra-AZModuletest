
######################################################
# Module VNET + DTB Workspace
######################################################



# Creating VNet

resource "azurerm_virtual_network" "VNet" {
  name                                  = "vnt${var.VNetSuffix}"
  resource_group_name                   = var.TargetRG
  address_space                         = var.VNetAddressSpace
  location                              = var.AzureRegion

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Environment                         = var.Environment
    Project                             = var.Project
    ManagedBy                           = "Terraform"

  }
}

resource "azurerm_monitor_diagnostic_setting" "VNetDiag" {
  name                                  = "diag-${azurerm_virtual_network.VNet.name}"
  target_resource_id                    = azurerm_virtual_network.VNet.id
  storage_account_id                    = var.STALogId
  log_analytics_workspace_id            = var.LawLogId

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

# Creating Subnet

resource "azurerm_subnet" "Subnet" {
  count                                 = length(var.SubnetNames)
  name                                  = "sub-${element(var.SubnetNames,count.index)}"
  resource_group_name                   = var.TargetRG
  virtual_network_name                  = azurerm_virtual_network.VNet.name
  address_prefixes                      = var.Subnetaddressprefix[0] == "default" ? [cidrsubnet(var.VNetAddressSpace[0],1,count.index)] : [element(var.Subnetaddressprefix,count.index)]
  service_endpoints                     = var.SVCEP
  delegation {
    name                                = "${element(var.SubnetNames,count.index)}delegation"
    
    service_delegation {
      name                              = "Microsoft.Databricks/workspaces"
    }
  }

}

resource "azurerm_subnet_network_security_group_association" "Subnet_NSG_Association" {
  count                                 = length(var.SubnetNames)
  subnet_id                             = element(azurerm_subnet.Subnet.*.id,count.index)
  network_security_group_id             = element(azurerm_network_security_group.NSG.*.id,count.index)
}

# Creating Creating NSG

resource "azurerm_network_security_group" "NSG" {
  count                                 = length(var.SubnetNames)
  name                                  = "nsg-${element(var.SubnetNames,count.index)}"
  location                              = var.AzureRegion
  resource_group_name                   = var.TargetRG

  tags = {
    ResourceOwner                         = var.ResourceOwnerTag
    Country                               = var.CountryTag
    CostCenter                            = var.CostCenterTag
    Environment                           = var.Environment
    Project                               = var.Project
    ManagedBy                             = "Terraform"

  }
}

#Diagnostic settings on the nsg

resource "azurerm_monitor_diagnostic_setting" "NSGDiag" {
  count                                 = length(var.SubnetNames)
  name                                  = "diag-nsg-${element(var.SubnetNames,count.index)}"
  target_resource_id                    = azurerm_network_security_group.NSG[count.index].id
  storage_account_id                    = var.STALogId
  log_analytics_workspace_id            = var.LawLogId

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

#Flow Logs on NSG

resource "azurerm_network_watcher_flow_log" "SubnetNSGFlowLog" {
  count                                 = length(var.SubnetNames)
  network_watcher_name                  = var.NetworkWatcherName
  resource_group_name                   = var.NetworkWatcherRGName
  network_security_group_id             = azurerm_network_security_group.NSG[count.index].id
  storage_account_id                    = var.STALogId
  enabled                               = true
  version                               = 2

  retention_policy {
    enabled                             = true
    days                                = 365
  }

  traffic_analytics {
    enabled                             = true
    workspace_id                        = var.LawLogWorkspaceId
    workspace_region                    = var.LawLogLocation
    workspace_resource_id               = var.LawLogId
    interval_in_minutes                 = 10
  }
}

# Creating DTB Workspace

resource "azurerm_databricks_workspace" "DTBWS" {
  name                                    = "dtbw${substr(lower(var.DTBWSSuffix),0,30)}"
  location                                = var.AzureRegion
  resource_group_name                     = var.TargetRG
  sku                                     = var.DTBWSSku
  custom_parameters {
    no_public_ip                          = var.DTBWSPIP
    virtual_network_id                    = azurerm_virtual_network.VNet.id
    public_subnet_name                    = element(azurerm_subnet.Subnet.*.name,0)
    private_subnet_name                   = element(azurerm_subnet.Subnet.*.name,1)

  }
    
  tags = {
    ResourceOwner                         = var.ResourceOwnerTag
    Country                               = var.CountryTag
    CostCenter                            = var.CostCenterTag
    Environment                           = var.Environment
    Project                               = var.Project
    ManagedBy                             = "Terraform"
  }
}

