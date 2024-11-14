
###################################################################################
################################### Outputs ####################################
###################################################################################

output "FlexibleServer" {
  value       = azurerm_postgresql_flexible_server.PostGreSQLFlexServer
  sensitive   = true
  description = "The full output of the Flexible Server"
}

output "FlexibleServerSubnetId" {
  value       = var.PSQLSubnetId == "unspecified" ? azurerm_subnet.psqlsubnet[0].id : var.PSQLSubnetId
  sensitive   = true
  description = "The subnet id in which the flexible server lives"
}

output "FlexibleServerPrivateDNSZoneId" {
  value       = var.PSQLPrivateDNSZoneId == "unspecified" ? azurerm_private_dns_zone.psqlflexdnszone[0].id : var.PSQLPrivateDNSZoneId
  sensitive   = true
  description = "The Private DNS Zone Id in which the server is declared"
}