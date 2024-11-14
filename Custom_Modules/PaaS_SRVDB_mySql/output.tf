# My SQL Server output

output "ServerName" {
  value = azurerm_mysql_server.MySQLServer.name
}


output "SkuName" {
  value = azurerm_mysql_server.MySQLServer.sku_name
}

output "Storage" {
  value = azurerm_mysql_server.MySQLServer.storage_mb
}

output "RetentionDays" {
  value = azurerm_mysql_server.MySQLServer.backup_retention_days
}



output "ServerVersion" {
  value = azurerm_mysql_server.MySQLServer.version
}

output "SslEnforcementEnabled" {
  value = azurerm_mysql_server.MySQLServer.ssl_enforcement_enabled
}


output "ServerId" {
  value = azurerm_mysql_server.MySQLServer.id
}

output "ServerFQDN" {
  value = azurerm_mysql_server.MySQLServer.fqdn
}

# MySQL DB output

output "DBId" {
  value = azurerm_mysql_database.MySQLDB.*.id
}

# MySQL AD Admin

output "MySQLADADminId" {
  value = azurerm_mysql_active_directory_administrator.MySQLServerADAdmin.id
}

output "MySQLADADminLogin" {
  value = azurerm_mysql_active_directory_administrator.MySQLServerADAdmin.login
}