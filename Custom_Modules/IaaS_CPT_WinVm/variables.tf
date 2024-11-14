##############################################################
#This module allows the creation of a VNet
##############################################################

######################################################
# Global variables

variable "TargetRg" {
  type        = string
  description = "The RG targeted for deployment"
}

variable "TargetLocation" {
  type        = string
  description = "Location of the resources to be deployed"
  default     = ""
}

###################################################################
#Tag related variables section

variable "ExtraTags" {
  type        = map(any)
  description = "Define a set of additional optional tags."
  default     = {}
}

variable "DefaultTags" {
  type        = map(any)
  description = "Define a set of default tags"
  default = {
    ResourceOwner = "That would be me"
    Country       = "fr"
    CostCenter    = "labtf"
    Project       = "tfmodule"
    Environment   = "lab"
    ManagedBy     = "Terraform"

  }
}


######################################################
# variables for NIC

variable "TargetSubnetId" {
  type        = string
  description = "Id of the Subnet in which the vm should be deployed"
}

######################################################
# Diagnostic settings variables

variable "LawLogId" {
  type        = string
  description = "The log analytics workspace used to store the logs. Must be in the same location as the resources"
}

variable "STALogId" {
  type        = string
  description = "The storage account used to store logs. Must be in the same location as the resources"
}


######################################################
#VM variables

