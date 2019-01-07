##############################################################
#This module allows the creation of a Network Security Group association
##############################################################



#Creation of the NSG association
resource "azurerm_network_security_group_association" "TerraNSGAssociation" {
  subnet_id                           = "${var.SubnetId}"
  azurerm_network_security_group_id   = "${var.NSGId}"

}

