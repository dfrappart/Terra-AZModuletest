##############################################################
#This module allows the creation of an action group
##############################################################

#Variable declaration for Module


#The Action Group Name
variable "AGName" {
  type    = "string"

}

#The Action Group Resource Group
variable "AGRGName" {
  type    = "string"
  default = "true"

}

variable "AGSName" {
  type    = "string"
  default = "true"

}

variable "IsEnabled" {
  type = "string"
}
#The name of the Email Receiver 1
variable "EmailReceiver1" {
  type    = "string"

}

#The email address of the Email Receiver 1
variable "EmailReceiver1Address" {
  type    = "string"

}

#The name of the Email Receiver 2
variable "EmailReceiver2" {
  type    = "string"

}

#The email address of the Email Receiver 2
variable "EmailReceiver2Address" {
  type    = "string"

}

#The name of the SMS Receiver 1
variable "SMSReceiver1" {
  type    = "string"

}


#The Country Code of the SMS Receiver 1
variable "SMSReceiver1CC" {
  type    = "string"

}

#The number of the SMS Receiver 1
variable "SMSReceiver1Number" {
  type    = "string"

}


#The name of the SMS Receiver 2
variable "SMSReceiver2" {
  type    = "string"

}

#The Country Code of the SMS Receiver 1

variable "SMSReceiver2CC" {
  type    = "string"

}

#The number of the SMS Receiver 1

variable "SMSReceiver2Number" {
  type    = "string"

}