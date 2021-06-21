##############################################################
#This module allows the creation of a Netsork Security Group
##############################################################


#Output for the NSG module

output "PrivateDNSZoneFull" {
  value                               = azurerm_private_dns_zone.PrivateDNSZone
  sensitive                           = true 
}

