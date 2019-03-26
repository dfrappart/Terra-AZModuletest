######################################################################
# Log Analytic module
######################################################################

This module allows the deployment of Log Analytic workspace.

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