##############################################################
#This module allows the creation of an AKS cluster
##############################################################


#Output for the AKS module with RBAC enabled

output "AKSNPName" {
  value       = azurerm_kubernetes_cluster_node_pool.AKSNodePool.name
  description = "The name of the node pool"
}

output "AKSNPId" {
  value       = azurerm_kubernetes_cluster_node_pool.AKSNodePool.id
  description = "The id of the node pool"
}

output "AKSNP_OSType" {
  value       = azurerm_kubernetes_cluster_node_pool.AKSNodePool.os_type
  description = "The os type of the node pool"
}

output "AKSNP_VMSize" {
  value       = azurerm_kubernetes_cluster_node_pool.AKSNodePool.vm_size
  description = "The vm size of the node pool"
}

output "AKSNP_Version" {
  value       = azurerm_kubernetes_cluster_node_pool.AKSNodePool.orchestrator_version
  description = "The kubernetes version of the node pool"
}