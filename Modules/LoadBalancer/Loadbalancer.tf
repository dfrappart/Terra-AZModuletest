###################################################################################
#This module allow the creation of aload balancer
#To create a LB, following resources are required
#azurerm_lb
#azurerm_lb_backend_address_pool
#azurerm_lb_probe
#azurerm_lb_probe
#azurerm_lb_rule
#Optionnaly, it is possible to add NAT Rule to allow connection in NAT through 
#the lb to a VM in RDP or SSH for example 
###################################################################################

#Variable declaration for Module

#The LB name
variable "LBName" {
  type    = "string"

}

#The LB Region
variable "LBLocation" {
  type    = "string"

}

#The LB Respurce Group
variable "LBRG" {
  type    = "string"

}


#The LB Backend address pool
variable "LBBEPool" {
  type    = "string"

}


#The LB Backend address pool
variable "LBBEPool" {
  type    = "string"

}

#The LB Health Probe NAme
variable "LBHealthProbeName" {
  type    = "string"

}

#The LB Health Probe Port

variable "LBHealthProbePort" {
  type    = "string"

}

#The LB Rule Name
variable "LBRuleName" {
  type    = "string"

}

#The LB Rule Protocol
variable "LBRuleProtocol" {
  type    = "string"

}

#The LB Rule FrontEnd Port
variable "LBRuleFEPort" {
  type    = "string"

}

#The LB Rule BackEnd Port
variable "LBRuleBEPort" {
  type    = "string"

}

#The LB Nat Rule Name
variable "LBNATRuleName" {
  type    = "string"

}


#The LB NAT Rule Protocol
variable "LBNATRuleProtocol" {
  type    = "string"

}


#The LB NAT Rule FE Port
variable "LBNATRuleFEPort" {
  type    = "string"

}


#The LB BE Port
variable "LBNATRuleBEPort" {
  type    = "string"

}


#The LB NAT Pool Name
variable "LBNATPoolName" {
  type    = "string"

}


#The LB NAT Pool Protocol
variable "LBNATPoolProtocol" {
  type    = "string"

}


#The LB NAT Pool FE port start
variable "LBNATPoolFEPortStart" {
  type    = "string"

}


#The LB NAT Pool FE port end
variable "LBNATPoolFEPortEnd" {
  type    = "string"

}



#The LB NAT Pool BE port
variable "LBNATPoolBEPortEnd" {
  type    = "string"

}


# Creating Load Balancer



resource "azurerm_lb" "LB-TerraLB" {

    name                        = "${var.LBName}"
    location                    = "${var.LBLocation}"
    resource_group_name         = "${var.LBRG}"

    frontend_ip_configuration {

        name                    = "weblbbasiclinux"
        public_ip_address_id    = "${azurerm_public_ip.PublicIP-FrontEndBasicLinux.id}"
    }

    tags {
    environment = "${var.TagEnvironment}"
    usage       = "${var.TagUsage}"
    }
}


# Creating Back-End Address Pool

resource "azurerm_lb_backend_address_pool" "LB-WebFRontEndBackEndPool" {

    name                = "LB-WebFRontEndBackEndPool"
    resource_group_name = "${azurerm_resource_group.RSG-BasicLinux.name}"
    loadbalancer_id     = "${azurerm_lb.LB-WebFrontEndBasicLinux.id}"
    
}


# Creating Health Probe

resource "azurerm_lb_probe" "LB-WebFrontEnd-sshprobe" {

    name                = "LB-WebFrontEnd-sshprobe"
    resource_group_name = "${azurerm_resource_group.RSG-BasicLinux.name}"
    loadbalancer_id     = "${azurerm_lb.LB-WebFrontEndBasicLinux.id}"
    port                = 22


}

# Creating Load Balancer rules

resource "azurerm_lb_rule" "LB-WebFrondEndrule" {

    name                            = "LB-WebFrondEndrule"
    resource_group_name             = "${azurerm_resource_group.RSG-BasicLinux.name}"
    loadbalancer_id                 = "${azurerm_lb.LB-WebFrontEndBasicLinux.id}"
    protocol                        = "tcp"
    probe_id                        = "${azurerm_lb_probe.LB-WebFrontEnd-sshprobe.id}"
    frontend_port                   = 80
    #frontend_ip_configuration_name  = "${azurerm_public_ip.PublicIP-FrontEndBasicLinux.name}"
    frontend_ip_configuration_name = "weblbbasiclinux"
    backend_port                    = 80
    backend_address_pool_id         = "${azurerm_lb_backend_address_pool.LB-WebFRontEndBackEndPool.id}"


}
