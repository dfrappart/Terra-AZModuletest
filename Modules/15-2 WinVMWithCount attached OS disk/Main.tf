###################################################################################
#This module allows the creation of 1 Windows VM with 1 NIC
###################################################################################


resource "azurerm_virtual_machine" "TerraVMwithCount" {
  count                 = "${var.VMCount}"
  name                  = "${var.VMName}${count.index+1}"
  location              = "${var.VMLocation}"
  resource_group_name   = "${var.VMRG}"
  network_interface_ids = ["${element(var.VMNICid,count.index)}"]
  vm_size               = "${var.VMSize}"
  availability_set_id   = "${var.ASID}"

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${var.DiagnosticDiskURI}"
  }


  storage_os_disk {
    name              = "${element(var.OSDiskName,count.index)}"
    caching           = "ReadWrite"
    create_option     = "Attach"
    managed_disk_id   = "${element(var.OSDiskId,count.index)}"
    disk_size_gb      = "${element(var.OSDiskSize,count.index)}"
    #os_type           = "Windows"

  }

  storage_data_disk {
    name            = "${element(var.DataDiskName,count.index)}"
    managed_disk_id = "${element(var.DataDiskId,count.index)}"
    create_option   = "Attach"
    lun             = 10
    disk_size_gb    = "${element(var.DataDiskSize,count.index)}"
  }

  os_profile {
    computer_name  = "${var.VMName}${count.index+1}"
    admin_username = "${var.VMAdminName}"
    admin_password = "${var.VMAdminPassword}"
    custom_data    = "${file("${path.root}${var.CloudinitscriptPath}")}"
  }

  os_profile_windows_config {
    provision_vm_agent        = "true"
    enable_automatic_upgrades = "false"
  }

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

#Adding BGInfo to VM

resource "azurerm_virtual_machine_extension" "Terra-BGInfoAgent" {
  count                = "${var.VMCount}"
  name                 = "${var.VMName}${count.index+1}BGInfo"
  location             = "${var.VMLocation}"
  resource_group_name  = "${var.VMRG}"
  virtual_machine_name = "${element(azurerm_virtual_machine.TerraVMwithCount.*.name,count.index)}"
  publisher            = "microsoft.compute"
  type                 = "BGInfo"
  type_handler_version = "2.1"

  /*
    settings = <<SETTINGS
          {   
          
          "commandToExecute": ""
          }
  SETTINGS
  */
  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}
