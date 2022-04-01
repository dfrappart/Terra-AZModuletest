##############################################################
#This module allows the creation of a RG
##############################################################

#Creating a Resource Group

resource "azurerm_resource_group" "RG" {

    
  name                                  = "rsg${var.RGSuffix}"
  location                              = var.RGLocation

  tags = merge(var.DefaultTags,var.ExtraTags)

}

