#################################################################
# This module creates a random string
#################################################################

variable "stringlenght" {
    type                     = string
    default                  = "25"
}

variable "stringspecial" {
    type                     = string
    default                  = "true"
}

variable "stringupper" {
    type                     = string
    default                  = "true"
}

variable "stringnumber" {
    type                    = string
    default                 = "true"
}
