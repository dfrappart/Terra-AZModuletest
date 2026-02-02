
###################################################################################
######################################### VM #####################################
###################################################################################

resource "azurerm_windows_virtual_machine" "VM" {

  lifecycle {
    ignore_changes = [
      #Ignore change for node count since it is autoscaling
      admin_password,
      custom_data

    ]
  }



  admin_username             = var.VmAdminName
  admin_password             = var.VmAdminPassword
  location                   = var.TargetLocation
  name                       = "avm-${lower(var.VMSuffix)}"
  network_interface_ids      = [azurerm_network_interface.VMNIC.id]
  computer_name              = substr("avm-${lower(var.VMSuffix)}", 0, 14)
  resource_group_name        = var.TargetRg
  size                       = var.VmSize
  zone                       = var.IsDeploymentZonal ? var.Zone : null
  provision_vm_agent         = var.ProvisionVMAgent
  allow_extension_operations = var.AllowExtensionOperations
  #vm_agent_platform_updates_enabled = var.VmAgentPlatformUpdateEnabled
  vtpm_enabled                 = var.IsVTPMEnabled
  virtual_machine_scale_set_id = var.ScaleSetId


  os_disk {
    caching                   = var.OSDiskCaching
    storage_account_type      = var.OSDiskTier
    disk_size_gb              = var.OSDiskSize
    name                      = "hdd-osdisk-${lower(var.VMSuffix)}"
    disk_encryption_set_id    = var.DiskEncryptionSetId
    write_accelerator_enabled = var.IsWriteAccelaratorEnabled
  }


  custom_data = var.CustomDataScriptPath

  user_data = var.UserDataScriptPath


  boot_diagnostics {

    storage_account_uri = var.STABlobURI
  }

  timezone = var.DefaultTimeZone

  source_image_reference {
    publisher = var.VMImagePublisherName
    offer     = var.VMImageOfferName
    sku       = var.VMImageSku
    version   = "latest"
  }


  identity {
    type         = var.VMIdentityType
    identity_ids = var.UAIIds
  }

  additional_capabilities {
    ultra_ssd_enabled = var.UlTraSSDEnabled
  }

  tags = merge(var.DefaultTags, var.ExtraTags)
}