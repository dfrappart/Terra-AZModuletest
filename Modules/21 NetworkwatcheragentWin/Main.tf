###################################################################################
#This module allows the creation of a Network Watcher Agent
###################################################################################



#Adding Networkwatcher agent

resource "azurerm_virtual_machine_extension" "Terra-NetworkWatcherAgentWin" {
  count                = "${var.AgentCount}"
  name                 = "${var.AgentName}${count.index+1}-NetworkWatcherAgentWin"
  location             = "${var.AgentLocation}"
  resource_group_name  = "${var.AgentRG}"
  virtual_machine_name = "${element(var.VMName,count.index)}"
  publisher            = "microsoft.azure.networkwatcher"
  type                 = "NetworkWatcherAgentWindows"
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
