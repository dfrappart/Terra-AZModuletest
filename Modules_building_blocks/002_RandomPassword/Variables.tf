#################################################################
# This module creates a random string
#################################################################

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
