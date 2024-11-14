######################################################################
# This module create a Windows VM
######################################################################




###################################################################################
############################## NIC creation #######################################
###################################################################################


resource "azurerm_network_interface" "VMNIC" {

  name                = "nic-${lower(var.VMSuffix)}"
  resource_group_name = var.TargetRG
  location            = var.TargetLocation

  ip_configuration {
    name                          = "ipconfig-nic-${lower(var.VMSuffix)}"
    subnet_id                     = var.TargetSubnetId
    private_ip_address_allocation = "Dynamic"

  }

  tags = merge(var.DefaultTags, var.ExtraTags)
}

#Diagnostic settings on NIC

resource "azurerm_monitor_diagnostic_setting" "VMNICDiag" {
  name                       = "diag-${azurerm_network_interface.VMNIC.name}"
  target_resource_id         = azurerm_network_interface.VMNIC.id
  storage_account_id         = var.STALogId
  log_analytics_workspace_id = var.LawLogId

  metric {
    category = "AllMetrics"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 365
    }

  }
}


###################################################################################
############################## ASG creation #######################################
###################################################################################

resource "azurerm_application_security_group" "ASGVM" {
  name                = "asg-${lower(var.VMSuffix)}"
  location            = var.TargetLocation
  resource_group_name = var.TargetRG

  tags = merge(var.DefaultTags, var.ExtraTags)
}

###################################################################################
############################## ASG association ####################################
###################################################################################

resource "azurerm_network_interface_application_security_group_association" "ASGVMAssociation" {
  network_interface_id          = azurerm_network_interface.VMNIC.id
  application_security_group_id = azurerm_application_security_group.ASGVM.id
}

###################################################################################
######################################### VM #####################################
###################################################################################
#
#data "template_file" "cloudconfig" {
#
#  template                              = file("${path.root}${var.CloudinitscriptPath}")
#}
#
##https://www.terraform.io/docs/providers/template/d/cloudinit_config.html
#data "template_cloudinit_config" "config" {
#  base64_encode                         = true
#
#  part {
#    content                             = data.template_file.cloudconfig.rendered
#  }
#}
#

