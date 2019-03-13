##############################################################
#This module allows the creation of an AKS cluster
##############################################################


#Output for the AKS module with RBAC enabled

output "KubeName" {
  value = ["${azurerm_kubernetes_cluster.TerraAKS.*.name}"]
}

output "KubeLocation" {
  value = ["${azurerm_kubernetes_cluster.TerraAKS.*.location}"]
}

output "KubeRG" {
  value = ["${azurerm_kubernetes_cluster.TerraAKS.*.resource_group_name}"]
}

output "KubeVersion" {
  value = ["${azurerm_kubernetes_cluster.TerraAKS.*.kubernetes_version}"]
}


output "KubeId" {
  value = ["${azurerm_kubernetes_cluster.TerraAKS.*.id}"]
}


output "KubeFQDN" {
  value = ["${azurerm_kubernetes_cluster.TerraAKS.*.fqdn}"]
}


output "KubeAdminCFG" {
  value = ["${azurerm_kubernetes_cluster.TerraAKS.*.kube_admin_config}"]
}

output "KubeAdminCFG_HostName" {
  value = "${var.IsRBACEnable ? azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config.0.host : "0"}"
}

output "KubeAdminCFG_UserName" {
  value = "${var.IsRBACEnable ? azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config.0.username : "0"}"
}

output "KubeAdminCFG_Password" {
  value = "${var.IsRBACEnable ? azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config.0.password : "0"}"
}

output "KubeAdminCFG_ClientCertificate" {
  value = "${var.IsRBACEnable ? azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config.0.client_certificate : "0"}"
}

output "KubeAdminCFG_ClientKey" {
  value = "${var.IsRBACEnable ? azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config.0.client_key : "0"}"
}

output "KubeAdminCFG_ClusCACert" {
  value = "${var.IsRBACEnable ? azurerm_kubernetes_cluster.TerraAKS.0.kube_admin_config.0.cluster_ca_certificate : "0"}"
}
output "KubeAdminCFGRaw" {
  sensitive = true
  value = ["${var.IsRBACEnable ? azurerm_kubernetes_cluster.TerraAKS.*.kube_admin_config_raw : ["0"]}"]
}


output "KubeCfg" {
  sensitive = true
  value = ["${azurerm_kubernetes_cluster.TerraAKS.*.kube_config}"]
}


output "KubeCfgRaw" {
  sensitive = true
  value = ["${azurerm_kubernetes_cluster.TerraAKS.*.kube_config_raw}"]
}

/*
output "HTTPAppRouting" {
  value = ["${azurerm_kubernetes_cluster.TerraAKS.http_application_routing}"]
}

*/

output "NodeRG" {
  value = ["${azurerm_kubernetes_cluster.TerraAKS.*.node_resource_group}"]
}



#Output for the AKS module without RBAC enabled

output "KubeNoRBACName" {
  value = ["${azurerm_kubernetes_cluster.TerraAKSNoRBAC.*.name}"]
}

output "KubeNoRBACLocation" {
  value = ["${azurerm_kubernetes_cluster.TerraAKSNoRBAC.*.location}"]
}

output "KubeNoRBACRG" {
  value = ["${azurerm_kubernetes_cluster.TerraAKSNoRBAC.*.resource_group_name}"]
}

output "KubeNoRBACVersion" {
  value = ["${azurerm_kubernetes_cluster.TerraAKSNoRBAC.*.kubernetes_version}"]
}


output "KubeNoRBACId" {
  value = ["${azurerm_kubernetes_cluster.TerraAKSNoRBAC.*.id}"]
}


output "KubeNoRBACFQDN" {
  value = ["${azurerm_kubernetes_cluster.TerraAKS.*.fqdn}"]
}



output "KubeNoRBACCfg" {
  value = ["${azurerm_kubernetes_cluster.TerraAKSNoRBAC.*.kube_config}"]
}


output "KubeNoRBACCfgRaw" {
  value = ["${azurerm_kubernetes_cluster.TerraAKSNoRBAC.*.kube_config_raw}"]
}

/*
output "HTTPAppRouting" {
  value = ["${azurerm_kubernetes_cluster.TerraAKS.http_application_routing}"]
}
*/

output "NoRBACNodeRG" {
  value = ["${azurerm_kubernetes_cluster.TerraAKSNoRBAC.*.node_resource_group}"]
}

