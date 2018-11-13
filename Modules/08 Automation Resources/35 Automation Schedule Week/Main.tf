##############################################################
#This module allows the creation of Automation schedule 
##############################################################


# Automation Credentials Creation

resource "azurerm_automation_schedule" "TerraAutomationSchedule" {
  name                          = "${var.AutomationScheduleName}"
  resource_group_name           = "${var.RGName}"
  automation_account_name       = "${var.AutomationAccountName}"
  frequency                     = "${var.ScheduleFrequency}"
  interval                      = "${var.ScheduleIntervals}"
  start_time                    = "${var.ScheduleStart}"
  expiry_time                   = "${var.ScheduleExpiracy}"
  time_zone                     = "${var.ScheduleTimeZone}"
  week_day                      = "${var.ScheduleWeekDay}"

}


