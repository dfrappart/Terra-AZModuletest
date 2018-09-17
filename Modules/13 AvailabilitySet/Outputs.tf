##############################################################
#This module allows the creation of an availability set for VMs
##############################################################


#Output

output "Name" {
  value = "${azurerm_availability_set.TerraAS.name}"
}

output "Id" {
  value = "${azurerm_availability_set.TerraAS.id}"
}

output "RGName" {
  value = "${azurerm_availability_set.TerraAS.resource_group_name}"
}
