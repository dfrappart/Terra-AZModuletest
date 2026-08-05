
locals {

  TargetLocation                    = var.TargetLocation == "" ? data.azurerm_resource_group.TargetRg.location : var.TargetLocation
  AsgId                             = var.CreateAsg ? azurerm_application_security_group.AsgVm[0].id : var.AsgId
  VMIdentityType                    = length(var.UAIIds) > 0 ? "SystemAssigned,UserAssigned" : "SystemAssigned"
  DataDiskEncryptionSetId           = null
  OSDiskEncryptionSetId             = var.OSDiskEncryptionSetId != null ? var.OSDiskEncryptionSetId : (var.CreateOSDiskDiskEncryptionSet ? azurerm_disk_encryption_set.OsDiskEncryptionSet[0].id : null)
  CreateOSDiskDiskEncryptionSet     = null
  CreateDataDiskDiskEncryptionSet   = null
  OSDiskEncryptionSetIdIdentityType = length(var.OSDiskEncryptionSetUAIIds) > 0 ? "SystemAssigned, UserAssigned" : "SystemAssigned"
  DataDisks = { for k, v in var.Datadisks :
    v.Name => {
      Name                                      = v.Name
      CreateOption                              = v.CreateOption
      DiskSizeGb                                = v.DiskSizeGb
      StorageType                               = v.StorageType
      LunNumber                                 = v.LunNumber
      DiskCaching                               = v.DiskCaching
      EncryptionSetId                           = v.EncryptionSetId
      CreateDiskEncryptionSet                   = v.CreateDiskEncryptionSet
      KeyVaultKeyId                             = v.KeyVaultKeyId
      DesUaiId                                  = v.DesUaiId
      DataDiskEncryptionSetIdentityType         = v.DataDiskEncryptionSetIdentityType
      IsDiskEncryptionSetAutoKeyRotationEnabled = v.IsDiskEncryptionSetAutoKeyRotationEnabled
    }

  }




}