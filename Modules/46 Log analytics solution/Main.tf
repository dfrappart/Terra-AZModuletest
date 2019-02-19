##############################################################
#This module allows the creation of a log analytics solution
##############################################################


#Creating a vNet

resource "azurerm_log_analytics_solution" "TerraLogAnalyticsSol" {
  solution_name                 = "${var.LASolName}"
  location                      = "${var.LASolLocation}"
  resource_group_name           = "${var.LASolRGName}"
  workspace_resource_id         = "${var.LAWId}"
  workspace_name                = "${var.LAWName}"

  plan {
    publisher = "${var.LASolPublisher}"
    product   = "${var.LASolProductName}"
  }


}

