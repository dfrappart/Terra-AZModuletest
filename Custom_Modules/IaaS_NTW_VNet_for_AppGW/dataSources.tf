#############################################################################
#This file is used to define data source refering to Azure existing resources
#############################################################################


#############################################################################
#data source for the subscription


data "azurerm_subscription" "current" {}

#############################################################################
#data source for the subscription setup logs features

/*
data "azurerm_resource_group" "RGLogs" {
  name                        = var.RGLogName
}

data "azurerm_log_analytics_workspace" "LawSubLog" {
  name                        = var.LawSubLogName
  resource_group_name         = data.azurerm_resource_group.RGLogs.name
}

*/
