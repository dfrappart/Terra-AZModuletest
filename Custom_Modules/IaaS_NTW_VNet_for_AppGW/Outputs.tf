##############################################################
#module outputs
##############################################################

##############################################################
#Output Log analytics workspace

output "LAWFullOutput" {
  value                       = data.azurerm_log_analytics_workspace.LawSubLog
  sensitive                   = true
}


##############################################################
#Output for the VNet

output "VNetFullOutput" {
  value                       = azurerm_virtual_network.SpokeVNet
  sensitive                   = true
}

##############################################################
# Subnet outputs

# Subnet Bastion

output "AzureBastionSubnetFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_subnet.AzBastionmanagedSubnet : "No Bastion Enabled"
  sensitive                   = false
}

# Subnet AppGW

output "AGWSubnetFullOutput" {
  value                       = azurerm_subnet.AppGWSubnet
  sensitive                   = false
}

# Subnet FESubnet

output "FESubnetFullOutput" {
  value                       = azurerm_subnet.FESubnet
  sensitive                   = false
}

# Subnet BESubnet

output "BESubnetFullOutput" {
  value                       = azurerm_subnet.BESubnet
  sensitive                   = false
}

##############################################################
#Outout for NSG

# NSG Bastion Subnet

output "AzureBastionNSGFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_group.AzureBastionNSG : "No Bastion Enabled"
  sensitive                   = false
}

# NSG AppGW Subnet

output "AGWSubnetNSGFullOutput" {
  value                       = azurerm_network_security_group.AppGWSubnetNSG
  sensitive                   = false
}

# NSG FE Subnet

output "FESubnetNSGFullOutput" {
  value                       = azurerm_network_security_group.FESubnetNSG
  sensitive                   = false
}

# NSG BE Subnet

output "BESubnetNSGFullOutput" {
  value                       = azurerm_network_security_group.BESubnetNSG
  sensitive                   = false
}

######################################################
#NSG Rules outputs

output "Default_FESubnet_AllowRDPSSHFromBastionFullOutput" {
  value                       = azurerm_network_security_rule.Default_FESubnet_AllowRDPSSHFromBastion
}

output "Default_FESubnet_AllowLBFullOutput" {
  value                       = azurerm_network_security_rule.Default_FESubnet_AllowLB
}

output "Default_FESubnet_DenyVNetSSHRDPInFullOutput" {
  value                       = azurerm_network_security_rule.Default_FESubnet_DenyVNetSSHRDPIn
}

output "Default_BESubnet_AllowRDPSSHFromBastionFullOutput" {
  value                       = azurerm_network_security_rule.Default_BESubnet_AllowRDPSSHFromBastion
}

output "Default_BESubnet_AllowLBFullOutput" {
  value                       = azurerm_network_security_rule.Default_BESubnet_AllowLB
}

output "Default_AppGWSubnet_GatewayManagerFullOutput" {
  value                       = azurerm_network_security_rule.Default_AppGWSubnet_GatewayManager
}

output "Default_BastionSubnet_AllowHTTPSBastionInFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_BastionSubnet_AllowHTTPSBastionIn : "No Bastion Enabled"
}

output "Default_BastionSubnet_AllowGatewayManagerFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_BastionSubnet_AllowGatewayManager : "No Bastion Enabled"
}

output "Default_BastionSubnet_AllowRemoteBastionOutFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_BastionSubnet_AllowRemoteBastionOut : "No Bastion Enabled"
}

output "Default_AllowAzureCloudHTTPSOutOutFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_AllowAzureCloudHTTPSOut : "No Bastion Enabled"
}

output "Default_BastionSubnet_DenyVNetOutFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_BastionSubnet_DenyVNetOut : "No Bastion Enabled"
}

output "Default_BastionSubnet_DenyInternetOutFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_BastionSubnet_DenyInternetOut : "No Bastion Enabled"
}


##############################################################
#Output for Diagnostic logs

output "AzureBastionNSGDiagFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_monitor_diagnostic_setting.AzureBastionNSGDiag : "No Bastion Enabled"
}

# NSG AppGW Subnet

output "AppGWSubnetNSGDiagFullOutput" {
  value                       = azurerm_monitor_diagnostic_setting.AppGWSubnetNSGDiag
}

# NSG FE Subnet

output "FESubnetNSGDiagFullOutput" {
  value                       = azurerm_monitor_diagnostic_setting.FESubnetNSGDiag
}


# NSG BE Subnet

output "BESubnetNSGDiagFullOutput" {
  value                       = azurerm_monitor_diagnostic_setting.BESubnetNSGDiag
}

##############################################################
#Output for Flowlogs

output "AzureBastionNSGFlowLogFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_watcher_flow_log.AzureBastionNSGFlowLog : "No Bastion Enabled"
}

# NSG AppGW Subnet

output "AppGWSubnetNSGFlowLogFullOutput" {
  value                       = azurerm_network_watcher_flow_log.AppGWSubnetNSGFlowLog
}

# NSG FE Subnet

output "FESubnetNSGFlowLogFullOutput" {
  value                       = azurerm_network_watcher_flow_log.FESubnetNSGFlowLog
}

# NSG BE Subnet

output "BESubnetNSGFlowLogFullOutput" {
  value                       = azurerm_network_watcher_flow_log.BESubnetNSGFlowLog
}

##############################################################
#Output for Bastion Host

output "SpokeBastionFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_bastion_host.SpokeBastion : "No Bastion Enabled"
  sensitive                   = true
}

output "SpokeBastionPubIPFullOutput" {
  value                       = var.IsBastionEnabled ?azurerm_public_ip.BastionPublicIP : "No Bastion Enabled"
  sensitive                   = true
}