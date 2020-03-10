######################################################
# This file contains the resource for tonite meetup
# Yes we do live coding !!!
######################################################

#Creating a Resource Group


resource "azurerm_resource_group" "Terra_RG" {

    
    name                        = "rg${var.RGName}"
    location                    = var.RGLocation

    tags = {
    Environment                 = var.EnvironmentTag
    Usage                       = var.EnvironmentUsageTag
    Owner                       = var.OwnerTag
    ProvisioningDate            = var.ProvisioningDateTag

    }

}

# Creating VNet

resource "azurerm_virtual_network" "Terra_VNet" {
  name                          = "vnt${var.VNetName}"
  resource_group_name           = azurerm_resource_group.Terra_RG.name
  address_space                 = var.VNetAddressSpace
  location                      = azurerm_resource_group.Terra_RG.location

    tags = {
    Environment                 = var.EnvironmentTag
    Usage                       = var.EnvironmentUsageTag
    Owner                       = var.OwnerTag
    ProvisioningDate            = var.ProvisioningDateTag

    }
}

# Creating Subnet

resource "azurerm_subnet" "Terra_Subnet" {
  count                         = 2
  name                          = "sub${element(var.SubnetName,count.index)}"
  resource_group_name           = azurerm_resource_group.Terra_RG.name
  virtual_network_name          = azurerm_virtual_network.Terra_VNet.name
  address_prefix                = element(var.Subnetaddressprefix,count.index)
  service_endpoints             = var.SVCEP


}

resource "azurerm_subnet_network_security_group_association" "Terra_Subnet_NSG_Association" {
    count                       = 2
    subnet_id                   = element(azurerm_subnet.Terra_Subnet.*.id,count.index)
    network_security_group_id   = element(azurerm_network_security_group.Terra_NSG.*.id,count.index)
}

# Creating Creating NSG

resource "azurerm_network_security_group" "Terra_NSG" {
  count                         = 2
  name                          = "nsg${element(var.NSGName,count.index)}"
  location                      = azurerm_resource_group.Terra_RG.location
  resource_group_name           = azurerm_resource_group.Terra_RG.name

  tags = {
    Environment                 = var.EnvironmentTag
    Usage                       = var.EnvironmentUsageTag
    Owner                       = var.OwnerTag
    ProvisioningDate            = var.ProvisioningDateTag

  }
}


# creation of the rule to allow http

resource "azurerm_network_security_rule" "Terra_NSGRulewSTags" {
  name                        = "AllowHttpInFromInternet"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "tcp"
  source_port_range           = "*"
  destination_port_range      = 80
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.Terra_RG.name
  network_security_group_name = element(azurerm_network_security_group.Terra_NSG.*.name,0)
}

# Public Ip for LB

resource "azurerm_public_ip" "Terra_PIP" {
  name                           = "pip${var.PublicIPName}"
  location                       = azurerm_resource_group.Terra_RG.location
  resource_group_name            = azurerm_resource_group.Terra_RG.name
  allocation_method              = "Static"
  sku                            = "standard"
  domain_name_label              = "${lower(var.EnvironmentTag)}${lower(var.PublicIPName)}"


  tags = {
    Environment                  = var.EnvironmentTag
    Usage                        = var.EnvironmentUsageTag
    Owner                        = var.OwnerTag
    ProvisioningDate             = var.ProvisioningDateTag
  }
}


# Creating Azure Load Balancer for front end http / https

resource "azurerm_lb" "Terra_ExtLB" {
  name                            = "lb${var.ExtLBName}"
  location                        = azurerm_resource_group.Terra_RG.location
  resource_group_name             = azurerm_resource_group.Terra_RG.name
  sku                             = var.LBSku

  frontend_ip_configuration {
    name                          = var.FEConfigName
    public_ip_address_id          = azurerm_public_ip.Terra_PIP.id
  }

    tags = {
    Environment                   = var.EnvironmentTag
    Usage                         = var.EnvironmentUsageTag
    Owner                         = var.OwnerTag
    ProvisioningDate              = var.ProvisioningDateTag
    }
}


# Creating Back-End Address Pool

resource "azurerm_lb_backend_address_pool" "Terra_LBBackEndPool" {
  name                            = var.LBBackEndPoolName
  resource_group_name             = azurerm_resource_group.Terra_RG.name
  loadbalancer_id                 = azurerm_lb.Terra_ExtLB.id
}

# Creating Health Probe

resource "azurerm_lb_probe" "Terra_LBProbe" {
  name                            = var.LBProbeName
  resource_group_name             = azurerm_resource_group.Terra_RG.name
  loadbalancer_id                 = azurerm_lb.Terra_ExtLB.id
  port                            = var.LBProbePort
}



