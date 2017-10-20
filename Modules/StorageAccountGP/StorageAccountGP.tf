##############################################################
#This module allow the creation of a storage account
##############################################################

#module variables

#The ST Name

variable "StorageAccountName" {
  type    = "string"

}

#The RG Name

variable "RGName" {
  type    = "string"

}

#The Storage Account Tier

variable "StorageAccountTier" {
  type    = "string"

}

#The Storage Account Replication Type, accept LRS, GRS, RAGRS and ZRS.

variable "StorageReplicationType" {
  type    = "string"
  default = "LRS"

}

#Varaibles defining Tags

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

#Storage account creation

resource "random_string" "StorageAccountfqdnprefix" {



    length      = 5
    special     = false
    upper       = false
    number      = false
}


resource "azurerm_storage_account" "Terra-STOA" {

    name                        = "${random_string.PublicIPfqdnprefix.result}${var.StorageAccountName}" 
    resource_group_name         = "${var.RGName}"
    location                    = "${var.StorageAccountLocation}"
    account_tier                = "${var.StorageAccountTier}"
    account_replication_type    = "${var.StorageReplicationType}"
    account_kind                = "Storage"

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   


}