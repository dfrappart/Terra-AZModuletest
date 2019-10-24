# VNet Peering Module

## This module deploys a VNet Peering



### 1. Module usage

Peering has to be created on both VNets to be peered.
To identify the peered VNet, its resource id is required.
The resource id is in this form:

```bash

/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/RemoteRGName/providers/Microsoft.Network/virtualNetworks/RemoteVnetName

```

```hcl

#Importing Resource group 

data "azurerm_resource_group" "ImportedRG" {

    name = "RG-Testmodule"

}

#Importing VNet

data "azurerm_virtual_network" "ImportedVNet" {

    name                = "VNet1"
    resource_group_name = data.azurerm_resource_group.ImportedRG.name

}

# Creating VNet

module "VNet" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//022 Network Peering/"

    #Module variable
    VNetPeeringName                 = "VNet1toVNet2Peering"
    RGName                          = data.azurerm_resource_group.ImportedRG.name
    LocalVNetName                   = data.azurerm_virtual_network.ImportedVNet.name
    RemoteVNetId                    = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/RemoteRGName/providers/Microsoft.Network/virtualNetworks/RemoteVnetName"
    IsVirtualNetworkAcccessAllowed  = "Lab-Moduletest"
    IsForwardedTrafficAllowed       = "Lab only"
    IsGWTransitAllowed              =
    UseRemoteGW                     = 
}

```
