
######################################################
# Module VNET + DTB Workspace
######################################################



locals {

  STAPrefix                           = "${lower(var.Company)}${lower(var.CountryTag)}${lower(var.Environment)}${lower(var.Project)}st"
  ResourcePrefix                      = "${lower(var.Company)}${lower(var.CountryTag)}-${lower(var.Environment)}-${lower(var.Project)}-"
  DTBWSName                           = "${lower(var.Company)}${lower(var.CountryTag)}${lower(var.Environment)}${lower(var.Project)}dbw${lower(var.DTBWSName)}"
  
}



#Creating a Resource Group


resource "azurerm_resource_group" "Terra_RG" {

    
    name                        = "${local.ResourcePrefix}rsg-${var.RGName}"
    location                    = var.RGLocation

    tags = {
    Environment       = var.EnvironmentTag
    Usage             = var.EnvironmentUsageTag
    Owner             = var.OwnerTag
    ProvisioningDate  = var.ProvisioningDateTag

    }

}

# Creating DTB Workspace

resource "azurerm_databricks_workspace" "Terra_DTBWS" {
  name                          = substr(lower(var.DTBWSName,0,32))
  location                      = azurerm_resource_group.Terra_RG.location
  resource_group_name           = azurerm_resource_group.Terra_RG.name
  sku                           = var.DTBWSSku
  /*
  
  custom_parameters {
    no_public_ip                = true
    virtual_network_id          = azurerm_virtual_network.Terra_VNet.id
    public_subnet_name          = element(azurerm_subnet.Terra_Subnet.*.name,0)
    private_subnet_name         = element(azurerm_subnet.Terra_Subnet.*.name,1)

  }
  */
    
  tags = {
    Environment       = var.EnvironmentTag
    Usage             = var.EnvironmentUsageTag
    Owner             = var.OwnerTag
    ProvisioningDate  = var.ProvisioningDateTag
  }
}