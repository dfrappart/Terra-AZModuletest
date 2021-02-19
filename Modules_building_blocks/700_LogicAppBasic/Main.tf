##############################################################
#This module allows the creation of a storage account
##############################################################

resource "azurerm_logic_app_workflow" "Terra_LGA" {

  lifecycle {
    ignore_changes                        = [
      parameters


    ]
  }

  name                                  = "lga${var.LGASuffix}"
  location                              = var.LGALocation
  resource_group_name                   = var.RGName
  integration_service_environment_id    = var.LGAISEId
  logic_app_integration_account_id      = var.LGAIAId
  workflow_schema                       = var.LGASchema
  workflow_version                      = var.LGAWorkflowVersion
  parameters                            = var.LGAParam

  tags = {
    ResourceOwner                       = var.ResourceOwnerTag
    Country                             = var.CountryTag
    CostCenter                          = var.CostCenterTag
    Environment                         = var.EnvironmentTag
    ManagedBy                           = "Terraform"
  } 

}

