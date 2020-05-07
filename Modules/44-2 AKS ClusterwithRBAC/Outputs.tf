##############################################################
#This module allows the creation of an AKS cluster
##############################################################


#Output for the AKS module with RBAC enabled

output "KubeName" {
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.name
}

output "KubeLocation" {
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.location
}

output "KubeRG" {
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.resource_group_name
}

output "KubeVersion" {
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.kubernetes_version
}


output "KubeId" {
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.id
}


output "KubeFQDN" {
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.fqdn
}

output "KubeAdminCFGRaw" {
  sensitive = true
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.kube_admin_config_raw
}


output "KubeAdminCFG" {
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.kube_admin_config
}

output "KubeAdminCFG_UserName" {
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.kube_admin_config.0.username
}

output "KubeAdminCFG_HostName" {
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.kube_admin_config.0.host
}


output "KubeAdminCFG_Password" {
  sensitive = true
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.kube_admin_config.0.password
}


output "KubeAdminCFG_ClientKey" {
  sensitive = true
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.kube_admin_config.0.client_key
}


output "KubeAdminCFG_ClientCertificate" {
  sensitive = true
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.kube_admin_config.0.client_certificate
}

output "KubeAdminCFG_ClusCACert" {
  sensitive = true
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.kube_admin_config.0.cluster_ca_certificate
}




/*
output "HTTPAppRouting" {
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.http_application_routing
}

*/

output "NodeRG" {
  value = azurerm_kubernetes_cluster.TerraAKSwithRBAC.node_resource_group
}



