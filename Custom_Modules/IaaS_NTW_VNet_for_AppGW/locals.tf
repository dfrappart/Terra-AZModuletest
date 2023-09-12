

locals {

  StartingDate                    = timeadd(timestamp(), "1m")
  ExpirationDate                  = timeadd(timestamp(), "8760h")
  StartDateTag                    = formatdate("YYYY-MM-DD", local.StartingDate)

  AppName                         = var.AppName == "" ? random_string.RandomAppName.result : var.AppName 
  RgName                          = var.Rg.Name == "" ? lower(format("%s-%s-%s%s","rg",var.Env,local.AppName,var.ObjectIndex)) : var.RgName
  VnetName                        = var.Vnet.Name == "" ? lower(format("%s-%s-%s%s","vnet",var.Env,local.AppName,var.ObjectIndex)) : var.Vnet.Name

  VnetPrefix                      = split("/", var.Vnet.AddressSpace)[1]
  SubnetPrefixes                  = local.VnetPrefix == "24" ? cidrsubnets(var.Vnet.AddressSpace, 2, 2, 2, 2) : (local.VnetPrefix == "25" || local.VnetPrefix == "26" ? cidrsubnets(var.Vnet.AddressSpace, 1, 1) : [var.Vnet.AddressSpace])
  Subnets = { for subnet in var.Subnets : subnet.Name => {
    Name = subnet.AllowCustomName ? subnet.Name : lower(format("%s%s-%s","subnet",index(var.Subnets,subnet)+1,local.VnetName))
    #Nsg = {
    #  Name  = Subnet.Nsg.Name
    #  Rules = merge(try(subnet.nsg.rules, {}), var.default_nsg_rules)
    #}
    } 
  }

}


output "subprefix" {
  value = local.SubnetPrefixes
}

output "subnetprefixnotsorted" {
  value = cidrsubnets(var.Vnet.AddressSpace, 2, 2, 2, 2)
}


