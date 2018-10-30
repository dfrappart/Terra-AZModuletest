#################################################################
#This module allows the creation of an automation DSC Config node
#################################################################

#Variable declaration for Module

#The Name of the automation DSC Config
variable "AutomationScheduleName" {
  type = "string"
}

#The RG in which the automation DSC Config is attached to 
variable "RGName" {
  type = "string"
}

#The name of the associated automation account
variable "AutomationAccountName" {
  type = "string"
}

#The frequency of the schedule
variable "ScheduleFrequency" {
  type = "string"
  default = "Week"
}

#The interval of the schedule
variable "ScheduleIntervals" {
  type = "string"
  default = "1"
}

#The start time
variable "ScheduleStart" {
  type = "string"

}

#The expriracy time
variable "ScheduleExpiracy" {
  type = "string"

}

#The time zone
variable "ScheduleTimeZone" {
  type = "string"
  default = "Romance Standard Time"
}

#The week day of execution
variable "ScheduleWeekDay" {
  type = "list"
  default = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
}