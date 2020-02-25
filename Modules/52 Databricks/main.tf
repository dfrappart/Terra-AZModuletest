
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
  custom_parameters {
    no_public_ip                = true
    virtual_network_id          = var.VNetId
    public_subnet_name          = var.PubSubnetId
    private_subnet_name         = var.PrivSubnetId

  }
    
  tags = {
    Environment                 = var.EnvironmentTag
    Usage                       = var.EnvironmentUsageTag
    Owner                       = var.OwnerTag
    ProvisioningDate            = var.ProvisioningDateTag
  }
}