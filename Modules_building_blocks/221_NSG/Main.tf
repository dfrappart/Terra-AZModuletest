##############################################################
#This module allows the creation of a Netsork Security Group
##############################################################



#Creation fo the NSG
resource "azurerm_network_security_group" "NSG" {
  name                                  = "nsg${var.NSGSuffix}"
  location                              = var.NSGLocation
  resource_group_name                   = var.RGName

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Environment                         = var.EnvironmentTag
    Project                             = var.Project
    ManagedBy                           = "Terraform"
  }
}

resource "azurerm_subnet_network_security_group_association" "Subnet_NSG_Association" {
    
  #conditional on count depending on SubnetId value
  count                               = can(SubnetId) ? 1 : 0
  subnet_id                           = var.SubnetId
  network_security_group_id           = azurerm_network_security_group.NSG.id

}

resource "azurerm_network_interface_network_security_group_association" "Nic_NSG_Association" {

  #conditional on count depending on SubnetId value
  count                               = can(NICId) ? 1 : 0  
  
  network_interface_id                = var.NICId
  network_security_group_id           = azurerm_network_security_group.NSG.id
}