###################################################################################
#This module allows the creation of n Linux VM with 1 NIC
###################################################################################


output "Name" {
  value = ["${azurerm_virtual_machine.TerraVMwithCountWithAZ.*.name}"]
}

output "Id" {
  value = ["${azurerm_virtual_machine.TerraVMwithCountWithAZ.*.id}"]
}

output "VMWithoutDataDiskNames" {
  value = ["${azurerm_virtual_machine.TerraVMwithCountithAZWithoutDataDisk.*.name}"]
}

output "VMWithoutDataDiskIds" {
  value = ["${azurerm_virtual_machine.TerraVMwithCountithAZWithoutDataDisk.*.id}"]
}

output "RGName" {
  value = "${var.VMRG}"
}
