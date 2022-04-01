##############################################################
#This module allows the creation of a VNet
##############################################################

######################################################
# Global variables

variable "TargetRG" {
  type          = string
  description   = "The RG targeted for deployment"
}

variable "TargetLocation" {
  type          = string
  description   = "Location of the resources to be deployed"
}

###################################################################
#Tag related variables section

variable "ExtraTags" {
  type                                  = map
  description                           = "Define a set of additional optional tags."
  default                               = {}
}

variable "DefaultTags" {
  type                                  = map
  description                           = "Define a set of default tags"
  default                               = {
    ResourceOwner                       = "That would be me"
    Country                             = "fr"
    CostCenter                          = "labtf"
    Project                             = "tfmodule"
    Environment                         = "lab"
    ManagedBy                           = "Terraform"

  }
}


######################################################
# variables for NIC

variable "TargetSubnetId" {
  type          = string
  description   = "Id of the Subnet in which the vm should be deployed"
}

######################################################
# Diagnostic settings variables

variable "LawLogId" {
  type          = string
  description   = "The log analytics workspace used to store the logs. Must be in the same location as the resources"
}

variable "STALogId" {
  type          = string
  description   = "The storage account used to store logs. Must be in the same location as the resources"
}


######################################################
#VM variables

variable "VmAdminName" {
  type          = string
  default       = "vmadmin"
  description   = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "VmAdminPassword" {
  type          = string
  description   = "The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created."
}

variable "VMSuffix" {
  type          = string
  default       = ""
  description   = "suffix to add at the end of the VM name, something like fe"
}

variable "VmSize" {
  type          = string
  default       = "Standard_B1ms"
  description   = "The SKU which should be used for this Virtual Machine, such as Standard_F2."
}

variable "IsDeploymentZonal" {
  type                  = string
  default               = true
  description           = "Define if VM is deployed in zone"
}

variable "Zone" {
  type                  = string
  default               = 1
  description           = "Define the AZ"
}

variable "ProvisionVMAgent" {
  type                  = bool
  description           = "Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created."
  default               = true
}

variable "IsVTPMEnabled" {
  type                  = bool
  description           = "Specifies if vTPM (virtual Trusted Plaform Module) and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
  default               = null
}

variable "ScaleSetId" {
  type                  = string
  description           = " Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within. Changing this forces a new resource to be created."
  default               = null
}

##############################################################
# Os Disk block variables

variable "OSDiskCaching" {
  type                  = string
  description           = "The default caching mode for the OS Disk"
  default               = "None"
}

variable "OSDiskTier" {
  type                  = string
  description           = "he Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS and Premium_LRS. Changing this forces a new resource to be created."
  default               = "StandardSSD_LRS"
}

variable "OSDiskSize" {
  type                  = string
  description           = "Managed DIsk OS Size in GB"
  default               = 127
}

variable "IsWriteAccelaratorEnabled" {
  type                  = string
  description           = "Should Write Accelerator be Enabled for this OS Disk? Defaults to false."
  default               = null
}

variable "DiskEncryptionSetId" {
  type                  = string
  description           = "The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk."
  default               = null
}

##############################################################
# boot diagnostic settings

variable "STABlobURI" {
  type                  = string
  description           = "URI of the target Storage for boot diagnostic"
}

##############################################################
# Source image ref block variables

variable "VMImagePublisherName" {
  type                  = string
  description           = "VM Image Publisher namee"
  default               = "MicrosoftWindowsServer"
}

variable "VMImageOfferName" {
  type                  = string
  description           = "VM Image Offer"
  default               = "WindowsServer"
}

variable "VMImageSku" {
  type                  = string
  description           = "VM Image SKU"
  default               = "2019-Datacenter"
}

##############################################################
# Spec for VM managed identity

variable "VMIdentityType" {
  type                          = string
  default                       = "SystemAssigned"
  description                   = "The type of Managed Identity which should be assigned to the Windows Virtual Machine. Possible values are SystemAssigned, UserAssigned and SystemAssigned, UserAssigned."
}

variable "UAIIds" {
  type                          = list
  default                       = []
  description                   = "The ID of a user assigned identity."
}


variable "CloudinitscriptPath" {
  type                  = string
  description           = "bootstrap script name"
  default               = "/Scripts/bootscript.sh"
}


##############################################################
# Additional capability block variables

variable "UlTraSSDEnabled" {
  type                  = bool
  description           = "Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine? Defaults to false."
  default               = null
}


######################################################
#Data Disk variables

variable "DataDiskStorageType" {
  type          = string
  default       = "Premium_LRS"
  description   = "The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS."
}

variable "DataDiskCreateOption" {
  type          = string
  default       = "Empty"
  description   = "The method to use when creating the managed disk. Changing this forces a new resource to be created. Possible values includes Import, Empty, Copy, FromImage, Restore"
}

variable "DataDiskSize" {
  type          = string
  default       = 512
  description   = "Specifies the size of the managed disk to create in gigabytes. If create_option is Copy or FromImage, then the value must be equal to or greater than the source's size. The size can only be increased."
}

variable "DataDiskEncryptionSetId" {
  type          = string
  default       = null
  description   = "SThe ID of a Disk Encryption Set which should be used to encrypt this Managed Disk."
}


