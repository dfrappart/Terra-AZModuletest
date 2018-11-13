##############################################################
#This module allows the creation of a Netsork Security Group Rule
##############################################################


# creation of the rule

resource "azurerm_network_security_rule" "Terra-NSGRulewSTags" {
  name                        = "${var.NSGRuleName}"
  priority                    = "${var.NSGRulePriority}"
  direction                   = "${var.NSGRuleDirection}"
  access                      = "${var.NSGRuleAccess}"
  protocol                    = "${var.NSGRuleProtocol}"
  source_port_range           = "${var.NSGRuleSourcePortRange}"
  destination_port_range      = "${var.NSGRuleDestinationPortRange}"
  source_address_prefix       = "${var.NSGRuleSourceAddressPrefix}"
  destination_address_prefix  = "${var.NSGRuleDestinationAddressPrefix}"
  resource_group_name         = "${var.RGName}"
  network_security_group_name = "${var.NSGReference}"
}

