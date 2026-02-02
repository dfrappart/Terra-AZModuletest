##############################################################
#module outputs
##############################################################




##############################################################
#Output for the NICs

output "VMNICFull" {
  value = azurerm_network_interface.VMNIC
}

output "VMNICName" {
  value = azurerm_network_interface.VMNIC.name
}

output "VMNICId" {
  value = azurerm_network_interface.VMNIC.id
}


output "VMNICMAC" {
  value = azurerm_network_interface.VMNIC.mac_address
}

output "VMNICPrivateIP" {
  value = azurerm_network_interface.VMNIC.private_ip_address
}

output "VMNICInternalDNS" {
  value = azurerm_network_interface.VMNIC.internal_domain_name_suffix
}


##############################################################
# Data Disks outputs

/*
output "VMDataDiskName" {
  value = azurerm_managed_disk.VMDataDisk.name
}

output "VMDataDiskId" {
  value = azurerm_managed_disk.VMDataDisk.id
}

output "VMDataDiskSize" {
  value = azurerm_managed_disk.VMDataDisk.disk_size_gb
}
*/
##############################################################
#Outout for VMs

output "VMFull" {
  value = azurerm_linux_virtual_machine.VM
}

output "VMName" {
  value = azurerm_linux_virtual_machine.VM.name
}

output "VMId" {
  value = azurerm_linux_virtual_machine.VM.id
}

output "VMIdentity" {
  value = azurerm_linux_virtual_machine.VM.identity
}

output "VMPrivateIP" {
  value = azurerm_linux_virtual_machine.VM.private_ip_address
}

output "VM_VMID" {
  value = azurerm_linux_virtual_machine.VM.virtual_machine_id
}
