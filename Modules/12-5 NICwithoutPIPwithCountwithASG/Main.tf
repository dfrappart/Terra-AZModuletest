##############################################################
#This module allows the creation of VMs NICs without Public IP
#With ASG
##############################################################


# NIC Creation 

resource "azurerm_network_interface" "TerraNICnopipwithcountLoadBalanced" {
  count                         = "${var.IsLoadBalanced ? var.NICcount : 0}"
  name                          = "${var.NICName}${count.index+1}"
  location                      = "${var.NICLocation}"
  resource_group_name           = "${var.RGName}"
  
  ip_configuration {
    name                                    = "ConfigIP-NIC${var.NICName}${count.index+1}"
    subnet_id                               = "${var.SubnetId}"
    private_ip_address_allocation           = "dynamic"
    load_balancer_backend_address_pools_ids = ["${element(var.LBBackEndPoolid,count.index)}"]
    application_security_group_ids          = ["${var.ASGIds}"]

  }

    tags {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}

resource "azurerm_network_interface" "TerraNICnopipwithcountNotLoadBalanced" {
  count               = "${var.IsLoadBalanced ? 0 : var.NICcount}"
  name                = "${var.NICName}${count.index+1}"
  location            = "${var.NICLocation}"
  resource_group_name = "${var.RGName}"

  ip_configuration {
    name                          = "ConfigIP-NIC${var.NICName}${count.index+1}"
    subnet_id                     = "${var.SubnetId}"
    private_ip_address_allocation = "dynamic"
    application_security_group_ids = ["${var.ASGIds}"]
  }

    tags {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}

