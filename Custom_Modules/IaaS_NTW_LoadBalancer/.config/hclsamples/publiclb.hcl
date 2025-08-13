module "PublicLB" {
    source = "../modules/LoadBalancer"

    TargetRG = "<rg_name>"

    LbConfig = {
    Suffix             = "demo"

  }
 

}

