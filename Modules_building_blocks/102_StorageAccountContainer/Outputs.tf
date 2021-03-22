##############################################################
#This module allows the creation of a storage container
##############################################################



output "Id" {
  value = azurerm_storage_container.STC.id
}

output "ResourceManagerId" {
  value = azurerm_storage_container.STC.resource_manager_id
}

output "ImmutabilityStatus" {
  value = azurerm_storage_container.STC.has_immutability_policy 
}

output "LegalHoldStatus" {
  value = azurerm_storage_container.STC.has_legal_hold
}


output "STAName" {
  value = azurerm_storage_container.STC.storage_account_name 
}

output "Name" {
  value = azurerm_storage_container.STC.name
}

output "Full" {
  value = azurerm_storage_container.STC
}