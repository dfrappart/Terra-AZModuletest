##############################################################
#This module allows the creation of a S2S Connection
##############################################################


output "Id" {
  value = "${azurerm_virtual_network_gateway_connection.TerraS2SConnect.id}"
}
