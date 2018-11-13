##############################################################
#This module allows the creation of an Application Security 
#Group
##############################################################


#Output for the ASG module

output "Name" {
  value = "${azurerm_application_security_group.Terra-ASG.name}"
}

output "Id" {
  value = "${azurerm_application_security_group.Terra-ASG.id}"
}

output "RGName" {
  value = "${azurerm_application_security_group.Terra-ASG.resource_group_name}"
}
