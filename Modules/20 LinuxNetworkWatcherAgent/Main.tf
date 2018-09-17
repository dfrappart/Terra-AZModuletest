###################################################################################
#This module allows the creation of a Network Watcher Agent
###################################################################################



resource "azurerm_virtual_machine_extension" "Terra-NEtworkWatcherLinuxAgent" {
  count                = "${var.AgentCount}"
  name                 = "${var.AgentName}${count.index+1}"
  location             = "${var.AgentLocation}"
  resource_group_name  = "${var.AgentRG}"
  virtual_machine_name = "${element(var.VMName,count.index)}"
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"

  settings = <<SETTINGS
        {   
        
        
        "commandToExecute": ""
        }
SETTINGS

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}


