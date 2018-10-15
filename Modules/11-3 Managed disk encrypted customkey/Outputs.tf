###################################################################
#This module allows the creation of a Managed disk with count option
###################################################################


#Output

output "Names" {
  value = ["${azurerm_managed_disk.TerraManagedDiskwithcount.*.name}"]
}

output "Ids" {
  value = ["${azurerm_managed_disk.TerraManagedDiskwithcount.*.id}"]
}

output "Sizes" {
  value = ["${azurerm_managed_disk.TerraManagedDiskwithcount.*.disk_size_gb}"]
}

output "RGName" {
  value = "${var.RGName}"
}
