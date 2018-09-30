######################################################
# Variables for Template
######################################################

# Variable to define the Azure Region

variable "AzureRegion" {

    type    = "string"
    default = "westeurope"
}


# Variable to define the Tag


variable "EnvironmentTag" {
  type    = "string"
  default = "Modulebasedtemplate"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Lab"
}


# Variable to define the Resource Group Name

variable "RSGName" {

    type    = "string"
    default = "RSG-Terra-ModuleDemo"
}


#Variable defining the vnet ip range


variable "vNetIPRange" {

    type = "list"
    default = ["10.0.0.0/20"]
}

variable "SubnetAddressRange" {

    
    default = {
      "0" = "10.0.0.0/24"
      "1" = "10.0.1.0/24"
      "2" = "10.0.2.0/24"
      "3" = "10.0.3.0/24"
      "4" = "10.0.4.0/24"
    }
}


#variable defining VM size
variable "VMSize" {
 
  default = {
      "0" = "Standard_F1"
      "1" = "Standard_F1s"
      "2" = "Standard_D1_v2"
      "3" = "Standard_DS1_v2"
      "4" = "Standard_B1s"
      "5" = "Standard_B1ms"
      "6" = "Standard_F2"
      "7" = "Standard_F2s"
      "8" = "Standard_D2_v3"
      "9" = "Standard_D2s_v3"
      "10" = "Standard_B2s"
      "11" = "Standard_B2ms"
  }
}

# variable defining storage account tier

variable "storageaccounttier" {

    
    default = {
      "0" = "standard_lrs"
      "1" = "premium_lrs"
      "2" = "standard_grs"
      "3" = "premium_grs"
     }
}

# variable defining storage account tier for managed disk

variable "Manageddiskstoragetier" {

    
    default = {
      "0" = "standard_lrs"
      "1" = "premium_lrs"

    }
}