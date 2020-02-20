######################################################################
# This module creates an external load balancer
######################################################################



# Creating Azure Load Balancer for front end http / https

resource "azurerm_lb" "TerraExtLB" {
  name                = var.ExtLBName
  location            = var.AzureRegion
  resource_group_name = var.RGName
  sku                 = var.LBSku

  frontend_ip_configuration {
    name                 = var.FEConfigName
    public_ip_address_id = var.PublicIPId
  }

    tags = {
    Environment         = var.EnvironmentTag
    Usage               = var.EnvironmentUsageTag
    Owner               = var.OwnerTag
    ProvisioningDate    = var.ProvisioningDateTag
    }
}

# Creating Back-End Address Pool

resource "azurerm_lb_backend_address_pool" "TerraLBBackEndPool" {
  name                = var.LBBackEndPoolName
  resource_group_name = var.RGName
  loadbalancer_id     = azurerm_lb.TerraExtLB.id
}

# Creating Health Probe

resource "azurerm_lb_probe" "TerraLBProbe" {
  name                = var.LBProbeName
  resource_group_name = var.RGName
  loadbalancer_id     = azurerm_lb.TerraExtLB.id
  port                = var.LBProbePort
}

# Creating Load Balancer rules

resource "azurerm_lb_rule" "TerraLBFrondEndrule" {
  name                           = var.FERuleName
  resource_group_name            = var.RGName
  loadbalancer_id                = azurerm_lb.TerraExtLB.id
  protocol                       = var.FERuleProtocol
  probe_id                       = azurerm_lb_probe.TerraLBProbe.id
  frontend_port                  = var.FERuleFEPort
  frontend_ip_configuration_name = var.FEConfigName
  backend_port                   = var.FERuleBEPort
  backend_address_pool_id        = azurerm_lb_backend_address_pool.TerraLBBackEndPool.id
}

