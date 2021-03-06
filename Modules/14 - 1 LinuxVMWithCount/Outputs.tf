###################################################################################
#This module allows the creation of n Linux VM with 1 NIC
###################################################################################


output "Name" {
  value = ["${azurerm_virtual_machine.TerraVMwithCount.*.name}"]
}

output "Id" {
  value = ["${azurerm_virtual_machine.TerraVMwithCount.*.id}"]
}

output "VMWithoutDataDiskNames" {
  value = ["${azurerm_virtual_machine.TerraVMwithCountWithoutDataDisk.*.name}"]
}

output "VMWithoutDataDiskIds" {
  value = ["${azurerm_virtual_machine.TerraVMwithCountWithoutDataDisk.*.id}"]
}

output "RGName" {
  value = "${var.VMRG}"
}
