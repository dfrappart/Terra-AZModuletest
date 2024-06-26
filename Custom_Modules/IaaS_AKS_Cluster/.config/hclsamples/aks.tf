######################################################################
# Creating an Azure Kubernetes Cluster

module "AKS" {

  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/IaaS_AKS_Cluster?ref=aksv1.2" 

  #Module variable

  AKSLocation                           = azurerm_resource_group.RG.location
  AKSRGName                             = azurerm_resource_group.RG.name
  AKSSubnetId                           = azurerm_subnet.subnet.id
  AKSNetworkPlugin                      = "kubenet"
  AKSNetPolProvider                     = "calico"
  AKSClusSuffix                         = "lab1"
  AKSIdentityType                       = "UserAssigned"
  UAIIds                                = ["<UAI_ID>"]
  PublicSSHKey                          = "<SSH_Key>"
  AKSClusterAdminsIds                   = ["<AAD_Group_Object_Id>"]

  LawLogId                              = "<Log_analytics_workspace_id_for_Diagnostic_settings>"
  StaLogId                              = "<Storage_for_monitoring_id>"

  LawOMSId                              = "<Log_analytics_workspace_id_for_OMS>"
  IsOMSAgentEnabled                     = true

  LawDefenderId                         = "<Log_analytics_workspace_id_for_Defender>"
  IsDefenderEnabled                     = true

  EnableDiagSettings                    = true


}