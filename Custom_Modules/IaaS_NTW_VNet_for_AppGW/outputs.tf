##############################################################
# module outputs
##############################################################

##############################################################
# Output RG

output "RGName" {
  value = local.RgName
  sensitive = false
  description = "The name of the RG in which the resources are located"
}

##############################################################
#Output Log analytics workspace
/*
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

output "AzureBastionSubnetFullId" {
  value                       = var.IsBastionEnabled ? azurerm_subnet.AzBastionmanagedSubnet[0].id : "No bastion enabled"
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

output "AzureBastionNSGName" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_group.AzureBastionNSG[0].name : "BastionIsDisabled"
  sensitive                   = false
}

output "AzureBastionNSGId" {
  value                       = var.IsBastionEnabled ? azurerm_network_security_group.AzureBastionNSG[0].id : "BastionIsDisabled"
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

##############################################################
#Output for Bastion Host


output "SpokeBastionName" {
  value                       = var.IsBastionEnabled ? azurerm_bastion_host.SpokeBastion[0].name : "BastionDisabled"
  sensitive                   = true
}

output "SpokeBastionRG" {
  value                       = var.IsBastionEnabled ? azurerm_bastion_host.SpokeBastion[0].resource_group_name : "BastionDisabled"
  sensitive                   = true
}

output "SpokeBastionIpConfig" {
  value                       =  var.IsBastionEnabled ? azurerm_bastion_host.SpokeBastion[0].ip_configuration[0] : local.defaultIpConfigOutput
  sensitive                   = true
}

*/