#################################################################
# This module creates a random string
#################################################################

variable "stringlenght" {
    type = "string"
    default = "25"
}

variable "stringspecial" {
    type = "string"
    default = "true"
}

variable "stringupper" {
    type = "string"
    default = "true"
}

variable "stringnumber" {
    type = "string"
    default = "true"
}

#Random string creation

resource "random_string" "TerraRandomstring" {



    length      = "${var.stringlenght}"
    special     = "${var.stringspecial}"
    upper       = "${var.stringupper}"
    number      = "${var.stringnumber}"

}

#Output

output "Result" {

    value = "${random_string.TerraRandomstring.result}"
}
