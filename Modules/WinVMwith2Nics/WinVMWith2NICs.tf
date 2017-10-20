###################################################################################
#This module allow the creation of VM with 2 NICs
###################################################################################

#Module variable

#The VM name
variable "VMName" {
  type    = "string"

}

#The VM Location
variable "VMLocation" {
  type    = "string"

}

#The VM ResourceGroup
variable "VMRG" {
  type    = "string"

}


#The VM Size
variable "VMSize" {
  type    = "string"

}

#The VM AS ID
variable "VM-ASID" {
  type    = "string"

}

#The VM Publisher
variable "VMPublisher" {
  type    = "string"

}

#The VM Offer
variable "VMOffer" {
  type    = "string"

}

#The VM sku
variable "VMSku" {
  type    = "string"

}

#The VM storage tier
variable "VMStorageTier" {
  type    = "string"

}

#The VM Datadisk Id
variable "VMDatadiskId" {
  type    = "string"

}

#The VM Datadisk Size
variable "VMDataDiskSize" {
  type    = "string"

}

# Variable defining VM Admin Name

variable "VMAdminName" {

    type    = "string"
    default = "vmadmin"
}

# Variable defining VM Admin password

variable "VMAdminPassword" {

    type    = "string"
    default = "Devoteam75!"
}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

#The public IP Reference

variable "PublicIPId" {
  type    = "string"

}

#The subnet reference
variable "SubnetId1" {
  type    = "string"

}

#The subnet reference
variable "SubnetId2" {
  type    = "string"

}

resource "azurerm_network_interface" "TerraNICwpip" {

 
    name                    = "PrimaryNIC"
    location                = "${var.VMLocation}"
    resource_group_name     = "${var.VMRG}"
      

    ip_configuration {

        name                                        = "ConfigIP-NIC-PrimaryNIC"
        subnet_id                                   = "${var.SubnetId1}"
        private_ip_address_allocation               = "dynamic"
        public_ip_address_id                        = "${var.PublicIPId}"
        primary                                     = true        
            }

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   


}


resource "azurerm_network_interface" "TerraNICnopip" {

 
    name                    = "SecondaryNIC"
    location                = "${var.VMLocation}"
    resource_group_name     = "${var.VMRG}"
      

    ip_configuration {

        name                                        = "ConfigIP-NIC-SecondaryNIC"
        subnet_id                                   = "${var.SubnetId2}"
        private_ip_address_allocation               = "dynamic"
        #public_ip_address_id                        = "${var.PublicIPId}"
        primary                                     = false        
            }

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   


}


resource "azurerm_virtual_machine" "TerraVMwith2NICs" {


    name                          = "${var.VMName}"
    location                      = "${var.VMLocation}"
    resource_group_name           = "${var.VMRG}"
    network_interface_ids         = ["${azurerm_network_interface.TerraNICwpip.id}","${azurerm_network_interface.TerraNICnopip.id}"]
    primary_network_interface_id  = "${azurerm_network_interface.TerraNICwpip.id}"
    vm_size                       = "${var.VMSize}"
    availability_set_id           = "${var.VM-ASID}"
    

    storage_image_reference {

        publisher   = "${var.VMPublisher}"
        offer       = "${var.VMOffer}"
        sku         = "${var.VMSku}"
        version     = "latest"

    }

    storage_os_disk {

        name                = "${var.VMName}OSDisk"
        caching             = "ReadWrite"
        create_option       = "FromImage"
        managed_disk_type   = "${var.VMStorageTier}"

    }

/*
    storage_data_disk {

        name                = "${var.VMName}Datadisk"
        managed_disk_id     = "${var.VMDatadiskId}"
        create_option       = "Attach"
        lun                 = 0
        disk_size_gb        = "${var.VMDataDiskSize}"
        

    }

*/
    os_profile {

        computer_name   = "${var.VMName}"
        admin_username  = "${var.VMAdminName}"
        admin_password  = "${var.VMAdminPassword}"

    }

    os_profile_windows_config {

        enable_automatic_upgrades = "false"
    }

/*
    os_profile_linux_config {
    
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.CentOSVMAdminName}/.ssh/authorized_keys"
      key_data = "${var.CentOSSSHKey}"
    }

    }
*/
    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   
    

}

output "NIC1Name" {

  value = "${azurerm_network_interface.TerraNICwpip.name}"
}

output "NIC1Id" {

  value = "${azurerm_network_interface.TerraNICwpip.id}"
}

output "NIC1PrivateIP" {

  value = "${azurerm_network_interface.TerraNICwpip.private_ip_address}"
}

output "NIC1Mac" {

  value = "${azurerm_network_interface.TerraNICwpip.mac_address}"
}

output "NIC2Name" {

  value = "${azurerm_network_interface.TerraNICnopip.name}"
}

output "NIC2Id" {

  value = "${azurerm_network_interface.TerraNICnopip.id}"
}

output "NIC2PrivateIP" {

  value = "${azurerm_network_interface.TerraNICnopip.private_ip_address}"
}

output "NIC2Mac" {

  value = "${azurerm_network_interface.TerraNICnopip.mac_address}"
}

