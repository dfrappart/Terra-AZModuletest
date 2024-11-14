
###################################################################################
############################## NIC creation #######################################
###################################################################################


resource "azurerm_network_interface" "VMNIC" {

  name                = "nic-${lower(var.VMSuffix)}"
  resource_group_name = var.TargetRg
  location            = var.TargetLocation

  ip_configuration {
    name                          = "ipconfig-nic-${lower(var.VMSuffix)}"
    subnet_id                     = var.TargetSubnetId
    private_ip_address_allocation = "Dynamic"

  }

  tags = merge(var.DefaultTags, var.ExtraTags)
}

#Diagnostic settings on NIC

resource "azurerm_monitor_diagnostic_setting" "VMNICDiag" {
  name               = "diag-${azurerm_network_interface.VMNIC.name}"
  target_resource_id = azurerm_network_interface.VMNIC.id
  storage_account_id = var.STALogId
  #log_analytics_workspace_id            = var.LawLogId

  metric {
    category = "AllMetrics"
    enabled  = true


  }
}

###################################################################################
############################## ASG creation #######################################
###################################################################################

resource "azurerm_application_security_group" "AsgVm" {
  count               = var.CreateAsg ? 1 : 0
  name                = "asg-${lower(var.VMSuffix)}"
  location            = var.TargetLocation
  resource_group_name = var.TargetRg

  tags = merge(var.DefaultTags, var.ExtraTags)
}

###################################################################################
############################## ASG association ####################################
###################################################################################

resource "azurerm_network_interface_application_security_group_association" "AsgVmAssociation" {
  network_interface_id          = azurerm_network_interface.VMNIC.id
  application_security_group_id = local.AsgId
}