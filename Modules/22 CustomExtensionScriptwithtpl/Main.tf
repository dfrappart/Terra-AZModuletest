###################################################################################
#This module allows the creation of a CustomLinuxExtension and use a template for 
#the JSON part
###################################################################################


#Resource Creation

data "template_file" "customscripttemplate" {
  template = "${file("${path.root}${var.SettingsTemplatePath}")}"
}

resource "azurerm_virtual_machine_extension" "Terra-CustomScriptAgent" {
  count                = "${var.AgentCount}"
  name                 = "${var.AgentName}${count.index+1}"
  location             = "${var.AgentLocation}"
  resource_group_name  = "${var.AgentRG}"
  virtual_machine_name = "${element(var.VMName,count.index)}"
  publisher            = "${var.AgentPublisher}"
  type                 = "${var.AgentType}"
  type_handler_version = "${var.Agentversion}"

  settings = "${data.template_file.customscripttemplate.rendered}"

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}


