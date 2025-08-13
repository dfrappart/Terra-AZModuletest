module "PublicLB" {
    source = "../modules/LoadBalancer"

    TargetRG = "<rg_name>"
    LbDiagnosticSettingsEnabled = true
    PubIpDiagnosticSettingsEnabled = true
    StaLogId = azurerm_storage_account.StaMonitor.id # mandatory when diagnostics are enabled
    LawLogId = azurerm_log_analytics_workspace.LawMonitor.id # mandatory when diagnostics are enabled
    LbAlertingEnabled = true
    PubIpAlertingEnabled = true

}

