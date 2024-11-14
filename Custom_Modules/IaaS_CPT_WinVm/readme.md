<!-- BEGIN_TF_DOCS -->

# Module Azure Application Gateway

This module is used to provision an Azure Windows Virtual Machine and related resources

## Module description

This module deploys an Azure VM with Windows OS
It includes configuration for:

- Azure Virtual Machine
- Network Interface Card
- Application Security Group and its association with the nic
- Azure diagnostic settings for Nic
- VM extension for AD DS join
- VM extension for Entra Id Authentication
- VM extension for custom script

## Samples

Windows VM joined to AD DS

```hcl

module "sessionhost7" {
  source = "<module_path>"

  TargetRg = azurerm_resource_group.RgAvdSessionHost.name
  TargetLocation = azurerm_resource_group.RgAvdSessionHost.location
  TargetSubnetId = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/<resource_group_name>/providers/Microsoft.Network/virtualNetworks/<vnet_name>/subnets/<subnet_name>"
  VmAdminName = "<vm_admin_name>"
  VmAdminPassword = "<vm_password>"
  LawLogId = var.LawMonitorId
  STALogId = var.StaMonitorId
  STABlobURI = "https://<storage_account_name>.blob.core.windows.net/"
  VMSuffix = "host7"
  CreateAsg = true
  VMImagePublisherName = "MicrosoftWindowsDesktop"
  VMImageOfferName = "Windows-11"
  VMImageSku = "win11-24h2-ent"
  DomainJoined = true
  DomainJoinAccount = "<user_account>@<domain_fqdn>"
  DomainJoinAccountPassword = "<user_password>"
  DomainName = "<domain_fqdn>"
  DomainOuPath = "ou=<target_ou>,dc=<fqdn_left_part_name>,dc=<fqdn_right_part_name>"

}

```
Windows VM with Entra Id authentication enabled

