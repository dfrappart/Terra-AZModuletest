# Resource Group Module

## This Module deploys a Resource Group

### How to call the module

Use as follow:

```hcl

# Creating the ResourceGroup

module "ResourceGroup" {

    #Module Location
    source                            = "github.com/dfrappart/Terra-AZModuletest//Modules//01 ResourceGroup/"
    #Module variable
    RGSuffix                          = "-lab-1"
    RGLocation                        = "westeurope"
    ResourceOwnerTag                  = "DFR"
    CountryTag                        = "fr"
    CostCenterTag                     = "labtf"
    EnvironmentTag                     = "dev"

}

```

### Sample display

