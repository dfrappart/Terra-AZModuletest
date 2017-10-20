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

module "vNetTest" {

    #Module location
    #source = "./Modules/vNet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//vNet/"

    #Module variable
    vNetName                = "TestModule-vNet"
    RGName                  = "${data.azurerm_resource_group.ImportedRG.name}"
    vNetLocation            = "${data.azurerm_resource_group.ImportedRG.location}"
    vNetAddrespace          = ["10.0.0.0/20"]
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"


}

#Creating NSG

module "NSGTest" {

    #Module location
    #source = "./Modules/NSG"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//NSG/"

    #Module variable
    NSGName                 = "NSGTest"
    RGName                  = "${data.azurerm_resource_group.ImportedRG.name}"
    NSGLocation             = "${data.azurerm_resource_group.ImportedRG.location}"
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"


}

module "SubnetTest" {

    #Module location
    #source = "./Modules/Subnet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//Subnet/"

    #Module variable
    SubnetName                  = "SubnetTest"
    RGName                      = "${data.azurerm_resource_group.ImportedRG.name}"
    vNetName                    = "${module.vNetTest.Name}"
    Subnetaddressprefix         = "10.0.0.0/24"
    NSGid                       = "${module.NSGTest.Id}"
    EnvironmentTag              = "Lab-Moduletest"
    EnvironmentUsageTag         = "Lab only"

}

output "SubnetName" {

  value = "${module.SubnetTest.Name}"
}

output "SubnetId" {

  value = "${module.SubnetTest.Id}"
}

output "vNetName" {

  value = "${module.SubnetTest.vNetName}"
}

output "SubnetAddressPrefix" {

  value = "${module.SubnetTest.AddressPrefix}"
}