######################################################################
# This module creates an external load balancer
######################################################################



# Creating Azure Load Balancer for front end http / https

resource "azurerm_lb" "TerraExtLB" {
  count               = "${var.LBCount}"
  name                = "${var.ExtLBName}${count.index+1}"
  location            = "${var.AzureRegion}"
  resource_group_name = "${var.RGName}"
  sku                 = "${var.LBSku}"

  frontend_ip_configuration {
    name                 = "${var.FEConfigName}"
    public_ip_address_id = "${element(var.PublicIPId,count.index)}"
  }

    tags {
    Environment         = "${var.EnvironmentTag}"
    Usage               = "${var.EnvironmentUsageTag}"
    Owner               = "${var.OwnerTag}"
    ProvisioningDate    = "${var.ProvisioningDateTag}"
    }
}

# Creating Back-End Address Pool

resource "azurerm_lb_backend_address_pool" "TerraLBBackEndPool" {
  count               = "${var.LBCount}"
  name                = "${var.LBBackEndPoolName}${count.index+1}"
  resource_group_name = "${var.RGName}"
  loadbalancer_id     = "${element(azurerm_lb.TerraExtLB.*.id,count.index)}"
}

# Creating Health Probe

resource "azurerm_lb_probe" "TerraLBProbe" {
  count               = "${var.LBCount}"
  name                = "${var.LBProbeName}"
  resource_group_name = "${var.RGName}"
  loadbalancer_id     = "${element(azurerm_lb.TerraExtLB.*.id,count.index)}"
  port                = "${var.LBProbePort}"
}

# Creating Load Balancer rules

resource "azurerm_lb_rule" "TerraLBFrondEndrule" {
  count                          = "${var.LBCount}"
  name                           = "${var.FERuleName}"
  resource_group_name            = "${var.RGName}"
  loadbalancer_id                = "${element(azurerm_lb.TerraExtLB.*.id,count.index)}"
  protocol                       = "${var.FERuleProtocol}"
  probe_id                       = "${element(azurerm_lb_probe.TerraLBProbe.*.id,count.index)}"
  frontend_port                  = "${var.FERuleFEPort}"
  frontend_ip_configuration_name = "${var.FEConfigName}"
  backend_port                   = "${var.FERuleBEPort}"
  backend_address_pool_id        = "${element(azurerm_lb_backend_address_pool.TerraLBBackEndPool.*.id,count.index)}"
}

