##############################################################
#This module allows the creation of VMs NICs without Public IP
##############################################################



# NIC Creation 

resource "azurerm_network_interface" "TerraNICnopipwithcountLoadBalanced" {
  count               = "${var.IsLoadBalanced ? var.NICcount : 0}"
  name                = "${var.NICName}${count.index+1}"
  location            = "${var.NICLocation}"
  resource_group_name = "${var.RGName}"

  ip_configuration {
    name                                    = "ConfigIP-NIC${var.NICName}${count.index+1}"
    subnet_id                               = "${var.SubnetId}"
    private_ip_address_allocation           = "dynamic"
    load_balancer_backend_address_pools_ids = ["${element(var.LBBackEndPoolid,count.index)}"]
  }

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
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
  }

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

