##############################################################
#Variable definition file
##############################################################


#Variable declaration for Module



variable "RGSuffix" {
  type                = string
  default             = "-1"
}


variable "RGLocation" {
  type                = string
  default             = "westeurope"
}


###################################################################
#Tag related variables section

variable "DefaultTags" {
  type                                  = map
  description                           = "Define a set of default tags"
  default                               = {
    ResourceOwner                       = "That would be me"
    Country                             = "fr"
    CostCenter                          = "labtf"
    Project                             = "tfmodule"
    Environment                         = "lab"
    ManagedBy                           = "Terraform"

  }
}

variable "ExtraTags" {
  type                                  = map
  description                           = "Define a set of additional optional tags."
  default                               = {}
}