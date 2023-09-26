#############################################################################
#This file is used to define data source refering to Azure existing resources
#############################################################################


#############################################################################
#data source for the subscription


data "azurerm_subscription" "current" {}

#############################################################################
#data source for diagnostic settings

data "azurerm_monitor_diagnostic_categories" "Aks" {
  resource_id = azurerm_kubernetes_cluster.AKS.id
}