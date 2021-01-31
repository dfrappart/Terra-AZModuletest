##############################################################
#This module allows the creation of a RG
##############################################################

#Creating a Resource Group

resource "azurerm_resource_group" "TerraRG" {

    
  name                                  = "rsg${var.RGSuffix}"
  location                              = var.RGLocation

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Environment                         = var.EnvironmentTag
    Project                             = var.Project
    ManagedBy                           = "Terraform"
  }

}

