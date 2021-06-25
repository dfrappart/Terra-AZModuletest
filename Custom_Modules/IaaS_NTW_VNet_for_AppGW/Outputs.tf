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
  value                       = var.IsBastionEnabled ? azurerm_subnet.AzBastionmanagedSubnet[0] : var.DefaultBastionDisabledOutput
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
  value                       = var.IsBastionEnabled ? azurerm_network_security_group.AzureBastionNSG[0] : var.DefaultBastionDisabledOutput
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
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_FESubnet_AllowRDPSSHFromBastion : var.DefaultBastionDisabledOutput
}

output "Default_FESubnet_AllowLBFullOutput" {
  value                       = azurerm_network_security_rule.Default_FESubnet_AllowLB
}

output "Default_FESubnet_DenyVNetSSHRDPInFullOutput" {
  value                       = azurerm_network_security_rule.Default_FESubnet_DenyVNetSSHRDPIn
}

output "Default_BESubnet_AllowRDPSSHFromBastionFullOutput" {
  value                       = var.DefaultBastionDisabledOutput ? azurerm_network_security_rule.Default_BESubnet_AllowRDPSSHFromBastion : var.DefaultBastionDisabledOutput
}

output "Default_BESubnet_AllowLBFullOutput" {
  value                       = azurerm_network_security_rule.Default_BESubnet_AllowLB
}

output "Default_AppGWSubnet_GatewayManagerFullOutput" {
  value                       = azurerm_network_security_rule.Default_AppGWSubnet_GatewayManager
}

output "Default_BastionSubnet_AllowHTTPSBastionInFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_BastionSubnet_AllowHTTPSBastionIn[0] : var.DefaultBastionDisabledOutput
}

output "Default_BastionSubnet_AllowGatewayManagerFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_BastionSubnet_AllowGatewayManager[0] : var.DefaultBastionDisabledOutput
}

output "Default_BastionSubnet_AllowRemoteBastionOutFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_BastionSubnet_AllowRemoteBastionOut[0] : var.DefaultBastionDisabledOutput
}

output "Default_AllowAzureCloudHTTPSOutOutFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_AllowAzureCloudHTTPSOut[0] : var.DefaultBastionDisabledOutput
}

output "Default_BastionSubnet_DenyVNetOutFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_BastionSubnet_DenyVNetOut[0] : var.DefaultBastionDisabledOutput
}

output "Default_BastionSubnet_DenyInternetOutFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_rule.Default_BastionSubnet_DenyInternetOut[0] : var.DefaultBastionDisabledOutput
}


##############################################################
#Output for Diagnostic logs

output "AzureBastionNSGDiagFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_monitor_diagnostic_setting.AzureBastionNSGDiag[0] : var.DefaultBastionDisabledOutput
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
  value                       = var.IsBastionEnabled ? azurerm_network_watcher_flow_log.AzureBastionNSGFlowLog[0] : var.DefaultBastionDisabledOutput
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
  value                       = var.IsBastionEnabled ? azurerm_bastion_host.SpokeBastion[0] : var.DefaultBastionDisabledOutput
  sensitive                   = true
}

output "SpokeBastionPubIPFullOutput" {
  value                       = var.IsBastionEnabled ? azurerm_public_ip.BastionPublicIP[0] : var.DefaultBastionDisabledOutput
  sensitive                   = true
}