# Terraform : create Databricks workspace

This module is used to create Databricks workspace integrated to Vnet

## Resources deployed


|Resources type | Resources usage | naming convention |
|---------------|:---------------:|------------------:|
|Resource Group | Group the module resources |CompanyCountry-Environment-rsg-project-freesuffix |
|Virtual Network | Host the Databricks cluster | CompanyCountry-Environment-vnt-project-freesuffix |
|Subnet | Databricks front subnet. Required by default for databricks workspace provisioning. Configured with delegation to Azure databricks | CompanyCountry-Environment-sub-project-freesuffix |
|Subnet | Databricks back subnet. Required by default for databricks workspace provisioning. Configured with delegation to Azure databricks | CompanyCountry-Environment-sub-project-freesuffix |
|Subnet | azure bastion subnet dedicated subnet for azure bastion service | AzureBastionSubnet |
|NSG Front Subnet | NSG for public databricks workspace subnet. Required for provisioning | CompanyCountry-Environment-nsg-project-freesuffix |
|NSG Back Subnet | NSG for private databricks workspace subnet. Required for provisioning | CompanyCountry-Environment-nsg-project-freesuffix |
|Databricks workspace | Wrokspace Vnet | CompanyCountry-Environment-nsg-project-freesuffix |

## How to use this module

Call the module as follow: 

```hcl

######################################################
# This file call the databricks workspace module
######################################################

module "databricksworkspace" {
    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//50 VNetIntegrateddDatabrick"

    #module variable
    RGName                              = var.RGName
    RGLocation                          = var.RGLocation
    VNetName                            = var.VNetName
    VNetAddressSpace                    = var.VNetAddressSpace
    SubnetName                          = var.SubnetName
    Subnetaddressprefix                 = var.Subnetaddressprefix
    SVCEP                               = var.SVCEP
    NSGName                             = var.NSGName
    DTBWSName                           = var.DTBWSName
    DTBWSSku                            = var.DTBWSSku
    EnvironmentTag                      = var.EnvironmentTag
    EnvironmentUsageTag                 = var.EnvironmentUsageTag
    OwnerTag                            = var.OwnerTag
    ProvisioningDateTag                 = var.ProvisioningDateTag

```


