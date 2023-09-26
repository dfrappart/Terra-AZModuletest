################################################################
#This module allows the creation of an AKS Cluster
################################################################

resource "azurerm_resource_group" "RgAks" {
  count    = var.AKSRGName == "unspecified" ? 1 : 0
  name     = local.RgName
  location = var.AKSLocation

  tags = local.Tags

}


resource "azurerm_storage_account" "StaMonitor" {
  count                    = local.CreateLocalSta ? 1 : 0
  name                     = substr(format("%s%s%s", "sta", "log", replace(azurerm_kubernetes_cluster.AKS.name, "-", "")), 0, 24)
  location                 = var.AKSLocation
  resource_group_name      = var.AKSRGName == "unspecified" ? azurerm_resource_group.RgAks[0].name : var.AKSRGName
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = local.Tags
}


output "stalog" {
  value = substr(format("%s%s%s", "sta", "log", replace(azurerm_kubernetes_cluster.AKS.name, "-", "")), 0, 24)
}

resource "azurerm_log_analytics_workspace" "LawMonitor" {
  count               = local.CreateLocalLaw ? 1 : 0
  name                = format("%s%s%s", "law", "log", azurerm_kubernetes_cluster.AKS.name)
  location            = var.AKSLocation
  resource_group_name = var.AKSRGName == "unspecified" ? azurerm_resource_group.RgAks[0].name : var.AKSRGName
}
