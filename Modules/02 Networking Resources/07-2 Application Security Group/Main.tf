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
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

