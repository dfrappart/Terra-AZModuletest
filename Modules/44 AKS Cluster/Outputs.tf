##############################################################
#This module allows the creation of a vNEt
##############################################################


#Output for the vNET module

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


output "KubeAdminCFGRaw" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.kube_admin_config_raw}"
}


output "KubeCfg" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.kube_config}"
}


output "KubeCfgRaw" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.kube_config_raw}"
}


output "HTTPAppRouting" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.http_application_routing}"
}


output "NodeRG" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.node_resource_group}"
}

