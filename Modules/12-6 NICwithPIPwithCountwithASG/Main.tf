##############################################################
#This module allows the creation of VMs NICs with Public Ip
#And associated ASG
##############################################################



# NIC Creation 

resource "azurerm_network_interface" "TerraNICwpip" {
  count               = "${var.NICCount}"
  name                = "${var.NICName}${count.index+1}"
  location            = "${var.NICLocation}"
  resource_group_name = "${var.RGName}"

  ip_configuration {
    name                           = "ConfigIP-NIC-${var.NICName}"
    subnet_id                      = "${var.SubnetId}"
    private_ip_address_allocation  = "dynamic"
    public_ip_address_id           = "${element(var.PublicIPId,count.index)}"
    primary                        = "${var.Primary}"
    application_security_group_ids = ["${var.ASGIds}"]
  }

    tags {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}

