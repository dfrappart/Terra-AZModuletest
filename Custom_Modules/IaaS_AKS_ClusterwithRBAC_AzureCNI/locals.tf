

locals {


  AKSClusterName                        = "aks-${lower(var.AKSClusSuffix)}"
  AKSDefaultNodePoolName                = "aksnp0${lower(var.AKSClusSuffix)}"
  DNSPrefix                             = "aks${lower(var.Project)}${lower(var.Environment)}"
  CustomNodeRGName                      = var.AKSNodesRG != "unspecified" ? var.AKSNodesRG : "rsg-${lower(var.Company)}${lower(var.CountryTag)}-${lower(var.Environment)}-${lower(var.Project)}-aksobjects" 
  DefaultNodeRGName                     = null

  AGIC = tomap({
    Enabled                               = var.IsAGICEnabled
    Id                                    = var.AGWId
    Name                                  = var.AGWName
    SubnetCidr                            = var.AGWSubnetCidr
    SubnetId                              = var.AGWSubnetId
  })

  DefaultTags = tomap({
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Project                             = var.Project
    Environment                         = var.Environment
    ManagedBy                           = "Terraform"
  })

}
