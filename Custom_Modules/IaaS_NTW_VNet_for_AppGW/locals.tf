

locals {

defaultsubnetoutput = {
        "address_prefix" = ""
        "address_prefixes" = [
          "",
        ]
        "delegation" = []
        "enforce_private_link_endpoint_network_policies" = false
        "enforce_private_link_service_network_policies" = false
        "id" = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/<rg_name>/providers/Microsoft.Network/virtualNetworks/<vnet_name>/subnets/<subnet_name>"
        "name" = "<subnet_name>"
        "resource_group_name" = "<rg_name>"
        "service_endpoint_policy_ids" = []
        "service_endpoints" = []
        "timeouts" = null
        "virtual_network_name" = "<vnet_name>"
    }

defaultIpConfigOutput = {
        "name" = "bst-pubip-config"
        "public_ip_address_id" = "/subscriptions/00000000-0000-0000-0000-00000000000/resourceGroups/<rg_name>/providers/Microsoft.Network/publicIPAddresses/<bst-pubip>"
        "subnet_id" = "/subscriptions/00000000-0000-0000-0000-00000000000/resourceGroups/<rg_name>/providers/Microsoft.Network/virtualNetworks/vnetpocdoc/subnets/AzureBastionSubnet"

    }

}





