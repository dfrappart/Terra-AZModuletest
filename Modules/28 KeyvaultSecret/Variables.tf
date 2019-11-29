######################################################################
# This module create a keyvault resource
######################################################################

#Variable declaration for Module

variable "PasswordName" {
  type = string
}

variable "PasswordValue" {
  type = string
}

variable "KeyVaultId" {
  type = string
}

# Variable to define the Tag

variable "applicationTag" {
  type    = string
  description = "Tag describing the application associated to the resource"
  default = "INFR"

}

variable "longcodeTag" {
  type    = string
  default = "INFR"
  description = "Tag indacating the long code, with 4 characters "
}

variable "costcenterTag" {
  type    = string
  default = "N/A"
  description = "Tag indacating the Section "
}

variable "businessunitTag" {
  type    = string
  default = "N/A"
  description = "Tag indacating the Domain"
}

variable "managedbyTag" {
  type    = string
  default = "INFR"
  description = "Tag indacating who manage the resource"
}

variable "environmentTag" {
  type    = string
  default = "DEV"
  description = "Tag indacating type of environment, DEV, PRD, PPR, ..."
}

variable "hostnameTag" {
  type    = string
  default = "N/A"
  description = "Tag indacating type Hostname, if applicable."
}

variable "ownerTag" {
  type    = string
  default = "That would be me"
  description = "Tag specifying the owner of the resources"
}

variable "roleTag" {
  type    = string
  default = "hubzone"
  description = "Tag specifying the owner of the resources"
}

variable "createdbyTag" {
  type    = string
  default = "Terraform"
  description = "Tag describing the way of provisioning, default to terraform for terraform config"
}

variable "backupTag" {
  type    = string
  default = "True"
  description = "Tag describing the activation of the backup or not"
}

