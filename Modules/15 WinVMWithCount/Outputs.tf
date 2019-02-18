###################################################################################
#This module allows the creation of 1 Windows VM with 1 NIC
###################################################################################


output "Name" {
  value = ["${azurerm_virtual_machine.TerraVMwithCount.*.name}"]
}

output "Id" {
  value = ["${azurerm_virtual_machine.TerraVMwithCount.*.id}"]
}

output "VMWithoutDataDiskNames" {
  value = ["${azurerm_virtual_machine.VMwithCountWithoutDataDisk.*.name}"]
}

output "VMWithoutDataDiskIds" {
  value = ["${azurerm_virtual_machine.VMwithCountWithoutDataDisk.*.id}"]
}