module "PublicLB" {
  source = "../modules/LoadBalancer"

  TargetRG = "rsg-spoke-frontend"
  LbConfig = {
        Suffix                  = "demo"
        DDosProtectionMode      = "Enabled"
        DDosProtectionPlanId    = azurerm_network_ddos_protection_plan.DdosPlan.id
  }


}