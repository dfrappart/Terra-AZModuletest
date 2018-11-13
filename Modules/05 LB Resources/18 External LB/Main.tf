######################################################################
# This module creates an external load balancer
######################################################################

#Module variables

variable "LBCount" {
  type    = "string"
  default = "1"
}

variable "ExtLBName" {
  type = "string"
}

variable "AzureRegion" {
  type = "string"
}

variable "RGName" {
  type = "string"
}

variable "FEConfigName" {
  type = "string"
}

variable "PublicIPId" {
  type = "list"
}

variable "LBBackEndPoolName" {
  type = "string"
}

variable "LBProbeName" {
  type = "string"
}

variable "LBProbePort" {
  type = "string"
}

variable "FERuleName" {
  type = "string"
}

variable "FERuleProtocol" {
  type = "string"
}

variable "FERuleFEPort" {
  type = "string"
}

variable "FERuleBEPort" {
  type = "string"
}

variable "TagEnvironment" {
  type = "string"
}

variable "TagUsage" {
  type = "string"
}

# Creating Azure Load Balancer for front end http / https

resource "azurerm_lb" "TerraExtLB" {
  count               = "${var.LBCount}"
  name                = "${var.ExtLBName}${count.index+1}"
  location            = "${var.AzureRegion}"
  resource_group_name = "${var.RGName}"

  frontend_ip_configuration {
    name                 = "${var.FEConfigName}"
    public_ip_address_id = "${element(var.PublicIPId,count.index)}"
  }

  tags {
    environment = "${var.TagEnvironment}"
    usage       = "${var.TagUsage}"
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

output "LBBackendPoolIds" {
  value = ["${azurerm_lb_backend_address_pool.TerraLBBackEndPool.*.id}"]
}

output "RGName" {
  value = "${var.RGName}"
}
