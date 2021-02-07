##############################################################
#module outputs
##############################################################

##############################################################
#Output for the storage account log

output "STALogsFullOutput" {
  value = data.azurerm_storage_account.STASubLog
}


##############################################################
#Output Log analytics workspace

output "LAWFullOutput" {
  value = data.azurerm_log_analytics_workspace.LawSubLog
}


##############################################################
#Output for the VNet

output "VNetFullOutput" {
  value = azurerm_virtual_network.SpokeVNet
}

##############################################################
# Subnet outputs

# Subnet Bastion

output "AzureBastionSubnetFullOutput" {
  value = azurerm_subnet.AzBastionmanagedSubnet
}

# Subnet AppGW

output "AGWSubnetFullOutput" {
  value = azurerm_subnet.AppGWSubnet
}

# Subnet FESubnet

output "FESubnetFullOutput" {
  value = azurerm_subnet.FESubnet
}

# Subnet BESubnet

output "BESubnetFullOutput" {
  value = azurerm_subnet.BESubnet
}

##############################################################
#Outout for NSG

# NSG Bastion Subnet

output "AzureBastionNSGFullOutput" {
  value = azurerm_network_security_group.AzureBastionNSG
}

# NSG AppGW Subnet

output "AGWSubnetNSGFullOutput" {
  value = azurerm_network_security_group.AppGWSubnetNSG
}

# NSG FE Subnet

output "FESubnetNSGFullOutput" {
  value = azurerm_network_security_group.FESubnetNSG
}

# NSG BE Subnet

output "BESubnetNSGFullOutput" {
  value = azurerm_network_security_group.BESubnetNSG
}

######################################################
#NSG Rules outputs

output "Default_FESubnet_AllowRDPSSHFromBastionFullOutput" {
  value = azurerm_network_security_rule.Default_FESubnet_AllowRDPSSHFromBastion
}

output "Default_FESubnet_AllowLBFullOutput" {
  value = azurerm_network_security_rule.Default_FESubnet_AllowLB
}

output "Default_FESubnet_DenyVNetSSHRDPInFullOutput" {
  value = azurerm_network_security_rule.Default_FESubnet_DenyVNetSSHRDPIn
}

output "Default_BESubnet_AllowRDPSSHFromBastionFullOutput" {
  value = azurerm_network_security_rule.Default_BESubnet_AllowRDPSSHFromBastion
}

output "Default_BESubnet_AllowLBFullOutput" {
  value = azurerm_network_security_rule.Default_BESubnet_AllowLB
}

output "Default_AppGWSubnet_GatewayManagerFullOutput" {
  value = azurerm_network_security_rule.Default_AppGWSubnet_GatewayManager
}

output "Default_BastionSubnet_AllowHTTPSBastionInFullOutput" {
  value = azurerm_network_security_rule.Default_BastionSubnet_AllowHTTPSBastionIn
}

output "Default_BastionSubnet_AllowGatewayManagerFullOutput" {
  value = azurerm_network_security_rule.Default_BastionSubnet_AllowGatewayManager
}

output "Default_BastionSubnet_AllowRemoteBastionOutFullOutput" {
  value = azurerm_network_security_rule.Default_BastionSubnet_AllowRemoteBastionOut
}

output "Default_AllowAzureCloudHTTPSOutOutFullOutput" {
  value = azurerm_network_security_rule.Default_AllowAzureCloudHTTPSOut
}

output "Default_BastionSubnet_DenyVNetOutFullOutput" {
  value = azurerm_network_security_rule.Default_BastionSubnet_DenyVNetOut
}

output "Default_BastionSubnet_DenyInternetOutFullOutput" {
  value = azurerm_network_security_rule.Default_BastionSubnet_DenyInternetOut
}


##############################################################
#Output for Diagnostic logs

output "AzureBastionNSGDiagFullOutput" {
  value = azurerm_monitor_diagnostic_setting.AzureBastionNSGDiag
}

# NSG AppGW Subnet

output "AppGWSubnetNSGDiagFullOutput" {
  value = azurerm_monitor_diagnostic_setting.AppGWSubnetNSGDiag
}

# NSG FE Subnet

output "FESubnetNSGDiagFullOutput" {
  value = azurerm_monitor_diagnostic_setting.FESubnetNSGDiag
}


# NSG BE Subnet

output "BESubnetNSGDiagFullOutput" {
  value = azurerm_monitor_diagnostic_setting.BESubnetNSGDiag
}

##############################################################
#Output for Flowlogs

output "AzureBastionNSGFlowLogFullOutput" {
  value = azurerm_network_watcher_flow_log.AzureBastionNSGFlowLog
}

# NSG AppGW Subnet

output "AppGWSubnetNSGFlowLogFullOutput" {
  value = azurerm_network_watcher_flow_log.AppGWSubnetNSGFlowLog
}

# NSG FE Subnet

output "FESubnetNSGFlowLogFullOutput" {
  value = azurerm_network_watcher_flow_log.FESubnetNSGFlowLog
}

# NSG BE Subnet

output "BESubnetNSGFlowLogFullOutput" {
  value = azurerm_network_watcher_flow_log.BESubnetNSGFlowLog
}

##############################################################
#Output for Bastion Host

output "SpokeBastionFullOutput" {
  value = azurerm_bastion_host.SpokeBastion
}
