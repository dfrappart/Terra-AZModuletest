
###################################################################################
############################## Agent for VMs ######################################
###################################################################################


resource "azurerm_virtual_machine_extension" "CustomScriptExtension" {

  count                      = var.CustomScriptEnabled ? 1 : 0
  name                       = "${azurerm_linux_virtual_machine.VM.name}-CustomScript"
  publisher                  = "Microsoft.Compute"
  virtual_machine_id         = azurerm_linux_virtual_machine.VM.id
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  settings = jsonencode(var.CustomScriptSettings)

  protected_settings = jsonencode(var.CustomScriptProtectedSettings)




  tags = {

  }

}

resource "azurerm_virtual_machine_extension" "EntraIdAuth" {
  count                      = var.EntraIdAuthEnabled ? 1 : 0
  name                       = "${azurerm_linux_virtual_machine.VM.name}-EntraIdAuth"
  virtual_machine_id         = azurerm_linux_virtual_machine.VM.id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForLinux"
  type_handler_version       = "2.0"
  auto_upgrade_minor_version = true



}

resource "azurerm_virtual_machine_extension" "AMA" {
  count                      = var.AMAEnabled ? 1 : 0
  name                       = "${azurerm_linux_virtual_machine.VM.name}-AMA"
  virtual_machine_id         = azurerm_linux_virtual_machine.VM.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  settings = jsonencode({
    authentication = {
      identifier-name  = var.AMAIdentifierName
      identifier-value = var.AMAAMAUaiId
    }
  })



}




