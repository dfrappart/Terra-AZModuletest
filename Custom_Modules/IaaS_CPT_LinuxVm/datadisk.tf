
###################################################################################
################################# Data disks ######################################
###################################################################################


resource "azurerm_managed_disk" "DataDisk" {
  for_each             = var.Datadisks
  name                 = each.value.Name
  location             = local.TargetLocation
  resource_group_name  = var.TargetRg
  storage_account_type = each.value.StorageType
  create_option        = each.value.CreateOption
  disk_size_gb         = each.value.DiskSizeGb


}

resource "azurerm_virtual_machine_data_disk_attachment" "AttachDataDisk" {
  for_each           = var.Datadisks
  managed_disk_id    = azurerm_managed_disk.DataDisk[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.VM.id
  lun                = each.value.LunNumber
  caching            = each.value.DiskCaching
}

