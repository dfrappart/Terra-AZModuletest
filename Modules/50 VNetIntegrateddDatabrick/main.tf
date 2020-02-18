
######################################################
# Module VNET + DTB Workspace
######################################################



locals {

  STAPrefix                           = "${lower(var.Company)}${lower(var.CountryTag)}${lower(var.Environment)}${lower(var.Project)}st"
  ResourcePrefix                      = "${lower(var.Company)}${lower(var.CountryTag)}-${lower(var.Environment)}-${lower(var.Project)}-"
  DTBWSName                           = "${lower(var.Company)}${lower(var.CountryTag)}${lower(var.Environment)}${lower(var.Project)}dbw${lower(var.DTBWSName)}"
  
}



#Creating a Resource Group


resource "azurerm_resource_group" "Terra_RG" {

    
    name                        = "${local.ResourcePrefix}rsg-${var.RGName}"
    location                    = var.RGLocation

    tags = {
    Environment       = var.EnvironmentTag
    Usage             = var.EnvironmentUsageTag
    Owner             = var.OwnerTag
    ProvisioningDate  = var.ProvisioningDateTag

    }

}

# Creating VNet

resource "azurerm_virtual_network" "Terra_VNet" {
  name                          = "${local.ResourcePrefix}vnt-${var.VNetName}"
  resource_group_name           = azurerm_resource_group.Terra_RG.name
  address_space                 = var.VNetAddressSpace
  location                      =  azurerm_resource_group.Terra_RG.location

    tags = {
    Environment       = var.EnvironmentTag
    Usage             = var.EnvironmentUsageTag
    Owner             = var.OwnerTag
    ProvisioningDate  = var.ProvisioningDateTag

    }
}

# Creating Subnet

resource "azurerm_subnet" "Terra_Subnet" {
  count                         = 2
  name                          = "${local.ResourcePrefix}sub-${element(var.SubnetName,count.index)}"
  resource_group_name           = azurerm_resource_group.Terra_RG.name
  virtual_network_name          = azurerm_virtual_network.Terra_VNet.name
  address_prefix                = element(var.Subnetaddressprefix,count.index)
  network_security_group_id     = element(azurerm_network_security_group.Terra_NSG.*.id,count.index)
  service_endpoints             = var.SVCEP
  delegation {
    name                        = "${element(var.SubnetName,count.index)}delegation"
    service_delegation {
      name                      = "Microsoft.Databricks/workspaces"
    }
  }

}

resource "azurerm_subnet_network_security_group_association" "Terra_Subnet_NSG_Association" {
    count                       = 2
    subnet_id                   = element(azurerm_subnet.Terra_Subnet.*.id,count.index)
    network_security_group_id   = element(azurerm_network_security_group.Terra_NSG.*.id,count.index)
}

# Creating Creating NSG

resource "azurerm_network_security_group" "Terra_NSG" {
  count                         = 2
  name                          = "${local.ResourcePrefix}nsg-${element(var.NSGName,count.index)}"
  location                      = azurerm_resource_group.Terra_RG.location
  resource_group_name           = azurerm_resource_group.Terra_RG.name

  tags = {
    Environment       = var.EnvironmentTag
    Usage             = var.EnvironmentUsageTag
    Owner             = var.OwnerTag
    ProvisioningDate  = var.ProvisioningDateTag

  }
}

# Creating DTB Workspace

resource "azurerm_databricks_workspace" "Terra_DTBWS" {
  name                          = substr(local.DTBWSName,0,32)
  location                      = azurerm_resource_group.Terra_RG.location
  resource_group_name           = azurerm_resource_group.Terra_RG.name
  sku                           = var.DTBWSSku
  custom_parameters {
    no_public_ip                = true
    virtual_network_id          = azurerm_virtual_network.Terra_VNet.id
    public_subnet_name          = element(azurerm_subnet.Terra_Subnet.*.name,0)
    private_subnet_name         = element(azurerm_subnet.Terra_Subnet.*.name,1)

  }
    
  tags = {
    Environment       = var.EnvironmentTag
    Usage             = var.EnvironmentUsageTag
    Owner             = var.OwnerTag
    ProvisioningDate  = var.ProvisioningDateTag
  }
}