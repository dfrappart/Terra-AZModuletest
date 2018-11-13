###################################################################################
#This module allows the creation of n Linux VM with 1 NIC
###################################################################################


output "Name" {
  value = ["${azurerm_virtual_machine.TerraVMwithCount.*.name}"]
}

output "Id" {
  value = ["${azurerm_virtual_machine.TerraVMwithCount.*.id}"]
}

output "RGName" {
  value = "${var.VMRG}"
}