# Creating Load Balancer rules

resource "azurerm_lb_rule" "Terra_LBFrondEndrule" {
  name                            = var.FERuleName
  resource_group_name             = azurerm_resource_group.Terra_RG.name
  loadbalancer_id                 = azurerm_lb.Terra_ExtLB.id
  protocol                        = var.FERuleProtocol
  probe_id                        = azurerm_lb_probe.Terra_LBProbe.id
  frontend_port                   = var.FERuleFEPort
  frontend_ip_configuration_name  = var.FEConfigName
  backend_port                    = var.FERuleBEPort
  backend_address_pool_id         = azurerm_lb_backend_address_pool.Terra_LBBackEndPool.id
  #disable_outbound_snat           = true
}



data "template_file" "cloudconfig" {

  template = "${file("${path.root}${var.CloudinitscriptPath}")}"
}

#https://www.terraform.io/docs/providers/template/d/cloudinit_config.html
data "template_cloudinit_config" "config" {
  #gzip          = true
  base64_encode = true

  part {
    content = data.template_file.cloudconfig.rendered
  }
}





resource "azurerm_linux_virtual_machine_scale_set" "Terra_LinuxVMSS" {
  name                            = "vmss${var.VMSSName}"
  resource_group_name             = azurerm_resource_group.Terra_RG.name
  location                        = azurerm_resource_group.Terra_RG.location
  sku                             = var.VMSSSku
  instances                       = var.VMSSInstanceNumber
  admin_username                  = var.VMAdminName
  admin_password                  = var.VMAdminPassword
  disable_password_authentication = false

#  admin_ssh_key {
#    username                      = var.VMAdminName
#    public_key                    = "${file("${path.root}${var.PublicSSHKeyPath}")}"
#
#  }
#
  source_image_reference {
    publisher                     = var.VMImagePublisherName
    offer                         = var.VMImageOfferName
    sku                           = var.VMImageSku
    version                       = "latest"
  }

  os_disk {
    storage_account_type          = var.OSDiskTier
    caching                       = var.OSDiskCaching
  }


  network_interface {
    name                          = "nic${var.VMSSNICName}"
    primary                       = true

  
    ip_configuration {
      name                          = "ipconfigvmss${var.VMSSNICNameConfig}"
      primary                       = true
      subnet_id                     = element(azurerm_subnet.Terra_Subnet.*.id,0)
      #application_security_group_ids = var.ASGIds
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.Terra_LBBackEndPool.id]

    }
  }

  custom_data = data.template_cloudinit_config.config.rendered



    tags = {
        Environment                   = var.EnvironmentTag
        Usage                         = var.EnvironmentUsageTag
        Owner                         = var.OwnerTag
        ProvisioningDate              = var.ProvisioningDateTag
    }

}



resource "azurerm_public_ip" "Terra_BastionPIP" {
  name                           = "pipbastion${var.PublicIPName}"
  location                       = azurerm_resource_group.Terra_RG.location
  resource_group_name            = azurerm_resource_group.Terra_RG.name
  allocation_method              = "Static"
  sku                            = "standard"
  domain_name_label              = "${lower(var.EnvironmentTag)}${lower(var.PublicIPName)}bastion"


  tags = {
    Environment                  = var.EnvironmentTag
    Usage                        = var.EnvironmentUsageTag
    Owner                        = var.OwnerTag
    ProvisioningDate             = var.ProvisioningDateTag
  }
}



resource "azurerm_subnet" "Terra_SubnetBastion" {

  name                          = "AzureBastionSubnet"
  resource_group_name           = azurerm_resource_group.Terra_RG.name
  virtual_network_name          = azurerm_virtual_network.Terra_VNet.name
  address_prefix                = element(var.Subnetaddressprefix,2)
  service_endpoints             = var.SVCEP


}

resource "azurerm_bastion_host" "Terra_Bastion" {
  name                = "bastion${var.VMSSName}"
  location            = azurerm_resource_group.Terra_RG.location
  resource_group_name = azurerm_resource_group.Terra_RG.name

  ip_configuration {
    name                 = "${var.VMSSName}IPconfig"
    subnet_id            = azurerm_subnet.Terra_SubnetBastion.id
    public_ip_address_id = azurerm_public_ip.Terra_BastionPIP.id
  }

    tags = {
        Environment                   = var.EnvironmentTag
        Usage                         = var.EnvironmentUsageTag
        Owner                         = var.OwnerTag
        ProvisioningDate              = var.ProvisioningDateTag
    }
}