resource "azurerm_windows_virtual_machine" "VM" {

  lifecycle {
    ignore_changes = [
      #Ignore change for node count since it is autoscaling
      admin_password

    ]
  }



  admin_username               = var.VmAdminName
  admin_password               = var.VmAdminPassword
  location                     = var.TargetLocation
  name                         = "avm-${lower(var.VMSuffix)}"
  network_interface_ids        = [azurerm_network_interface.VMNIC.id]
  computer_name                = substr("avm-${lower(var.VMSuffix)}", 0, 14)
  resource_group_name          = var.TargetRG
  size                         = var.VmSize
  zone                         = var.IsDeploymentZonal ? var.Zone : null
  provision_vm_agent           = var.ProvisionVMAgent
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


  #custom_data                           = data.template_cloudinit_config.config.rendered


  boot_diagnostics {

    storage_account_uri = var.STABlobURI
  }



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

###################################################################################
################################# Data disks ######################################
###################################################################################


resource "azurerm_managed_disk" "datadisk" {
  name                   = "hdd-datadisk-${lower(var.VMSuffix)}"
  location               = var.TargetLocation
  resource_group_name    = var.TargetRG
  storage_account_type   = var.DataDiskStorageType
  create_option          = var.DataDiskCreateOption
  disk_size_gb           = var.DataDiskSize
  zone                   = var.Zone
  disk_encryption_set_id = var.DataDiskEncryptionSetId

  tags = merge(var.DefaultTags, var.ExtraTags)

}

resource "azurerm_virtual_machine_data_disk_attachment" "AttachDataDisk" {
  managed_disk_id    = azurerm_managed_disk.datadisk.id
  virtual_machine_id = azurerm_windows_virtual_machine.VM.id
  lun                = "10"
  caching            = "ReadWrite"
}



/*
###################################################################################
############################## Agent for VMs ######################################
###################################################################################

resource "azurerm_virtual_machine_extension" "NetworkWatcherAgent" {
  name                                = "${azurerm_windows_virtual_machine.VM.name}-networkwatcheragent"
  virtual_machine_id                  = azurerm_windows_virtual_machine.VM.id
  publisher                           = "Microsoft.Azure.NetworkWatcher"
  type                                = "NetworkWatcherAgentWindows"
  type_handler_version                = 1.4
  auto_upgrade_minor_version          = true

  tags = {
        Company                       = var.Company
        Usage                         = var.UsageTag
        UsedBy                        = var.UsedByTag
        Managedby                     = var.ManagedbyTag
        Environment                   = var.Environment
        Uptime                        = var.Uptime
        TimeZone                      = var.TimeZone
        CostCenter                    = var.CostCenter
  } 

}

resource "azurerm_virtual_machine_extension" "DependencyAgent" {
  name                                  = "${azurerm_windows_virtual_machine.VM.name}-dependencyagent"
  virtual_machine_id                    = azurerm_windows_virtual_machine.VM.id
  publisher                             = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                                  = "DependencyAgentWindows"
  type_handler_version                  = 9.5
  auto_upgrade_minor_version            = true

  tags = {
        Company                       = var.Company
        Usage                         = var.UsageTag
        UsedBy                        = var.UsedByTag
        Managedby                     = var.ManagedbyTag
        Environment                   = var.Environment
        Uptime                        = var.Uptime
        TimeZone                      = var.TimeZone
        CostCenter                    = var.CostCenter
  } 

}

/*
resource "azurerm_virtual_machine_extension" "DiagnosticExtension" {
  for_each                              = toset(var.VMList)
  name                                  = "${azurerm_linux_virtual_machine.VM[each.key].name}-diagAgent"
  virtual_machine_id                    = azurerm_linux_virtual_machine.VM[each.key].id
  publisher                             = "Microsoft.Azure.Diagnostics"
  type                                  = "LinuxDiagnostic "
  type_handler_version                  = 3.0
  auto_upgrade_minor_version            = true

  settings = <<SETTINGS
      {   
 
      }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
      {   
    
      }
PROTECTED_SETTINGS

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Entity                              = var.EntityTag
    SectionAnalytic                     = var.SectionAnalyticTag
  } 

}
*/
/*

resource "azurerm_virtual_machine_extension" "LAWAgent" {
  name                                  = "${azurerm_windows_virtual_machine.VM.name}-lawAgent"
  virtual_machine_id                    = azurerm_windows_virtual_machine.VM.id
  publisher                             = "Microsoft.EnterpriseCloud.Monitoring"
  type                                  = "MicrosoftMonitoringAgent"
  type_handler_version                  = 1.0
  auto_upgrade_minor_version            = true

  settings = jsonencode({"workspaceId"= data.azurerm_log_analytics_workspace.LawSubLog.workspaceId})


  protected_settings = jsonencode({"workspaceKey"= data.azurerm_log_analytics_workspace.LawSubLog.primary_shared_key})
  
  tags = {
        Company                       = var.Company
        Usage                         = var.UsageTag
        UsedBy                        = var.UsedByTag
        Managedby                     = var.ManagedbyTag
        Environment                   = var.Environment
        Uptime                        = var.Uptime
        TimeZone                      = var.TimeZone
        CostCenter                    = var.CostCenter
  } 
}



/*
resource "azurerm_virtual_machine_extension" "CustomScriptExtension" {
  for_each                              = toset(var.VMList)
  name                                  = ""
  publisher                             = "Microsoft.Compute"
  type                                  = "CustomScriptExtension"
  type_handler_version                  = 1.10
  auto_upgrade_minor_version            = true

  settings = jsonencode({"commandToExecute"= "powershell.exe Move-Item -Path %SYSTEMDRIVE%\AzureData\CustomData.bin -Destination %SYSTEMDRIVE%\AzureData\bootscript.ps1;"})


  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Entity                              = var.EntityTag
    SectionAnalytic                     = var.SectionAnalyticTag
  } 

}

*/