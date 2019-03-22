######################################################################
# ACR module
######################################################################

This module allows the deployment of a storage account.


Use is as follow:


# RG for the Azure Container Registry


# Creating the ResourceGroup
```hcl
module "ResourceGroupACR" {
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

# This section deploys a storage account



```hcl
module "StorageAccount" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//03 StorageAccountGP"

    #Module variable
    StorageAccountName          = "stoa${var.EnvironmentTag}acr"
    RGName                      = "${module.ResourceGroupACR.Name}"
    StorageAccountLocation      = "${var.AzureRegion}"
    StorageAccountTier          = "${lookup(var.storageaccounttier, 0)}"
    StorageReplicationType      = "${lookup(var.storagereplicationtype, 0)}"
    EnvironmentTag              = "${var.EnvironmentTag}"
    EnvironmentUsageTag         = "${var.EnvironmentUsageTag}"
    OwnerTag                    = "${var.OwnerTag}"
    ProvisioningDateTag         = "${var.ProvisioningDateTag}"
}

```

```hcl

module "ACRRandomPrefix" {
    #Module source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//00 RandomString/"

    #Module variables
    stringlenght        = "4"
    stringspecial       = "false"
    stringupper         = "false"
    
}

module "ACR" {
    #Module source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//49 Azure Container Registry/"

    #Module variables
    ACRName                     = "${module.ACRRandomPrefix.Result}${var.EnvironmentTag}acr"
    ACRRG                       = "${module.ResourceGroupACR.Name}"
    ACRLocation                 = "${var.AzureRegion}"    
    IsAdminEnabled              = "${var.ACRAdminAccountEnabled}"
    ACRSTOAID                   = "${var.ACRStorage}"
    ACRSku                      = "${var.ACRSku}"
    ACRReplList                 = "${var.ACRReplicationList}"
    EnvironmentTag              = "${var.EnvironmentTag}"
    EnvironmentUsageTag         = "${var.EnvironmentUsageTag}"
    OwnerTag                    = "${var.OwnerTag}"
    ProvisioningDateTag         = "${var.ProvisioningDateTag}"


}

```