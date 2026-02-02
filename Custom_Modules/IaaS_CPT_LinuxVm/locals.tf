
locals {

  TargetLocation = var.TargetLocation == "" ? data.azurerm_resource_group.TargetRg.location : var.TargetLocation
  AsgId          = var.CreateAsg ? azurerm_application_security_group.AsgVm[0].id : var.AsgId

}