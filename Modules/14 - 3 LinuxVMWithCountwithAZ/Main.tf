###################################################################################
#This module allows the creation of n Linux VM with 1 NIC
###################################################################################


#VM Creation

resource "azurerm_virtual_machine" "TerraVMwithCountWithAZ" {
  count                 = "${var.WithDataDisk == "true"? var.VMCount : 0}"
  name                  = "${var.VMName}${count.index+1}"
  location              = "${var.VMLocation}"
  resource_group_name   = "${var.VMRG}"
  network_interface_ids = ["${element(var.VMNICid, count.index)}"]
  vm_size               = "${var.VMSize}"
  #availability_set_id   = "" no coexistence between AS and AZ
  zones                 = ["${var.VMCount > 1 ? element(var.AZ,count.index) : var.VMAZ}"]

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${var.DiagnosticDiskURI}"
  }

  storage_image_reference {
    #get appropriate image info with the following command
    #Get-AzureRmVMImageSku -Location westeurope -Offer windowsserver -PublisherName microsoftwindowsserver
    publisher = "${var.VMPublisherName}"

    offer   = "${var.VMOffer}"
    sku     = "${var.VMsku}"
    version = "latest"
  }

  storage_os_disk {
    name              = "${var.VMName}${count.index+1}-OSDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.VMStorageTier}"
  }

  storage_data_disk {
    name            = "${element(var.DataDiskName,count.index)}"
    managed_disk_id = "${element(var.DataDiskId,count.index)}"
    create_option   = "Attach"
    lun             = 0
    disk_size_gb    = "${element(var.DataDiskSize,count.index)}"
  }

  os_profile {
    computer_name  = "${var.VMName}"
    admin_username = "${var.VMAdminName}"
    admin_password = "${var.VMAdminPassword}"

    #custom_data     = "${file("${var.BootConfigScriptFileName}")}"
  }

  os_profile_linux_config {
    disable_password_authentication = "${var.PasswordDisabled}"

    ssh_keys {
      path     = "/home/${var.VMAdminName}/.ssh/authorized_keys"
      key_data = "${var.PublicSSHKey}"
    }
  }

  tags {
    Environment       = "${var.EnvironmentTag}"
    Usage             = "${var.EnvironmentUsageTag}"
    VMType            = "${var.VMTypeTag}"
    VMOS              = "${var.VMOSTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
    SLAUptime         = "${var.SLAUptimeTag}"

  }
}

resource "azurerm_virtual_machine" "TerraVMwithCountithAZWithoutDataDisk" {
  count                 = "${var.WithDataDisk == "false" ? var.VMCount : 0}"
  name                  = "${var.VMName}${count.index+1}"
  location              = "${var.VMLocation}"
  resource_group_name   = "${var.VMRG}"
  network_interface_ids = ["${element(var.VMNICid, count.index)}"]
  vm_size               = "${var.VMSize}"
  #availability_set_id   = "" no coexistence between AS and AZ
  zones                 = ["${var.VMCount > 1 ? element(var.AZ,count.index) : var.VMAZ}"]

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${var.DiagnosticDiskURI}"
  }

  storage_image_reference {
    #get appropriate image info with the following command
    #Get-AzureRmVMImageSku -Location westeurope -Offer windowsserver -PublisherName microsoftwindowsserver
    publisher = "${var.VMPublisherName}"

    offer   = "${var.VMOffer}"
    sku     = "${var.VMsku}"
    version = "latest"
  }

  storage_os_disk {
    name              = "${var.VMName}${count.index+1}-OSDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.VMStorageTier}"
  }
/*
  storage_data_disk {
    name            = "${element(var.DataDiskName,count.index)}"
    managed_disk_id = "${element(var.DataDiskId,count.index)}"
    create_option   = "Attach"
    lun             = 0
    disk_size_gb    = "${element(var.DataDiskSize,count.index)}"
  }
*/
  os_profile {
    computer_name  = "${var.VMName}"
    admin_username = "${var.VMAdminName}"
    admin_password = "${var.VMAdminPassword}"

    #custom_data     = "${file("${var.BootConfigScriptFileName}")}"
  }

  os_profile_linux_config {
    disable_password_authentication = "${var.PasswordDisabled}"

    ssh_keys {
      path     = "/home/${var.VMAdminName}/.ssh/authorized_keys"
      key_data = "${var.PublicSSHKey}"
    }
  }

  tags {
    environment       = "${var.EnvironmentTag}"
    usage             = "${var.EnvironmentUsageTag}"
    VMType            = "${var.VMTypeTag}"
    VMOS              = "${var.VMOSTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
    SLAUptime         = "${var.SLAUptimeTag}"

  }
}

