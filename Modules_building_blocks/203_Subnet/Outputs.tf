##############################################################
#This module allows the creation of a Subnet Gateway
##############################################################



#Output



output "Name" {

  value = azurerm_subnet.Subnet.name
}

output "Id" {

  value = azurerm_subnet.Subnet.id
}

output "AddressPrefix" {

  value = azurerm_subnet.Subnet.address_prefixes[0]
}

output "FullSubnet" {

  value = azurerm_subnet.Subnet
}