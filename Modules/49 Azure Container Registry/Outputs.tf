##############################################################
#This module allows the creation of a vNEt
##############################################################


#Output for the module

output "Name" {
  value = "${azurerm_container_registry.TerraACR.name}"
  description = "The name of the ACR"
}


output "RGName" {
  value = "${azurerm_container_registry.TerraACR.resource_group_name}"
  description = "The name of the RG containing the ACR"
}


output "Location" {
  value = "${azurerm_container_registry.TerraACR.location}"
  description = "The location of the ACR"
}

output "AdminEnabled" {
  value = "${azurerm_container_registry.TerraACR.admin_enabled}"
  description = "The status of the admin account state, enabled or not"
}

/*
output "Storage" {
  value = "${azurerm_container_registry.TerraACR.storage_account_id}"
  description = "The storage account underlying the ACR"
}
*/

output "SKu" {
  value = "${azurerm_container_registry.TerraACR.sku}"
  description = "The ACR SKU"
}

output "ReplicatedLocations" {
  value = "${azurerm_container_registry.TerraACR.georeplication_locations}"
  description = "The Region in which the ACR is replicated"
}


output "Id" {
  value = "${azurerm_container_registry.TerraACR.id}"
  description = "The Container Registry ID"
}


output "ACRLoginServer" {
  value = "${azurerm_container_registry.TerraACR.login_server}"
  description = "The URL that can be used to log into the container registry"
}



output "ACRAdminName" {
  value = "${var.IsAdminEnabled ? azurerm_container_registry.TerraACR.admin_username : "Admin not enabled"}"
  description = "The Region in which the ACR is replicated"
}



output "ACRAdminPassword" {
  value = "${var.IsAdminEnabled ? azurerm_container_registry.TerraACR.admin_password : "Admin not enabled"}"
  description = "The Admin password of the ACR"
  sensitive = true
}