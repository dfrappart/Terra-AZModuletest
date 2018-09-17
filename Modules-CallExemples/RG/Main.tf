######################################################################
# Access to Azure
######################################################################


# Configure the Microsoft Azure Provider with Azure provider variable defined in AzureDFProvider.tf

provider "azurerm" {

    subscription_id = "${var.AzureSubscriptionID1}"
    client_id       = "${var.AzureClientID}"
    client_secret   = "${var.AzureClientSecret}"
    tenant_id       = "${var.AzureTenantID}"
}


# Creating the ResourceGroup


module "ResourceGroup" {

    #Module Location
    #source = "./Modules/ResourceGroup"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//01 ResourceGroup/"
    #Module variable
    RGName                  = "RG-Testmodule"
    RGLocation              = "Westeurope"
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"
}


