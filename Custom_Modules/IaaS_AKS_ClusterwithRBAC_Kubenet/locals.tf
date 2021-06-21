

locals {


  AKSClusterName                        = "aks-${lower(var.AKSClusSuffix)}"
  AKSDefaultNodePoolName                = "aksnp0${lower(var.AKSClusSuffix)}"
  DNSPrefix                             = "aks${lower(var.Project)}${lower(var.Environment)}"
  NodeRGName                            = var.AKSNodesRG != "unspecified" ? var.AKSNodesRG : "rsg-${lower(var.Company)}${lower(var.CountryTag)}-${lower(var.Environment)}-${lower(var.Project)}-aksobjects" 
}