variable "VmAdminName" {
  type        = string
  default     = "vmadmin"
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "VmAdminPassword" {
  type        = string
  description = "The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created."
}

variable "VMSuffix" {
  type        = string
  default     = ""
  description = "suffix to add at the end of the VM name, something like fe"
}

variable "VmSize" {
  type        = string
  default     = "Standard_D4s_v5"
  description = "The SKU which should be used for this Virtual Machine, such as Standard_F2."
}

variable "IsDeploymentZonal" {
  type        = string
  default     = true
  description = "Define if VM is deployed in zone"
}

variable "Zone" {
  type        = string
  default     = 1
  description = "Define the AZ"
}

variable "ProvisionVMAgent" {
  type        = bool
  description = "Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created."
  default     = true
}

variable "AllowExtensionOperations" {
  type        = bool
  description = "Should Extension Operations be allowed on this Virtual Machine?"
  default     = true
}

variable "VmAgentPlatformUpdateEnabled" {
  type        = bool
  description = "Specifies whether VMAgent Platform Updates is enabled."
  default     = true
}

variable "IsVTPMEnabled" {
  type        = bool
  description = "Specifies if vTPM (virtual Trusted Plaform Module) and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
  default     = null
}

variable "ScaleSetId" {
  type        = string
  description = " Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within. Changing this forces a new resource to be created."
  default     = null
}

variable "DefaultTimeZone" {
  type        = string
  description = "Specifies the Time Zone which should be used by the Virtual Machine"
  default     = "Romance Standard Time"
}

##############################################################
# Os Disk block variables

variable "OSDiskCaching" {
  type        = string
  description = "The default caching mode for the OS Disk"
  default     = "None"
}

variable "OSDiskTier" {
  type        = string
  description = "he Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS and Premium_LRS. Changing this forces a new resource to be created."
  default     = "StandardSSD_LRS"
}

variable "OSDiskSize" {
  type        = string
  description = "Managed DIsk OS Size in GB"
  default     = 127
}

variable "IsWriteAccelaratorEnabled" {
  type        = string
  description = "Should Write Accelerator be Enabled for this OS Disk? Defaults to false."
  default     = null
}

variable "DiskEncryptionSetId" {
  type        = string
  description = "The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk."
  default     = null
}

##############################################################
# boot diagnostic settings

variable "STABlobURI" {
  type        = string
  description = "URI of the target Storage for boot diagnostic"
}

##############################################################
# Source image ref block variables

variable "VMImagePublisherName" {
  type        = string
  description = "VM Image Publisher name, choose MicrosoftWindowsServer for servers, MicrosoftWindowsDesktop for workstations"
  default     = "MicrosoftWindowsServer"
}

variable "VMImageOfferName" {
  type        = string
  description = "VM Image Offer, choose WindowsServer for Servers, Windows-11 for Windows Desktops"
  default     = "WindowsServer"
}

variable "VMImageSku" {
  type        = string
  description = "VM Image SKU, choose 2022-Datacenter or win11-24h2-ent for standalone, win11-24h2-avd for multisession"
  default     = "2022-Datacenter"
}

##############################################################
# Spec for VM managed identity

variable "VMIdentityType" {
  type        = string
  default     = "SystemAssigned"
  description = "The type of Managed Identity which should be assigned to the Windows Virtual Machine. Possible values are SystemAssigned, UserAssigned and SystemAssigned, UserAssigned."
}

variable "UAIIds" {
  type        = list(any)
  default     = []
  description = "The ID of a user assigned identity."
}

##############################################################
# Custom & User Data

variable "CustomDataScriptPath" {
  type        = string
  description = "cloud init bootstrap script path, should be used with base64encode function"
  default     = null
}

variable "UserDataScriptPath" {
  type        = string
  description = "user fdata bootstrap script path, should be used with base64encode function"
  default     = null
}

##############################################################
# Additional capability block variables

variable "UlTraSSDEnabled" {
  type        = bool
  description = "Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine? Defaults to false."
  default     = null
}


######################################################
#Data Disk variables

variable "Datadisks" {
  type = map(object({
    Name         = string
    CreateOption = optional(string, "Empty")
    DiskSizeGb   = optional(string, "50")
    StorageType  = optional(string, "StandardSSD_LRS")
    LunNumber    = optional(number, 10)
    DiskCaching  = optional(string, "ReadWrite")
  }))
  description = "List of data disks to create"
  default     = {}
}

variable "DataDiskStorageType" {
  type        = string
  default     = "Premium_LRS"
  description = "The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS."
}

variable "DataDiskCreateOption" {
  type        = string
  default     = "Empty"
  description = "The method to use when creating the managed disk. Changing this forces a new resource to be created. Possible values includes Import, Empty, Copy, FromImage, Restore"
}

variable "DataDiskSize" {
  type        = string
  default     = 512
  description = "Specifies the size of the managed disk to create in gigabytes. If create_option is Copy or FromImage, then the value must be equal to or greater than the source's size. The size can only be increased."
}

variable "DataDiskEncryptionSetId" {
  type        = string
  default     = null
  description = "SThe ID of a Disk Encryption Set which should be used to encrypt this Managed Disk."
}


######################################################
# Nic & Asg

variable "AsgId" {
  type        = string
  description = "Id of the Application Security Group passed as input"
  default     = ""
}

variable "CreateAsg" {
  type        = bool
  description = "Define if the Asg is created in the module, or given as an input"
  default     = true

}

######################################################
# Scheduled shutdown variable

variable "Shutdown" {
  type = object({
    Enabled  = optional(bool, true)
    Time     = optional(string, "1800")
    TimeZone = optional(string, "Romance Standard Time")
    Notification = object({
      Enabled                         = optional(bool, false)
      TimeInMinutesBeforeNotification = optional(number, 30)
      WebhookUrl                      = optional(string, null)
      Email                           = optional(string, null)
    })
  })
  description = "Scheduled shutdown configuration"
  default = {
    Enabled = true
    Notification = {
      ShutdownTimeNotificationEnabled = false
      TimeInMinutesBeforeNotification = 30
      WebhookUrl                      = null
      Email                           = null
    }
  }
}

######################################################
# Monitor variable

variable "AlertingEnabled" {
  type        = bool
  description = "A bool to enable/disable Azure alerts"
  default     = false

}

variable "ACGIds" {
  type        = list(string)
  description = "A list of Action Groups to send the alert to"
  default     = []
}


variable "VmAlerts" {
  description = "A map of object to define alerts on the VM"
  type = map(object({
    AlertName         = string
    AlertDescription  = string
    AlertSeverity     = optional(number, 3)
    MetricNameSpace   = optional(string, "Microsoft.Compute/virtualMachines")
    MetricName        = string
    MetricAggregation = string
    MetricOperator    = string
    MetricThreshold   = number
    AlertFrequency    = optional(string, "PT5M")
    AlertWindow       = optional(string, "PT5M")
  }))

  default = {
    HighCpuThreshold = {
      AlertName         = "HighCpuThreshold"
      AlertDescription  = "HighCpuThreshold"
      MetricName        = "Percentage CPU"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 80
    },
    NetworkInTotal = {
      AlertName         = "NetworkInTotal"
      AlertDescription  = "NetworkInTotal"
      MetricName        = "Network In Total"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 500000000000
    },
    AvailableMemoryBytes = {
      AlertName         = "AvailableMemoryBytes"
      AlertDescription  = "AvailableMemoryBytes"
      MetricName        = "Available Memory Bytes"
      MetricAggregation = "Average"
      MetricOperator    = "LessThan"
      MetricThreshold   = 1000000000
    },
    DataDiskIopsConsumed = {
      AlertName         = "DataDiskIopsConsumed"
      AlertDescription  = "DataDiskIopsConsumed"
      MetricName        = "Data Disk IOPS Consumed Percentage"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 95
    },
    NetworkOutTotal = {
      AlertName         = "NetworkOutTotal"
      AlertDescription  = "NetworkOutTotal"
      MetricName        = "Network Out Total"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 200000000000
    },
    OsDiskIopsConsumed = {
      AlertName         = "OsDiskIopsConsumed"
      AlertDescription  = "OsDiskIopsConsumed"
      MetricName        = "OS Disk IOPS Consumed Percentage"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 95
    },
    VmAvailabilityMetric = {
      AlertName         = "VmAvailabilityMetric"
      AlertDescription  = "VmAvailabilityMetric"
      MetricName        = "VmAvailabilityMetric"
      MetricAggregation = "Average"
      MetricOperator    = "LessThan"
      MetricThreshold   = 1
    }
  }
}


######################################################
# Agent domain ADDS join variable

variable "DomainJoined" {
  type        = bool
  description = "A bool to enable AD DS domain join"
  default     = false
}

variable "DomainName" {
  type        = string
  description = "AD DS Domain name"
  default     = null

}

variable "DomainJoinAccount" {
  type        = string
  description = "The upn of the account used to join the domain"
  default     = null

}

variable "DomainJoinAccountPassword" {
  type        = string
  description = "The password for the domain join account"
  default     = null

}

variable "DomainOuPath" {
  type        = string
  description = "The Ou path"
  default     = null

}

variable "ADJoinSettings" {
  type = object({
    Name    = optional(string, null)
    OUPath  = optional(string, null)
    User    = optional(string, null)
    Restart = optional(string, null)
    Options = optional(string, null)
  })
  description = "The settings for the ADJoin agent"
  default = {

  }
}

variable "ADJoinProtectedSettings" {
  type = object({
    Password = optional(string, null)
  })
  description = "Protected settings of the ADJoin agent"
  default     = {}

}



######################################################
# Agent CustomExtension script

variable "CustomScriptEnabled" {
  type        = bool
  description = "Define if the custom script extension is enabled"
  default     = false
}

variable "CustomScriptSettings" {
  type = object({
    commandToExecute = optional(string, null)

  })
  description = "The command to launch in the custom script"
  default = {
    "commandToExecute" = "powershell.exe Move-Item -Path %SYSTEMDRIVE%\\AzureData\\CustomData.bin -Destination %SYSTEMDRIVE%\\AzureData\\bootscript.ps1; powershell.exe -ExecutionPolicy Unrestricted -File %SYSTEMDRIVE%\\AzureData\\bootscript.ps1; exit 0"
  }
}

variable "CustomScriptProtectedSettings" {
  type = object({
    commandToExecute   = optional(string, null)
    storageAccountName = optional(string, null)
    storageAccountKey  = optional(string, null)
    fileUris           = optional(list(string), [])
  })
  description = "Protected settings of the extension"
  default     = {}

}


######################################################
# Agent Entra Id auth

variable "EntraIdAuthEnabled" {
  type        = bool
  description = "Define if the Entra Id authentication  is enabled"
  default     = false
}