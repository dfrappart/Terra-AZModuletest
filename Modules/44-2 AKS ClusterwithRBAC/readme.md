
# AKS Cluster module


This module allows the deployment of an AKS cluster.
It includes a condition to deploy either an RBAC enabled Cluster, or not.


Use is as follow:


# RG for AKS managed cluster


# Creating the ResourceGroup
```hcl
module "ResourceGroupAKS" {
  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//01 ResourceGroup/"

  #Module variable
  RGName              = "${var.RGName}"
  RGLocation          = "${var.AzureRegion}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
  OwnerTag            = "${var.OwnerTag}"
  ProvisioningDateTag = "${var.ProvisioningDateTag}"

}
```

# This section deploys an AKS cluster in advanced networking mode



```hcl
module "AKSClus" {
  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//44 AKS Cluster/"

  #Module variable
  AKSRGName           = "${var.RGName}"
  AKSLocation         = "${var.AzureRegion}"
  AKSSubnetId         = "${module.AKS_Subnet.Id}"
  K8SSPId             = "${var.AKSSP_AppId}"
  K8SSPSecret         = "${var.AKSSP_Secret}"
  AADTenantId         = "${var.AzureTenantID}"
  AADServerAppSecret  = "${var.AKSAADAppServer_AppSecret}"
  AADServerAppId      = "${var.AKSAADAppServer_AppId}"
  AADCliAppId         = "${var.AKSAADAppClient_AppId}"
  AKSLAWId            = "${module.AKSWorkspace.Id}"
  PublicSSHKey        = "${var.AzurePublicSSHKey}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
  OwnerTag            = "${var.OwnerTag}"
  ProvisioningDateTag = "${var.ProvisioningDateTag}"
  IsRBACEnable        = "true"

}

```