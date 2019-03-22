######################################################################
# Log Analytic solution module
######################################################################

This module allows the deployment of Log Analytic workplace.

Use is as follow:



# Creating a random string
```hcl
module "AKSWSRandomSuffix" {
    #Module source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//00 RandomString/"

    #Module variables
    stringlenght        = "5"
    stringspecial       = "false"
    stringupper         = "false"
    
}
```

# This section deploys log analytics workspace



```hcl
module "AKSWorkspace" {
    #Module source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//45 Log analytics workspace/"

    #Module variables
    LAWName             = "${var.AKSWorkspaceName}${module.AKSWSRandomSuffix.Result}"
    LAWLocation         = "${var.AzureRegion}"
    LAWRGName           = "${module.ResourceGroupHubSpoke.Name}"
    LAWLocation         = "${var.AzureRegion}"
    EnvironmentTag      = "${var.EnvironmentTag}"
    EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
    OwnerTag            = "${var.OwnerTag}"
    ProvisioningDateTag = "${var.ProvisioningDateTag}"
}

```

# This section deploys log analytics workspace solution for containers



```hcl
module "AKSLASol" {

    #Module source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//46 Log analytics solution/"

    #Module variables
    LASolName        = "${var.LogAnalyticsSolutionName}"
    LASolLocation    = "${var.AzureRegion}"
    LASolRGName      = "${module.ResourceGroupHubSpoke.Name}"
    LAWId            = "${module.AKSWorkspace.Id}"
    LAWName          = "${module.AKSWorkspace.Name}"
    LASolPublisher   = "${var.LogAnalyticsSolutionPublisher}"
    LASolProductName = "${var.LogAnalyticsSolutionProductName}"
}

```