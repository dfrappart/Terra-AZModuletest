######################################################################
# Creating an Azure Kubernetes Cluster

module "UserNodepool" {

  source                                = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/IaaS_AKS_NodePool?ref=aksnpv1.1"

  AKSSubnetId                           = "<AksSubnetId>"
  NPSuffix                              = "user1"
  AKSClusterId                          = "<AKSClusterId>"
  AKSNodeTaints                         = ["KataContainer=true:NoSchedule"]
  AKSNodeOSSku                          = "AzureLinux"
  WorkloadRuntimeType                   = "KataMshvVmIsolation"


}