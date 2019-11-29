
# AKS Cluster module


This module allows the deployment of an AKS cluster with RBAC Enable and Azure AD integration.


## Exemple configuration

Deploy the following to have a working AKS cluster:

```hcl 


######################################################################
# RG

module "ResourceGroupCloudExpo" {
  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//01 ResourceGroup/"
  #source = "./Modules/01 ResourceGroup"

  #Module variable
  RGName              = var.RGName
  RGLocation          = var.AzureRegion
  EnvironmentTag      = var.EnvironmentTag
  EnvironmentUsageTag = var.EnvironmentUsageTag
  OwnerTag            = var.OwnerTag
  ProvisioningDateTag = var.ProvisioningDateTag

}



######################################################################
# Networking

# Creating VNet

module "VNetCloudExpo" {

  #Module location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//02 VNet/"

  #Module variable
  VNetName                = var.VNetName
  RGName                  = module.ResourceGroupCloudExpo.Name
  VNetLocation            = module.ResourceGroupCloudExpo.Location
  VNetAddressSpace        = ["10.0.0.0/16"]
  EnvironmentTag          = var.EnvironmentTag
  EnvironmentUsageTag     = var.EnvironmentUsageTag
  OwnerTag                = var.OwnerTag
  ProvisioningDateTag     = var.ProvisioningDateTag


}


module "SubnetAKS1" {

  #Module location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-2 SubnetWithoutNSG/"

  #Module variable  
  SubnetName              = var.SubnetName
  RGName                  = module.ResourceGroupCloudExpo.Name
  VNetName                = module.VNetCloudExpo.Name
  Subnetaddressprefix     = var.Subnetaddressprefix
  

}

######################################################################
# Monitoring

module "LAWSRandomSuffix" {
    #Module source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//00 RandomString/"
    #source = "./Modules/00 RandomString"

    #Module variables
    stringlenght        = "5"
    stringspecial       = "false"
    stringupper         = "false"
    
}


module "CloudExpoLogAnalytics" {
    #Module source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//45 Log analytics workspace/"
    #source = "./Modules/12 Log analytics workspace"

    #Module variables
    LAWName             = "${var.LAWName}${module.LAWSRandomSuffix.Result}"
    LAWLocation         = var.AzureRegion
    LAWRGName           = module.ResourceGroupCloudExpo.Name
    EnvironmentTag      = var.EnvironmentTag
    EnvironmentUsageTag = var.EnvironmentUsageTag
    OwnerTag            = var.OwnerTag
    ProvisioningDateTag = var.ProvisioningDateTag
}


#Creating log analytics solution for containers

module "CloudExpoLogAnalyticsSolution" {

    #Module source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//46 Log analytics solution/"
    #source = "./Modules/13 Log analytics solution"

    #Module variables
    LASolName        = var.LogAnalyticsSolutionName
    LASolLocation    = var.AzureRegion
    LASolRGName      = module.ResourceGroupCloudExpo.Name
    LAWId            = module.CloudExpoLogAnalytics.Id
    LAWName          = module.CloudExpoLogAnalytics.Name
    LASolPublisher   = var.LogAnalyticsSolutionPublisher
    LASolProductName = var.LogAnalyticsSolutionProductName
}


######################################################################
# AKS Cluster

module "AKSClusterRandomPrefix" {
  #Module source
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//00 RandomString/"
  #source = "./Modules/00 RandomString"

  #Module variables
  stringlenght  = "4"
  stringspecial = "false"
  stringupper   = "false"
  stringnumber  = "false"
}

module "AKSClus" {
  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//44-2 AKS ClusterwithRBAC/"
  #source = "./Modules/44-2 AKS ClusterwithRBAC"

  #Module variable
  AKSRGName           = module.ResourceGroupCloudExpo.Name
  AKSClusName         = var.AKSClus
  AKSprefix           = module.AKSClusterRandomPrefix.Result
  AKSLocation         = var.AzureRegion
  AKSSubnetId         = module.SubnetAKS1.Id
  K8SSPId             = var.AKSSP_AppId
  K8SSPSecret         = var.AKSSP_Secret
  AKSLAWId            = module.CloudExpoLogAnalytics.Id
  IsOMSAgentEnabled   = var.IsOMSAgentEnabled
  AADTenantId         = var.AzureTenantID
  AADServerAppSecret  = var.AKSAADAppServer_AppSecret
  AADServerAppId      = var.AKSAADAppServer_AppId
  AADCliAppId         = var.AKSAADAppClient_AppId
  PublicSSHKey        = var.AzurePublicSSHKey
  EnvironmentTag      = var.EnvironmentTag
  EnvironmentUsageTag = var.EnvironmentUsageTag
  OwnerTag            = var.OwnerTag
  ProvisioningDateTag = var.ProvisioningDateTag

  #the following parameters are optional because defined with default values
  AKSSVCCIDR          = "172.19.0.0/16"
  AKSDockerBridgeCIDR = "172.17.0.1/16"

  #New stuff for AKS
  AKSAZ               = var.AKSAZ
  EnablePodPolicy     = var.EnablePodPolicy
  AKSNodesRG          = var.AKSNodesRG
  AKSNodePoolType     = var.AKSNodePoolType
  AKSLBSku            = var.AKSLBSku
  EnableAKSAutoScale  = var.EnableAKSAutoScale
  MinAutoScaleCount   = var.MinAutoScaleCount
  MaxAutoScaleCount   = var.MaxAutoScaleCount
  KubeVersion         = var.KubeVersion


}


##################################################################
# associate user & groups to cluster admin role

resource "kubernetes_cluster_role_binding" "Terra_builtin_clubsteradmin_binding_userjet" {
  metadata {
    name = "terracreated-clusteradminrole-binding-userjet"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = var.AKSClusterAdminUSer2
  }
}


##################################################################
# associate user & groups to cluster admin role

resource "kubernetes_cluster_role_binding" "Terra_builtin_clubsteradmin_binding_userdfr" {
  metadata {
    name = "terracreated-clusteradminrole-binding-userdfr"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = var.AKSClusterAdminUSerDFR
  }
}

```
