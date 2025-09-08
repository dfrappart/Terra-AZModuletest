###################################################################################
# Resource group

resource "random_string" "RandomAppName" {
  count   = var.AppName == "" ? 1 : 0
  length  = 4
  special = false
  numeric = true

}


resource "azurerm_resource_group" "VnetResourceGroup" {

  lifecycle {
    ignore_changes = [
      tags["StartDate"]
    ]
  }

  count    = var.CreateRG ? 1 : 0
  name     = local.RgName
  location = var.Location
  tags     = merge(var.DefaultTags, var.ExtraTags, { "StartDate" = local.StartDateTag })



}

###################################################################################
# Log resources
resource "azurerm_storage_account" "StaMonitor" {
  count                    = var.CreateLocalSta ? 1 : 0
  name                     = substr(format("%s%s%s", "sta", "log", replace(azurerm_virtual_network.Vnet.name, "-", "")), 0, 24)
  location                 = var.Location
  resource_group_name      = var.RgName
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = local.Tags
}



resource "azurerm_log_analytics_workspace" "LawMonitor" {
  count               = var.CreateLocalLaw ? 1 : 0
  name                = format("%s%s%s", "law", "log", azurerm_virtual_network.Vnet.name)
  location            = var.Location
  resource_group_name = var.RgName
  tags                = local.Tags
}






