#############################################################################
#This file is used to define data source refering to Azure existing resources
#############################################################################


data "azurerm_resource_group" "TargetRg" {
  name = var.TargetRg
}