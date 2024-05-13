
resource "azurerm_resource_group" "RgAgw" {
  count    = var.TargetRG == "unspecified" ? 1 : 0
  name     = local.RgName
  location = var.TargetLocation

  tags = local.Tags

}

resource "azurerm_storage_account" "StaMonitor" {
  count                    = local.CreateLocalSta ? 1 : 0
  name                     = substr(format("%s%s%s", "sta", "log", azurerm_application_gateway.AGW.name), 0, 24)
  location                 = var.TargetLocation
  resource_group_name      = var.TargetRG == "unspecified" ? azurerm_resource_group.RgAgw[0].name : var.TargetRG
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = local.Tags
}

resource "azurerm_log_analytics_workspace" "LawMonitor" {
  count               = local.CreateLocalLaw ? 1 : 0
  name                = format("%s%s%s", "law", "log", azurerm_application_gateway.AGW.name)
  location            = var.TargetLocation
  resource_group_name = var.TargetRG == "unspecified" ? azurerm_resource_group.RgAgw[0].name : var.TargetRG
}