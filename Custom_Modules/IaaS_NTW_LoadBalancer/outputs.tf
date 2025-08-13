##############################################################
#Output for module

output "PublicLB" {
  value       = var.LbConfig.IsLbPublic ? azurerm_public_ip.LbPubIp : []
  description = "Exported attributes of the Public Ip"
}

output "Lb" {
  value       = azurerm_lb.Lb
  description = "Exported attributes of the Load Balancer"
}

output "PubIpDiagCategories" {
  value       = var.LbConfig.IsLbPublic ? data.azurerm_monitor_diagnostic_categories.PubIps : []
  description = "Exported attributes of the Public IP Diagnostic Categories"
}

output "LbDiagCategories" {
  value       = data.azurerm_monitor_diagnostic_categories.Lb
  description = "Exported attributes of the Load Balancer Diagnostic Categories"
}