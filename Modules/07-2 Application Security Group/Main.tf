##############################################################
#This module allows the creation of an Application Security 
#Group
##############################################################


#Creation fo the ASG
resource "azurerm_application_security_group" "Terra-ASG" {
  name                = "${var.ASGName}"
  location            = "${var.ASGLocation}"
  resource_group_name = "${var.RGName}"

    tags {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}

