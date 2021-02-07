######################################################################
# This module create a keyvault resource
######################################################################

#Variable declaration for Module

variable "KeyVaultSecretSuffix" {
  type                = string
  description         = "The suffix for the secret"
}

variable "PasswordValue" {
  type                = string
  description         = "The value of the password"
  default             = "notspecified"
}

variable "KeyVaultId" {
  type                = string
  description         = "The ID of the Key Vault where the Secret should be created."
}

variable "StartingDate" {
  type                = string
  default             = "notspecified"
  description         = "An UTC datetime (Y-m-H:M:S'Z') defining when the secret is usable"
}

variable "ExpirationDate" {
  type                = string
  default             = "notspecified"
  description         = "An UTC datetime (Y-m-H:M:S'Z') defining when the secret expires"
}


variable "stringlenght" {
    type                = number
    default             = 16
}

variable "stringspecial" {
    type                = string
    default             = true
}

variable "stringupper" {
    type                = string
    default             = true
}

variable "stringnumber" {
    type                = string
    default             = true
 
}

###################################################################
#Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type                  = string
  description           = "Tag describing the owner"
  default               = "That would be me"
}

variable "CountryTag" {
  type                  = string
  description           = "Tag describing the Country"
  default               = "fr"
}

variable "CostCenterTag" {
  type                  = string
  description           = "Tag describing the Cost Center"
  default               = "tflab"
}


variable "Company" {
  type                  = string
  description           = "The Company owner of the resources"
  default               = "dfitc"
}

variable "Project" {
  type                  = string
  description           = "The name of the project"
  default               = "tflab"
}

variable "Environment" {
  type                  = string
  description           = "The environment, dev, prod..."
  default               = "lab"
}

variable "SecretUsedBy" {
  type                = string
  default             = "notspecified"
  description         = "Specify who uses this password"
}
