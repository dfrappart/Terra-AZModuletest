##############################################################
#This module allows the creation of a vNEt
##############################################################


#Creating a vNet

resource "azurerm_kubernetes_cluster" "TerraAKS" {
  name                = "${var.AKSClusName}"
  location            = "${var.AKSLocation}"
  resource_group_name = "${var.AKSRGName}"
  
  agent_pool_profile {

  }
  
  dns_prefix = ""

  service_principal {

  }

  addon_profile {

  }
  
  kubernetes_version = "${var.KubeVersion}"

  linux_profile {

  }

  network_profile {

  }

  tags {
    Environment       = "${var.EnvironmentTag}"
    Usage             = "${var.EnvironmentUsageTag}"
    Owner             = "${var.OwnerTag}"
    ProvisioningDate  = "${var.ProvisioningDateTag}"
  }
}

