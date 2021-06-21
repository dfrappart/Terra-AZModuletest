##############################################################
#This module allows the creation of a Netsork Security Group
##############################################################



#Creation of the private DNS Zone

resource "azurerm_private_dns_zone" "PrivateDNSZone" {
  name                                  = var.PrivateDNSDomainName
  resource_group_name                   = var.RGName

  #soa_record {
  #  email                               = var.SOARecordEmail
  #  expire_time                         = var.SOARecordExpireTime
  #  minimum_ttl                         = var.SOARecordMinTTL
  #  refresh_time                        = var.SOARecordRefreshTime
  #  retry_time                          = var.SOARecordRetryTime
  #  ttl                                 = var.SOARecordTTL
#
  #}

  tags                                  = merge(local.DefaultTags, var.extra_tags)
}