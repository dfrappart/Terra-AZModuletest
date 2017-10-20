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


# Creating vNET

module "vNetTest" {

    #Module location
    #source = "./Modules/vNet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//vNet/"

    #Module variable
    vNetName                = "TestModule-vNet"
    RGName                  = "${module.ResourceGroup.Name}"
    vNetLocation            = "${module.ResourceGroup.Location}"
    vNetAddrespace          = ["10.0.0.0/20","192.168.0.0/20"]
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"


}

# Creating Subnet

module "NSGTest1" {

    #Module location
    #source = "./Modules/NSG"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//NSG/"

    #Module variable
    NSGName                 = "NSGTest1"
    RGName                  = "${module.ResourceGroup.Name}"
    NSGLocation             = "${module.ResourceGroup.Location}"
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"


}

module "SubnetTest1" {

    #Module location
    #source = "./Modules/Subnet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//Subnet/"

    #Module variable
    SubnetName                  = "SubnetTest1"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.vNetTest.Name}"
    Subnetaddressprefix         = "10.0.0.0/24"
    NSGid                       = "${module.NSGTest1.Id}"
    EnvironmentTag              = "Lab-Moduletest"
    EnvironmentUsageTag         = "Lab only"

}

#Creating NSG

module "NSGTest2" {

    #Module location
    #source = "./Modules/NSG"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//NSG/"

    #Module variable
    NSGName                 = "NSGTest2"
    RGName                  = "${module.ResourceGroup.Name}"
    NSGLocation             = "${module.ResourceGroup.Location}"
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"


}

module "SubnetTest2" {

    #Module location
    #source = "./Modules/Subnet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//Subnet/"

    #Module variable
    SubnetName                  = "SubnetTest2"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.vNetTest.Name}"
    Subnetaddressprefix         = "192.168.0.0/24"
    NSGid                       = "${module.NSGTest2.Id}"
    EnvironmentTag              = "Lab-Moduletest"
    EnvironmentUsageTag         = "Lab only"

}

#Public IP Creation

module "TestPublicIP" {

    #Module Location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//PublicIP"

    #Module variables
    PublicIPName            = "testpublicip"
    PublicIPLocation        = "${module.ResourceGroup.Location}"
    RGName                  = "${module.ResourceGroup.Name}"
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"
}


#Datadisk creation

module "Datadisk-Test-01" {

    #Module Location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//ManagedDisk"    
    
    #Module variable
    ManageddiskName         = "Test-01-Datadisk"
    RGName                  = "${module.ResourceGroup.Name}"
    ManagedDiskLocation     = "${module.ResourceGroup.Location}"
    StorageAccountType      = "premium_lrs"
    CreateOption            = "empty"
    DiskSizeInGB            = "63"

}


#VM Creation

module "Test-AS" {

    #module location
    #source = "./Modules/AvailabilitySet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//AvailabilitySet/"

    #Module variable
    ASName                      = "Test-AS"
    ASLocation                  = "${module.ResourceGroup.Location}"
    RGName                      = "${module.ResourceGroup.Name}"

}

module "TestVM" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//WinVMwith2Nics"
    

    #Module variables
    VMName              = "TestVM"
    VMLocation          = "${module.ResourceGroup.Location}"
    VMRG                = "${module.ResourceGroup.Name}"
    VMSize              = "Standard_F1S"
    VM-ASID             = "${module.Test-AS.Id}"
    VMPublisher         = "microsoftwindowsserver"
    VMOffer             = "WindowsServer"
    VMSku               = "2016-Datacenter"
    VMStorageTier       = "premium_lrs"
    VMDatadiskId        = "${module.Datadisk-Test-01.Id}"
    VMDataDiskSize      = "${module.Datadisk-Test-01.Size}"
    PublicIPId          = "${module.TestPublicIP.Id}"
    SubnetId1           = "${module.SubnetTest1.Id}"
    SubnetId2           = "${module.SubnetTest2.Id}"
}