```hcl

module "sessionhost7" {
  source = "<module_path>"

  TargetRg = azurerm_resource_group.RgAvdSessionHost.name
  TargetLocation = azurerm_resource_group.RgAvdSessionHost.location
  TargetSubnetId = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/<resource_group_name>/providers/Microsoft.Network/virtualNetworks/<vnet_name>/subnets/<subnet_name>"
  VmAdminName = "<vm_admin_name>"
  VmAdminPassword = "<vm_password>"
  LawLogId = var.LawMonitorId
  STALogId = var.StaMonitorId
  STABlobURI = "https://<storage_account_name>.blob.core.windows.net/"
  VMSuffix = "host7"
  CreateAsg = true
  EntraIdAuthEnabled = true
  VMImagePublisherName = "MicrosoftWindowsDesktop"
  VMImageOfferName = "Windows-11"
  VMImageSku = "win11-24h2-ent"

}

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.117.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.117.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ACGIds"></a> [ACGIds](#input\_ACGIds) | A list of Action Groups to send the alert to | `list(string)` | `[]` | no |
| <a name="input_ADJoinProtectedSettings"></a> [ADJoinProtectedSettings](#input\_ADJoinProtectedSettings) | Protected settings of the ADJoin agent | <pre>object({<br>    Password = optional(string,null)<br>  })</pre> | `{}` | no |
| <a name="input_ADJoinSettings"></a> [ADJoinSettings](#input\_ADJoinSettings) | The settings for the ADJoin agent | <pre>object({<br>    Name = optional(string,null)<br>    OUPath = optional(string,null)<br>    User = optional(string,null)<br>    Restart = optional(string,null)<br>    Options = optional(string,null)<br>  })</pre> | `{}` | no |
| <a name="input_AlertingEnabled"></a> [AlertingEnabled](#input\_AlertingEnabled) | A bool to enable/disable Azure alerts | `bool` | `false` | no |
| <a name="input_AllowExtensionOperations"></a> [AllowExtensionOperations](#input\_AllowExtensionOperations) | Should Extension Operations be allowed on this Virtual Machine? | `bool` | `true` | no |
| <a name="input_AsgId"></a> [AsgId](#input\_AsgId) | Id of the Application Security Group passed as input | `string` | `""` | no |
| <a name="input_CreateAsg"></a> [CreateAsg](#input\_CreateAsg) | Define if the Asg is created in the module, or given as an input | `bool` | `true` | no |
| <a name="input_CustomDataScriptPath"></a> [CustomDataScriptPath](#input\_CustomDataScriptPath) | cloud init bootstrap script path, should be used with base64encode function | `string` | `null` | no |
| <a name="input_CustomScriptEnabled"></a> [CustomScriptEnabled](#input\_CustomScriptEnabled) | Define if the custom script extension is enabled | `bool` | `false` | no |
| <a name="input_CustomScriptProtectedSettings"></a> [CustomScriptProtectedSettings](#input\_CustomScriptProtectedSettings) | Protected settings of the extension | <pre>object({<br>    commandToExecute = optional(string,null)<br>    storageAccountName = optional(string,null)<br>    storageAccountKey = optional(string,null)<br>    fileUris = optional(list(string),[])<br>  })</pre> | `{}` | no |
| <a name="input_CustomScriptSettings"></a> [CustomScriptSettings](#input\_CustomScriptSettings) | The command to launch in the custom script | <pre>object({<br>    commandToExecute = optional(string,null)<br><br>  })</pre> | <pre>{<br>  "commandToExecute": "powershell.exe Move-Item -Path %SYSTEMDRIVE%\\AzureData\\CustomData.bin -Destination %SYSTEMDRIVE%\\AzureData\\bootscript.ps1; powershell.exe -ExecutionPolicy Unrestricted -File %SYSTEMDRIVE%\\AzureData\\bootscript.ps1; exit 0"<br>}</pre> | no |
| <a name="input_DataDiskCreateOption"></a> [DataDiskCreateOption](#input\_DataDiskCreateOption) | The method to use when creating the managed disk. Changing this forces a new resource to be created. Possible values includes Import, Empty, Copy, FromImage, Restore | `string` | `"Empty"` | no |
| <a name="input_DataDiskEncryptionSetId"></a> [DataDiskEncryptionSetId](#input\_DataDiskEncryptionSetId) | SThe ID of a Disk Encryption Set which should be used to encrypt this Managed Disk. | `string` | `null` | no |
| <a name="input_DataDiskSize"></a> [DataDiskSize](#input\_DataDiskSize) | Specifies the size of the managed disk to create in gigabytes. If create\_option is Copy or FromImage, then the value must be equal to or greater than the source's size. The size can only be increased. | `string` | `512` | no |
| <a name="input_DataDiskStorageType"></a> [DataDiskStorageType](#input\_DataDiskStorageType) | The type of storage to use for the managed disk. Possible values are Standard\_LRS, StandardSSD\_ZRS, Premium\_LRS, Premium\_ZRS, StandardSSD\_LRS or UltraSSD\_LRS. | `string` | `"Premium_LRS"` | no |
| <a name="input_Datadisks"></a> [Datadisks](#input\_Datadisks) | List of data disks to create | <pre>map(object({<br>    Name         = string<br>    CreateOption = optional(string, "Empty")<br>    DiskSizeGb   = optional(string, "50")<br>    StorageType  = optional(string, "StandardSSD_LRS")<br>    LunNumber    = optional(number,10)<br>    DiskCaching  = optional(string,"ReadWrite")<br>  }))</pre> | `{}` | no |
| <a name="input_DefaultTags"></a> [DefaultTags](#input\_DefaultTags) | Define a set of default tags | `map` | <pre>{<br>  "CostCenter": "labtf",<br>  "Country": "fr",<br>  "Environment": "lab",<br>  "ManagedBy": "Terraform",<br>  "Project": "tfmodule",<br>  "ResourceOwner": "That would be me"<br>}</pre> | no |
| <a name="input_DefaultTimeZone"></a> [DefaultTimeZone](#input\_DefaultTimeZone) | Specifies the Time Zone which should be used by the Virtual Machine | `string` | `"Romance Standard Time"` | no |
| <a name="input_DiskEncryptionSetId"></a> [DiskEncryptionSetId](#input\_DiskEncryptionSetId) | The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. | `string` | `null` | no |
| <a name="input_DomainJoinAccount"></a> [DomainJoinAccount](#input\_DomainJoinAccount) | The upn of the account used to join the domain | `string` | `null` | no |
| <a name="input_DomainJoinAccountPassword"></a> [DomainJoinAccountPassword](#input\_DomainJoinAccountPassword) | The password for the domain join account | `string` | `null` | no |
| <a name="input_DomainJoined"></a> [DomainJoined](#input\_DomainJoined) | A bool to enable AD DS domain join | `bool` | `false` | no |
| <a name="input_DomainName"></a> [DomainName](#input\_DomainName) | AD DS Domain name | `string` | `null` | no |
| <a name="input_DomainOuPath"></a> [DomainOuPath](#input\_DomainOuPath) | The Ou path | `string` | `null` | no |
| <a name="input_EntraIdAuthEnabled"></a> [EntraIdAuthEnabled](#input\_EntraIdAuthEnabled) | Define if the Entra Id authentication  is enabled | `bool` | `false` | no |
| <a name="input_ExtraTags"></a> [ExtraTags](#input\_ExtraTags) | Define a set of additional optional tags. | `map` | `{}` | no |
| <a name="input_IsDeploymentZonal"></a> [IsDeploymentZonal](#input\_IsDeploymentZonal) | Define if VM is deployed in zone | `string` | `true` | no |
| <a name="input_IsVTPMEnabled"></a> [IsVTPMEnabled](#input\_IsVTPMEnabled) | Specifies if vTPM (virtual Trusted Plaform Module) and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created. | `bool` | `null` | no |
| <a name="input_IsWriteAccelaratorEnabled"></a> [IsWriteAccelaratorEnabled](#input\_IsWriteAccelaratorEnabled) | Should Write Accelerator be Enabled for this OS Disk? Defaults to false. | `string` | `null` | no |
| <a name="input_LawLogId"></a> [LawLogId](#input\_LawLogId) | The log analytics workspace used to store the logs. Must be in the same location as the resources | `string` | n/a | yes |
| <a name="input_OSDiskCaching"></a> [OSDiskCaching](#input\_OSDiskCaching) | The default caching mode for the OS Disk | `string` | `"None"` | no |
| <a name="input_OSDiskSize"></a> [OSDiskSize](#input\_OSDiskSize) | Managed DIsk OS Size in GB | `string` | `127` | no |
| <a name="input_OSDiskTier"></a> [OSDiskTier](#input\_OSDiskTier) | he Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard\_LRS, StandardSSD\_LRS and Premium\_LRS. Changing this forces a new resource to be created. | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_ProvisionVMAgent"></a> [ProvisionVMAgent](#input\_ProvisionVMAgent) | Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_STABlobURI"></a> [STABlobURI](#input\_STABlobURI) | URI of the target Storage for boot diagnostic | `string` | n/a | yes |
| <a name="input_STALogId"></a> [STALogId](#input\_STALogId) | The storage account used to store logs. Must be in the same location as the resources | `string` | n/a | yes |
| <a name="input_ScaleSetId"></a> [ScaleSetId](#input\_ScaleSetId) | Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_Shutdown"></a> [Shutdown](#input\_Shutdown) | Scheduled shutdown configuration | <pre>object({<br>    Enabled  = optional(bool, true)<br>    Time     = optional(string, "1800")<br>    TimeZone = optional(string, "Romance Standard Time")<br>    Notification = object({<br>      Enabled                         = optional(bool, false)<br>      TimeInMinutesBeforeNotification = optional(number, 30)<br>      WebhookUrl                      = optional(string, null)<br>      Email                           = optional(string, null)<br>    })<br>  })</pre> | <pre>{<br>  "Enabled": true,<br>  "Notification": {<br>    "Email": null,<br>    "ShutdownTimeNotificationEnabled": false,<br>    "TimeInMinutesBeforeNotification": 30,<br>    "WebhookUrl": null<br>  }<br>}</pre> | no |
| <a name="input_TargetLocation"></a> [TargetLocation](#input\_TargetLocation) | Location of the resources to be deployed | `string` | `""` | no |
| <a name="input_TargetRg"></a> [TargetRg](#input\_TargetRg) | The RG targeted for deployment | `string` | n/a | yes |
| <a name="input_TargetSubnetId"></a> [TargetSubnetId](#input\_TargetSubnetId) | Id of the Subnet in which the vm should be deployed | `string` | n/a | yes |
| <a name="input_UAIIds"></a> [UAIIds](#input\_UAIIds) | The ID of a user assigned identity. | `list` | `[]` | no |
| <a name="input_UlTraSSDEnabled"></a> [UlTraSSDEnabled](#input\_UlTraSSDEnabled) | Should the capacity to enable Data Disks of the UltraSSD\_LRS storage account type be supported on this Virtual Machine? Defaults to false. | `bool` | `null` | no |
| <a name="input_UserDataScriptPath"></a> [UserDataScriptPath](#input\_UserDataScriptPath) | user fdata bootstrap script path, should be used with base64encode function | `string` | `null` | no |
| <a name="input_VMIdentityType"></a> [VMIdentityType](#input\_VMIdentityType) | The type of Managed Identity which should be assigned to the Windows Virtual Machine. Possible values are SystemAssigned, UserAssigned and SystemAssigned, UserAssigned. | `string` | `"SystemAssigned"` | no |
| <a name="input_VMImageOfferName"></a> [VMImageOfferName](#input\_VMImageOfferName) | VM Image Offer, choose WindowsServer for Servers, Windows-11 for Windows Desktops | `string` | `"WindowsServer"` | no |
| <a name="input_VMImagePublisherName"></a> [VMImagePublisherName](#input\_VMImagePublisherName) | VM Image Publisher name, choose MicrosoftWindowsServer for servers, MicrosoftWindowsDesktop for workstations | `string` | `"MicrosoftWindowsServer"` | no |
| <a name="input_VMImageSku"></a> [VMImageSku](#input\_VMImageSku) | VM Image SKU, choose 2022-Datacenter or win11-24h2-ent for standalone, win11-24h2-avd for multisession | `string` | `"2022-Datacenter"` | no |
| <a name="input_VMSuffix"></a> [VMSuffix](#input\_VMSuffix) | suffix to add at the end of the VM name, something like fe | `string` | `""` | no |
| <a name="input_VmAdminName"></a> [VmAdminName](#input\_VmAdminName) | The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `string` | `"vmadmin"` | no |
| <a name="input_VmAdminPassword"></a> [VmAdminPassword](#input\_VmAdminPassword) | The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_VmAgentPlatformUpdateEnabled"></a> [VmAgentPlatformUpdateEnabled](#input\_VmAgentPlatformUpdateEnabled) | Specifies whether VMAgent Platform Updates is enabled. | `bool` | `true` | no |
| <a name="input_VmAlerts"></a> [VmAlerts](#input\_VmAlerts) | A map of object to define alerts on the VM | <pre>map(object({<br>      AlertName = string<br>      AlertDescription = string<br>      AlertSeverity = optional(number,3)<br>      MetricNameSpace = optional(string,"Microsoft.Compute/virtualMachines")<br>      MetricName = string<br>      MetricAggregation = string<br>      MetricOperator = string<br>      MetricThreshold = number<br>      AlertFrequency = optional(string, "PT5M") <br>      AlertWindow = optional(string, "PT5M")<br>    }))</pre> | <pre>{<br>  "AvailableMemoryBytes": {<br>    "AlertDescription": "AvailableMemoryBytes",<br>    "AlertName": "AvailableMemoryBytes",<br>    "MetricAggregation": "Average",<br>    "MetricName": "Available Memory Bytes",<br>    "MetricOperator": "LessThan",<br>    "MetricThreshold": 1000000000<br>  },<br>  "DataDiskIopsConsumed": {<br>    "AlertDescription": "DataDiskIopsConsumed",<br>    "AlertName": "DataDiskIopsConsumed",<br>    "MetricAggregation": "Average",<br>    "MetricName": "Data Disk IOPS Consumed Percentage",<br>    "MetricOperator": "GreaterThan",<br>    "MetricThreshold": 95<br>  },<br>  "HighCpuThreshold": {<br>    "AlertDescription": "HighCpuThreshold",<br>    "AlertName": "HighCpuThreshold",<br>    "MetricAggregation": "Average",<br>    "MetricName": "Percentage CPU",<br>    "MetricOperator": "GreaterThan",<br>    "MetricThreshold": 80<br>  },<br>  "NetworkInTotal": {<br>    "AlertDescription": "NetworkInTotal",<br>    "AlertName": "NetworkInTotal",<br>    "MetricAggregation": "Total",<br>    "MetricName": "Network In Total",<br>    "MetricOperator": "GreaterThan",<br>    "MetricThreshold": 500000000000<br>  },<br>  "NetworkOutTotal": {<br>    "AlertDescription": "NetworkOutTotal",<br>    "AlertName": "NetworkOutTotal",<br>    "MetricAggregation": "Total",<br>    "MetricName": "Network Out Total",<br>    "MetricOperator": "GreaterThan",<br>    "MetricThreshold": 200000000000<br>  },<br>  "OsDiskIopsConsumed": {<br>    "AlertDescription": "OsDiskIopsConsumed",<br>    "AlertName": "OsDiskIopsConsumed",<br>    "MetricAggregation": "Average",<br>    "MetricName": "OS Disk IOPS Consumed Percentage",<br>    "MetricOperator": "GreaterThan",<br>    "MetricThreshold": 95<br>  },<br>  "VmAvailabilityMetric": {<br>    "AlertDescription": "VmAvailabilityMetric",<br>    "AlertName": "VmAvailabilityMetric",<br>    "MetricAggregation": "Average",<br>    "MetricName": "VmAvailabilityMetric",<br>    "MetricOperator": "LessThan",<br>    "MetricThreshold": 1<br>  }<br>}</pre> | no |
| <a name="input_VmSize"></a> [VmSize](#input\_VmSize) | The SKU which should be used for this Virtual Machine, such as Standard\_F2. | `string` | `"Standard_D4s_v5"` | no |
| <a name="input_Zone"></a> [Zone](#input\_Zone) | Define the AZ | `string` | `1` | no |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_security_group.AsgVm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_security_group) | resource |
| [azurerm_dev_test_global_vm_shutdown_schedule.VmShutdown](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dev_test_global_vm_shutdown_schedule) | resource |
| [azurerm_managed_disk.DataDisk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_monitor_diagnostic_setting.VMNICDiag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_metric_alert.VMMonitorAlert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_network_interface.VMNIC](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_application_security_group_association.AsgVmAssociation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_application_security_group_association) | resource |
| [azurerm_virtual_machine_data_disk_attachment.AttachDataDisk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_extension.CustomScriptExtension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.EntraIdAuth](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.domain_join](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.VM](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [azurerm_resource_group.TargetRg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_VMFull"></a> [VMFull](#output\_VMFull) | n/a |
| <a name="output_VMId"></a> [VMId](#output\_VMId) | n/a |
| <a name="output_VMIdentity"></a> [VMIdentity](#output\_VMIdentity) | n/a |
| <a name="output_VMNICFull"></a> [VMNICFull](#output\_VMNICFull) | n/a |
| <a name="output_VMNICId"></a> [VMNICId](#output\_VMNICId) | n/a |
| <a name="output_VMNICInternalDNS"></a> [VMNICInternalDNS](#output\_VMNICInternalDNS) | n/a |
| <a name="output_VMNICMAC"></a> [VMNICMAC](#output\_VMNICMAC) | n/a |
| <a name="output_VMNICName"></a> [VMNICName](#output\_VMNICName) | n/a |
| <a name="output_VMNICPrivateIP"></a> [VMNICPrivateIP](#output\_VMNICPrivateIP) | n/a |
| <a name="output_VMName"></a> [VMName](#output\_VMName) | n/a |
| <a name="output_VMPrivateIP"></a> [VMPrivateIP](#output\_VMPrivateIP) | n/a |
| <a name="output_VM_VMID"></a> [VM\_VMID](#output\_VM\_VMID) | n/a |

## How to update this documentation

In the module folder, use the following command.

```bash

terraform-docs --config ./.config/.terraform-doc.yml .

```
<!-- END_TF_DOCS -->