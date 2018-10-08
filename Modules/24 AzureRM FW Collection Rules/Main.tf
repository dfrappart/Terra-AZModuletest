##############################################################
#This module allows the creation of FW collection rules
##############################################################


# FW rule collection creation

resource "azurerm_firewall_network_rule_collection" "TerraFirewallRuleCollec" {
  name                          = "${var.FWRuleCollecName}"
  azure_firewall_name           = "${var.FWName}"
  resource_group_name           = "${var.RGName}"
  priority                      = "${var.FWRuleCollecPriority}"
  action                        = "${var.FWRuleCollecAction}"

  rule {
    name                    = "${var.FWRuleName}"
    description             = "${var.FWRuleDesc}"
    source_addresses        = ["${var.FWRuleCollecSourceAddresses}"]
    destination_ports       = ["${var.FWRuleCollecDestPorts}"]
    destination_addresses   = ["${var.FWRuleCollecDestAddresses}"]
    protocols               = ["${var.FWRuleProtos}"]
  }


}

