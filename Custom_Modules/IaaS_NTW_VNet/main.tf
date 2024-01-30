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
  count                    = local.CreateLocalSta ? 1 : 0
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
  count               = local.CreateLocalLaw ? 1 : 0
  name                = format("%s%s%s", "law", "log", azurerm_virtual_network.Vnet.name)
  location            = var.Location
  resource_group_name = var.RgName
  tags                = local.Tags
}



/*
resource "azurerm_virtual_hub_connection" "peering_spoke" {
  count                     = var.hub != null ? 1 : 0
  name                      = format("peer-%s-%s-%s", var.tags.scope, var.vnet.name, var.tags.environment)
  virtual_hub_id            = var.hub.virtual_hub_id
  remote_virtual_network_id = azurerm_virtual_network.vnet_spoke.id

  internet_security_enabled = true

  routing {
    associated_route_table_id = var.hub.rt_id
    propagated_route_table {
      route_table_ids = [var.hub.none_rt_id]
      labels          = ["none"]
    }
  }

  depends_on = [
    #azurerm_virtual_network.vnet_spoke
  ]
}

*/


