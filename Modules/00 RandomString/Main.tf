#################################################################
# This module creates a random string
#################################################################



#Random string creation

resource "random_string" "TerraRandomstring" {



    length      = "${var.stringlenght}"
    special     = "${var.stringspecial}"
    upper       = "${var.stringupper}"
    number      = "${var.stringnumber}"

}
