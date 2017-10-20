######################################################################
# Access to Azure
######################################################################


# Configure the Microsoft Azure Provider with Azure provider variable defined in AzureDFProvider.tf

provider "azurerm" {

    subscription_id = "${var.AzureSubscriptionID}"
    client_id       = "${var.AzureClientID}"
    client_secret   = "${var.AzureClientSecret}"
    tenant_id       = "${var.AzureTenantID}"
}


# Creating the ResourceGroup


module "ResourceGroup" {

    #Module Location
    #source = "./Modules/ResourceGroup"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//ResourceGroup/"
    #Module variable
    RGName                  = "RG-Testmodule"
    RGLocation              = "Westeurope"
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"
}


#Output

output "RGName" {

  value = "${module.ResourceGroup.Name}"
}

output "RGLocation" {

  value = "${module.ResourceGroup.Location}"
}

output "RGId" {

  value = "${module.ResourceGroup.Id}"
}