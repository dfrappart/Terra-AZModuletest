output "ServerName" {
  value = azurerm_postgresql_server.PostgreServer.name
}


output "SkuName" {
  value = azurerm_postgresql_server.PostgreServer.sku_name
}

output "Storage" {
  value = azurerm_postgresql_server.PostgreServer.storage_mb
}

output "RetentionDays" {
  value = azurerm_postgresql_server.PostgreServer.backup_retention_days 
}



output "ServerVersion" {
  value = azurerm_postgresql_server.PostgreServer.version
}

output "SslEnforcementEnabled" {
  value = azurerm_postgresql_server.PostgreServer.ssl_enforcement_enabled
}


output "ServerId" {
  value = azurerm_postgresql_server.PostgreServer.id
}

output "ServerFQDN" {
  value = azurerm_postgresql_server.PostgreServer.fqdn
}

output "DBId" {
  value = azurerm_postgresql_database.PostgreDB.*.id
}
