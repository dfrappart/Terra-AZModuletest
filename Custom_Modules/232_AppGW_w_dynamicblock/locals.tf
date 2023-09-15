locals {
  
   Tags                           = merge(var.DefaultTags, var.extra_tags, {ManagedBy = "Terraform"})

   PubIpLogCategories             = var.PubIpLogCategories != null ? toset(sort(var.PubIpLogCategories)) : sort(data.azurerm_monitor_diagnostic_categories.AGWPubIP.log_category_types)
   PubIpMetricCategories          = var.PubIpMetricCategories != null ? toset(sort(var.PubIpMetricCategories)) : sort(data.azurerm_monitor_diagnostic_categories.AGWPubIP.metrics)


}

output "testlogcategories" {

   value = local.PubIpLogCategories
}

output "testmetriccategories" {

   value = local.PubIpMetricCategories
}