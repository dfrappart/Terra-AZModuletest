##############################################################
#This module allows the creation of an AKS cluster
##############################################################


#Output for the AKS module with RBAC enabled

output "KubeName" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.name}"
}

output "KubeLocation" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.location}"
}

output "KubeRG" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.resource_group_name}"
}

output "KubeVersion" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.kubernetes_version}"
}


output "KubeId" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.id}"
}


output "KubeFQDN" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.fqdn}"
}


output "KubeAdminCFG" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.kube_admin_config}"
}

output "KubeAdminCFG_HostName" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config.0.host}"
}

output "KubeAdminCFG_UserName" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config.0.username}"
}

output "KubeAdminCFG_Password" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config.0.password}"
}

output "KubeAdminCFG_ClientCertificate" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config.0.client_certificate}"
}

output "KubeAdminCFG_ClientKey" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config.0.client_key}"
}

output "KubeAdminCFG_ClusCACert" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config.0.cluster_ca_certificate}"
}
output "KubeAdminCFGRaw" {
  sensitive = true
  value = "${azurerm_kubernetes_cluster.TerraAKS.kube_admin_config_raw}"
}


output "KubeCfg" {
  sensitive = true
  value = "${azurerm_kubernetes_cluster.TerraAKS.kube_config}"
}


output "KubeCfgRaw" {
  sensitive = true
  value = "${azurerm_kubernetes_cluster.TerraAKS.kube_config_raw}"
}

/*
output "HTTPAppRouting" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.http_application_routing}"
}

*/

output "NodeRG" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.node_resource_group}"
}



