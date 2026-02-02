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