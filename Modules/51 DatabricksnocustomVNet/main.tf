
######################################################
# Module VNET + DTB Workspace
######################################################



#Creating a Resource Group


resource "azurerm_resource_group" "Terra_RG" {

    
    name                        = "rg${var.RGName}"
    location                    = var.RGLocation

    tags = {
    Environment                 = var.EnvironmentTag
    Usage                       = var.EnvironmentUsageTag
    Owner                       = var.OwnerTag
    ProvisioningDate            = var.ProvisioningDateTag

    }

}


# Creating DTB Workspace

resource "azurerm_databricks_workspace" "Terra_DTBWS" {
  name                          = "dtbw${substr(lower(var.DTBWSName),0,30)}"
  location                      = azurerm_resource_group.Terra_RG.location
  resource_group_name           = azurerm_resource_group.Terra_RG.name
  sku                           = var.DTBWSSku
    
  tags = {
    Environment                 = var.EnvironmentTag
    Usage                       = var.EnvironmentUsageTag
    Owner                       = var.OwnerTag
    ProvisioningDate            = var.ProvisioningDateTag
  }
}