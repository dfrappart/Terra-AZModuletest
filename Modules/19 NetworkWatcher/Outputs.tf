##############################################################
#This module allows the creation of a NEtwork Watcher
##############################################################



#Output


output "Name" {

  value = "${azurerm_network_watcher.Terra_NW.name}"
}

output "Id" {

  value = "${azurerm_network_watcher.Terra_NW.id}"
}

