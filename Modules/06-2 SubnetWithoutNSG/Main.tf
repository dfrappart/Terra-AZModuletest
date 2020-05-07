##############################################################
#This module allows the creation of a Subnet Gateway
##############################################################


#Creation fo the subnet

resource "azurerm_subnet" "TerraSubnet" {



    name                        = var.SubnetName
    resource_group_name         = var.RGName
    virtual_network_name        = var.VNetName
    address_prefixes            = var.Subnetaddressprefix
    service_endpoints           = var.SVCEP




}

