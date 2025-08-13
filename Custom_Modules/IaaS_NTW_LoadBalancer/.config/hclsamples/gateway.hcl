module "GatewayLb" {
    source = "../modules/LoadBalancer"

    TargetRG = "<rg_name>"
    LbConfig = {
        Suffix = "gateway"
        Sku = "Gateway"
        IsLbPublic = false
        InternalLbSubnetId = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/<rg_name>/providers/Microsoft.Network/virtualNetworks/<vnet_name>/subnets/<subnet_name>"

    }

    depends_on = [ module.vnet ]
}