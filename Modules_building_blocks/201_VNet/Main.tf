##############################################################
#This module allows the creation of a VNet
##############################################################


#Creating a VNet

resource "azurerm_virtual_network" "VNet" {
  name                                        = "vnet${lower(var.VNetSuffix)}"
  resource_group_name                         = var.RGName
  address_space                               = var.VNetAddressSpace
  location                                    = var.VNetLocation
  dns_servers                                 = var.DNSServerList
  vm_protection_enabled                       = var.IsVMProtectionEnabled

  tags = {
    ResourceOwner                             = var.ResourceOwnerTag
    Country                                   = var.CountryTag
    CostCenter                                = var.CostCenterTag
    Environment                               = var.EnvironmentTag
    Project                                   = var.Project
    ManagedBy                                 = "Terraform" 
  }
}

