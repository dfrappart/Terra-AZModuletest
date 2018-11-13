##############################################################
#This module allows the creation of an availability set for VMs
##############################################################


# Availability Set Creation

resource "azurerm_availability_set" "TerraAS" {
  name                        = "${var.ASName}"
  location                    = "${var.ASLocation}"
  managed                     = "true"
  resource_group_name         = "${var.RGName}"
  platform_fault_domain_count = "${var.FaultDomainCount}"

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

