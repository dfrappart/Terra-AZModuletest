##############################################################
#This module allows the creation of a Network Watcher
##############################################################


locals {

  ResourcePrefix                      = "${lower(var.Company)}${lower(var.CountryTag)}-${lower(var.Environment)}-${lower(var.Project)}"
}

##############################################################
#Resource Group creation for Network Watcher

#Creating a Resource Group
resource "azurerm_resource_group" "RGNW" {

    
  count                               = var.IsDeploymentTypeGreenField ? 1 : 0  
  name                                = "NetworkWatcherRG"
  location                            = var.NWLocationsList[0]

  tags = {
    ResourceOwner                 = var.ResourceOwnerTag
    Country                       = var.CountryTag
    CostCenter                    = var.CostCenterTag
    ManagedBy                     = "Terraform"
  }

}

# NW Creation

resource "azurerm_network_watcher" "TerraNWW" {

  count                               = var.IsDeploymentTypeGreenField ? length(var.NWLocationsList) : 0
  name                                = "NetworkWatcher_${element(var.NWLocationsList,count.index)}"
  location                            = element(var.NWLocationsList,count.index)
  resource_group_name                 = element(azurerm_resource_group.RGNW.*.name,0)
    

  tags = {
    ResourceOwner                 = var.ResourceOwnerTag
    Country                       = var.CountryTag
    CostCenter                    = var.CostCenterTag
    ManagedBy                     = "Terraform"
  }
  
}

##############################################################
#Activating ASC and associated configurations


resource "azurerm_security_center_subscription_pricing" "ASCSubTier" {
  tier                                = var.ASCPricingTier
}

/*
resource "azurerm_security_center_contact" "ASCContact" {
  email                               = var.ASCContactMail

  alert_notifications                 = var.notifySecContact
  alerts_to_admins                    = var.notifySubAdmins
}


resource "azurerm_security_center_workspace" "LawASC" {
  count                               = var.ASCPricingTier == "Standard" ? 1 : 0
  scope                               = var.Subid
  workspace_id                        = var.LawId
  
  depends_on = [azurerm_security_center_subscription_pricing.ASCSubTier]
}
*/
##############################################################
#Default Action Group

resource "azurerm_monitor_action_group" "DefaultSubActionGroup" {
  name                                = "acg-${local.ResourcePrefix}-${substr(var.Subid,15,52)}"
  resource_group_name                 = var.RGLogs
  short_name                          = "acg${substr(var.Subid,15,8)}"

  email_receiver {
    name                              = "senttosubcontactlist"
    email_address                     = var.SubContactList
  }

  tags = {
    ResourceOwner                 = var.ResourceOwnerTag
    Country                       = var.CountryTag
    CostCenter                    = var.CostCenterTag
    ManagedBy                     = "Terraform"
  }
}

##############################################################
#Service health Alerts

resource "azurerm_monitor_activity_log_alert" "SubSVCHealth" {
  name                                = "malt-${local.ResourcePrefix}${substr(var.Subid,15,52)}-svchealth"
  resource_group_name                 = var.RGLogs
  scopes                              = [var.Subid]
  description                         = "This alert will monitor services health on the subscription level scope"

  criteria {
    category                          = "ServiceHealth"

  }

  action {
    action_group_id                   = azurerm_monitor_action_group.DefaultSubActionGroup.id
  }

  tags = {
    ResourceOwner                 = var.ResourceOwnerTag
    Country                       = var.CountryTag
    CostCenter                    = var.CostCenterTag
    ManagedBy                     = "Terraform"
  }

}

##############################################################
#Resource health Alerts

resource "azurerm_monitor_activity_log_alert" "SubRSCHealthUnavailable" {
  name                                = "malt-${local.ResourcePrefix}${substr(var.Subid,15,52)}-rschealth"
  resource_group_name                 = var.RGLogs
  scopes                              = [var.Subid]
  description                         = "This alert will monitor resources health on the subscription level scope"

  criteria {
    category                          = "ResourceHealth"

  }

  action {
    action_group_id                   = azurerm_monitor_action_group.DefaultSubActionGroup.id
  }

  tags = {
    ResourceOwner                 = var.ResourceOwnerTag
    Country                       = var.CountryTag
    CostCenter                    = var.CostCenterTag
    ManagedBy                     = "Terraform"
  }

}
