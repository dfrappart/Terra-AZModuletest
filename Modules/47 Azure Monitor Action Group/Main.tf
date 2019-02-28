##############################################################
#This module allows the creation of an Action group
##############################################################


#Creating a vNet

resource "azurerm_monitor_action_group" "TerraLogTerraActionGroup" {
  name                    = "${var.AGName}"
  resource_group_name     = "${var.AGRGName}"
  short_name              = "${var.AGSName}"
  enabled                 = "${var.Isenabled}"

  email_receiver {
    name            = "${var.EmailReceiver1}"
    email_address   = "${var.EmailReceiver1Address}"
  }

  email_receiver {
    name            = "${var.EmailReceiver2}"
    email_address   = "${var.EmailReceiver2Address}"
  }

  sms_receiver {
    name            = "${var.SMSReceiver1}"
    country_code    = "${var.SMSReceiver1CC}"
    phone_number    = "${var.SMSReceiver1Number}"

  }

  sms_receiver {
    name            = "${var.SMSReceiver2}"
    country_code    = "${var.SMSReceiver2CC}"
    phone_number    = "${var.SMSReceiver2Number}"
  }
}

