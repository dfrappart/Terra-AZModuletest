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


#Importing Resource group 

data "azurerm_resource_group" "ImportedRG" {

    name = "RG-Testmodule"

}


# Creating vNET

module "vNet" {

    #Module location
    #source = "./Modules/vNet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//vNet/"

    #Module variable
    vNetName                = "TestModule-vNet"
    RGName                  = "${data.azurerm_resource_group.ImportedRG.name}"
    vNetLocation            = "${data.azurerm_resource_group.ImportedRG.location}"
    vNetAddressSpace        = ["10.0.0.0/20"]
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"


}


#Output for the vNet

#Output for the vNET module

output "vNetName" {

  value = "${module.vNet.Name}"
}

output "vNetId" {

  value = "${module.vNet.Id}"
}

output "vNetAddressspace" {

  value = "${module.vNet.Addressspace}"
}

output "vNetLocation" {

  value = "${module.vNet.Location}"
}