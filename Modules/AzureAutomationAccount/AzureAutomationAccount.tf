###################################################################################
#This module allow the creation of of an azure automation Account
###################################################################################

#Variable declaration for Module

#The Automation Account name
variable "AutoName" {
  type    = "string"

}

#The Automation Account Location
variable "AutoLocation" {
  type    = "string"


}

#The resource group in which the Automation Account is located
variable "AutoRG" {
  type    = "string"

}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}


#Automation account creation

resource "azurerm_automation_account" "Terra-AutoAccount" {

    name                    = "${var.AutoName}"
    location                = "${var.AutoLocation}"
    resource_group_name     = "${var.AutoRG}"

    sku {

        name = "Basic"
    }

    tags {

        environment = "${var.EnvironmentTag}"
        usage       = "${var.EnvironmentUsageTag}"
    }   
}

#Output

output "Id" {

  value = "${azurerm_automation_account.Terra-AutoAccount.id}"
}