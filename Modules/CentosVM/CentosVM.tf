###################################################################################
#This module allow the creation of CentOS VMs with associated NICs
# Those are 1 NIC VMS. Please use another module for VMs requireing more than 1 NIC
###################################################################################

#Variable declaration for Module

#The VM name
variable "CentOSVMName" {
  type    = "string"

}

#The VM count
variable "CentOSVMcount" {
  type    = "string"
  default = "1"

}

#The VM location
variable "CentOSVMLocation" {
  type    = "string"

}

#The RG in which the VMs are located
variable "CentOSVMRG" {
  type    = "string"

}


#The VM size
variable "CentOSVMSize" {
  type    = "string"
  default = "Standard_F1"

}

#The Availability set reference

variable "CentOSVMS-ASID" {
  type    = "string"
  
}

#The Managed Disk Storage tier

variable "CentOSVMStorageTier" {
  type    = "string"
  default = "Standard_LRS"
  
}

#The VM Admin Name

variable "CentOSVMAdminName" {
  type    = "string"
  default = "VMAdmin"
  
}

#The VM Admin Password

variable "CentOSVMAdminPassword" {
  type    = "string"
  
}

#The SSH key for Linux VM

variable "CentOSSSHKey" {
  type    = "string"
  
}

#CentOS Managed Data Disk size

variable "CentOSDataDiskSize" {
  type    = "string"
  default = "127"
  
}



#The subnet reference
variable "TargetSubnetId" {
  type    = "string"

}


variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}


#VM Creation


resource "azurerm_network_interface" "TerraNIC" {

    count                   = "${var.CentOSVMcount}"
    name                    = "NIC${var.CentOSVMName}${count.index +1}"
    location                = "${var.CentOSVMLocation}"
    resource_group_name     = "${var.CentOSVMRG}"

    ip_configuration {

        name                                        = "ConfigIP-NIC${count.index + 1}-${var.CentOSVMName}${count.index + 1}"
        subnet_id                                   = "${var.TargetSubnetId}"
        private_ip_address_allocation               = "dynamic"
        #public_ip_address_id                        = "${var.PublicIPId}"
            }

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   


}

resource "azurerm_managed_disk" "TerraManagedDisk" {

    count                   = "${var.CentOSVMcount}"
    name                    = "${var.CentOSVMName}DataDisk${count.index+1}"
    location                = "${var.CentOSVMLocation}"
    resource_group_name     = "${var.CentOSVMRG}"
    storage_account_type    = "${var.CentOSVMStorageTier}"
    create_option           = "empty"
    disk_size_gb            = "${var.CentOSDataDiskSize}"

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
    
}


resource "azurerm_virtual_machine" "TerraCentOSVM" {

    count                   = "${var.CentOSVMcount}"
    name                    = "${var.CentOSVMName}${count.index +1}"
    location                = "${var.CentOSVMLocation}"
    resource_group_name     = "${var.CentOSVMRG}"
    network_interface_ids   = ["${element(azurerm_network_interface.TerraNIC.*.id, count.index)}"]
    vm_size                 = "${var.CentOSVMSize}"
    availability_set_id     = "${var.CentOSVMS-ASID}"
    depends_on              = ["azurerm_network_interface.TerraNIC","azurerm_managed_disk.TerraManagedDisk"]


    storage_image_reference {

        publisher   = "Openlogic"
        offer       = "CentOS"
        sku         = "7.3"
        version     = "latest"

    }

    storage_os_disk {

        name                = "${var.CentOSVMName}${count.index + 1}"
        caching             = "ReadWrite"
        create_option       = "FromImage"
        managed_disk_type   = "${var.CentOSVMStorageTier}"

    }

    storage_data_disk {

        name                = "${element(azurerm_managed_disk.TerraManagedDisk.*.name, count.index)}"
        managed_disk_id     = "${element(azurerm_managed_disk.TerraManagedDisk.*.id, count.index)}"
        create_option       = "Attach"
        lun                 = 0
        disk_size_gb        = "${var.CentOSDataDiskSize}"
        

    }

    os_profile {

        computer_name   = "${var.CentOSVMName}${count.index + 1}"
        admin_username  = "${var.CentOSVMAdminName}"
        admin_password  = "${var.CentOSVMAdminPassword}"

    }

    os_profile_linux_config {
    
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.CentOSVMAdminName}/.ssh/authorized_keys"
      key_data = "${var.CentOSSSHKey}"
    }

    }

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   
    

}

#Output

output "Id" {

  value = "${azurerm_virtual_machine.TerraCentOSVM.id}"
}
