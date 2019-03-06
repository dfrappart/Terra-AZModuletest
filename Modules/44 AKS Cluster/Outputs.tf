##############################################################
#This module allows the creation of an AKS cluster
##############################################################


#Output for the AKS module with RBAC enabled

output "KubeName" {
  value = "${var.IsRBACEnable == "true" ? azurerm_kubernetes_cluster.TerraAKS.0.name : azurerm_kubernetes_cluster.TerraAKSNoRBAC.0.name}"
}

output "KubeLocation" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.location}"
}

output "KubeRG" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.resource_group_name}"
}

output "KubeVersion" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.kubernetes_version}"
}


output "KubeId" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.id}"
}


output "KubeFQDN" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.fqdn}"
}


output "KubeAdminCFG" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config}"
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
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config_raw}"
}


output "KubeCfg" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.kube_config}"
}


output "KubeCfgRaw" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.kube_config_raw}"
}

/*
output "HTTPAppRouting" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.http_application_routing}"
}

*/

output "NodeRG" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.node_resource_group}"
}



#Output for the AKS module without RBAC enabled
/*
output "KubeNoRBACName" {
  value = "${azurerm_kubernetes_cluster.TerraAKSNoRBAC.0.name}"
}
*/
output "KubeNoRBACLocation" {
  value = "${azurerm_kubernetes_cluster.TerraAKSNoRBAC.0.location}"
}

output "KubeNoRBACRG" {
  value = "${azurerm_kubernetes_cluster.TerraAKSNoRBAC.0.resource_group_name}"
}

output "KubeNoRBACVersion" {
  value = "${azurerm_kubernetes_cluster.TerraAKSNoRBAC.0.kubernetes_version}"
}


output "KubeNoRBACId" {
  value = "${azurerm_kubernetes_cluster.TerraAKSNoRBAC.0.id}"
}


output "KubeNoRBACFQDN" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.0.fqdn}"
}

/*
output "KubeNoRBACAdminCFG" {
  value = "${azurerm_kubernetes_cluster.TerraAKSNoRBAC.0.kube_admin_config}"
}


output "KubeNoRBACAdminCFGRaw" {
  value = "${azurerm_kubernetes_cluster.TerraAKSNoRBAC.0.kube_admin_config_raw}"
}

*/

output "KubeNoRBACCfg" {
  value = "${azurerm_kubernetes_cluster.TerraAKSNoRBAC.0.kube_config}"
}


output "KubeNoRBACCfgRaw" {
  value = "${azurerm_kubernetes_cluster.TerraAKSNoRBAC.0.kube_config_raw}"
}

/*
output "HTTPAppRouting" {
  value = "${azurerm_kubernetes_cluster.TerraAKS.http_application_routing}"
}

*/
output "NoRBACNodeRG" {
  value = "${azurerm_kubernetes_cluster.TerraAKSNoRBAC.0.node_resource_group}"
}
