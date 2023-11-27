
module "testvnet" {
    source = ""

    RgName = "rsg-demo1"
    CustomVnet = true
    AppName = "spokedemo"
    EnableVnetDiagSettings = true
    LawLogId = var.LawMonitorId
    StaLogId = var.StaMonitorId


    Vnet = {
      Name = ""
      AddressSpace = "172.21.0.0/25"
      DnsServers = []
    }

    Subnets = [ 
      {
        Name = "Subnet1"
        AllowCustomName = false
        EnableNsg = true
        Nsg = {
          Name = "Nsg-Subnet1"
          Rules = {}
        }
      },
      {
        Name = "Subnet2"
        AllowCustomName = false
        EnableNsg = true
        Nsg = {
          Name = ""
          Rules = {}
        }
      },
      {
        Name = "Subnet3"
        AllowCustomName = false
        EnableNsg = true

        Nsg = {
          Name = ""
          Rules = {}
        }
      },
      {
        Name = "Subnet4"
        AllowCustomName = false
        EnableNsg = true

        Nsg = {
          Name = ""
          Rules = {}
        }
      }

    ]
}