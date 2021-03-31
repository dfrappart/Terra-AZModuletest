##############################################################
#This module allows the creation of a Subnet Gateway
##############################################################


#Creation fo the subnet

resource "azurerm_subnet" "Subnet" {

  name                        = "sub${lower(var.SubnetSuffix)}"
  resource_group_name         = var.RGName
  virtual_network_name        = var.VNetName
  address_prefixes            = var.Subnetaddressprefixes
  service_endpoints           = var.ServicesEP

  delegation {
    name = var.SubnetDelegationName

    service_delegation {
      name    = var.DelegationServiceName
      actions = var.DelegationServiceActionList
    }
  }
}


