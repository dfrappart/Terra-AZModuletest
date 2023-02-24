##############################################################
#This module allows the creation of an AKS cluster
##############################################################


#Output for the AKS module with RBAC enabled

output "KubeName" {
  value                                     = azurerm_kubernetes_cluster.AKS.name
  description                               = "The name of the cluster"
}

output "KubeLocation" {
  value                                     = azurerm_kubernetes_cluster.AKS.location
  description                               = "The location of the cluster"
}

output "KubeRG" {
  value                                     = azurerm_kubernetes_cluster.AKS.resource_group_name
  description                               = "The resource group containing the control plane of the cluster"
}

output "KubeVersion" {
  value                                     = azurerm_kubernetes_cluster.AKS.kubernetes_version
  description                               = "The version of kubernetes"
}


output "KubeId" {
  value                                     = azurerm_kubernetes_cluster.AKS.id
  description                               = "The resource Id of the cluster"
}


output "KubeFQDN" {
  value                                     = azurerm_kubernetes_cluster.AKS.fqdn
  description                               = "Cluster fully qualified domain name"
}

output "KubeControlPlane_SAI" {
  sensitive                                 = true
  value                                     = azurerm_kubernetes_cluster.AKS.identity
  description                               = "The Identity block for the control plane"
}

output "KubeControlPlane_SAI_PrincipalId" {
  sensitive                                 = true
  value                                     = azurerm_kubernetes_cluster.AKS.identity[0].principal_id
  description                               = "Client Id of the AKS control plane. This is this guid that is used to assign rbac role to AKS control plane, such as acces to network operation or dns attachment... "
}

output "KubeControlPlane_SAI_TenantId" {
  sensitive                                 = true
  value                                     = azurerm_kubernetes_cluster.AKS.identity[0].tenant_id
  description                               = "The tenant id in which the control plane identity lives"
}

output "KubeKubelet_UAI" {
  sensitive                                 = true
  value                                     = azurerm_kubernetes_cluster.AKS.kubelet_identity
  description                               = "The Kubelet Identity block"
}

output "KubeKubelet_UAI_ClientId" {
  sensitive                                 = true
  value                                     = azurerm_kubernetes_cluster.AKS.kubelet_identity[0].client_id
  description                               = "Client Id of the Kubelet Identity. This is usually this guid that is used for RBAC assignment to kubelet"
}

output "KubeKubelet_UAI_ObjectId" {
  sensitive                                 = true
  value                                     = azurerm_kubernetes_cluster.AKS.kubelet_identity[0].object_id
  description                               = "Object Id of the Kubelet Identity"
}

output "KubeKubelet_UAI_Id" {
  sensitive                                 = true
  value                                     = azurerm_kubernetes_cluster.AKS.kubelet_identity[0].user_assigned_identity_id

}


output "NodeRG" {
  value                                     = azurerm_kubernetes_cluster.AKS.node_resource_group
  description                               = "Resource group containing the managed Azure resources of the AKS cluster"
}

output "FullAKS" {
  value                                     = azurerm_kubernetes_cluster.AKS
  sensitive                                 = true
  description                               = "Full output of the cluster, just in case"
}



