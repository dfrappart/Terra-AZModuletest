

locals {


  AKSClusterName                        = "aks-${lower(var.AKSClusSuffix)}"
  AKSDefaultNodePoolName                = "aksnp0${lower(var.AKSClusSuffix)}"
  DNSPrefix                             = "aks${lower(var.Project)}${lower(var.Environment)}"
  CustomNodeRGName                      = var.AKSNodesRG != "unspecified" ? var.AKSNodesRG : "rsg-${lower(var.Company)}${lower(var.CountryTag)}-${lower(var.Environment)}-${lower(var.Project)}-aksobjects${lower(var.AKSClusSuffix)}" 
  DefaultNodeRGName                     = null
  LawOMSId                              = var.LawOMSId != "unspcified" ? var.LawOMSId : var.LawLogId
  IsOMSAgentEnabled                     = var.IsOMSAgentEnabled && local.LawOMSId != "unspecified" ? true : false
  LawDefenderId                         = var.LawDefenderId != "unspecified" ? var.LawDefenderId : var.LawLogId
  IsDefenderEnabled                     = var.IsDefenderEnabled && local.LawDefenderId != "unspecified" ? true : false

  AGIC = {
    Enabled                             = var.IsAGICEnabled
    Id                                  = var.AGWId
    Name                                = var.AGWName
    SubnetCidr                          = var.AGWSubnetCidr
    SubnetId                            = var.AGWSubnetId
  }

  DefaultTags = merge(var.DefaultTags, var.extra_tags, {ManagedBy = "Terraform"})

}
