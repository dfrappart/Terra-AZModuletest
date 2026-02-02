

resource "azurerm_dev_test_global_vm_shutdown_schedule" "VmShutdown" {
  virtual_machine_id = azurerm_linux_virtual_machine.VM.id
  location           = azurerm_linux_virtual_machine.VM.location
  enabled            = var.Shutdown.Enabled

  daily_recurrence_time = var.Shutdown.Time
  timezone              = var.Shutdown.TimeZone

  notification_settings {
    enabled         = var.Shutdown.Notification.Enabled
    time_in_minutes = var.Shutdown.Notification.TimeInMinutesBeforeNotification
    webhook_url     = var.Shutdown.Notification.WebhookUrl
    email           = var.Shutdown.Notification.Email
  }
}