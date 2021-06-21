# NSG Module

## Module description

This module deploys a Private DNS Zone

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| PrivateDNSDomainName | string | N/A | The name of the Private DNS Zone. Must be a valid domain name. |
| RGName | string | N/A | The region in which the resource lives. Changing this forces a new resource to be created. |
| SOARecordEmail | string | N/A | The email contact for the SOA record. |
| SOARecordExpireTime | string | null | The expire time for the SOA record. Defaults to 2419200. |
| SOARecordMinTTL | string | null | The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. Defaults to 10. |
| SOARecordRefreshTime | string | null | The refresh time for the SOA record. Defaults to 3600. |
| SOARecordRetryTime | string | null | The retry time for the SOA record. Defaults to 300. |
| SOARecordTTL | string | null | The Time To Live of the SOA Record in seconds. Defaults to 3600. |
| ResourceOwnerTag | string | That would be me | Tag describing the owner |
| CountryTag | string | fr | Tag describing the Country |
| CostCenterTag | string | tflab | Tag describing the Cost Center |
| Project | string | tfmodule | The name of the project |
| Environment | string | dev | The environment, dev, prod... |
| extra_tags | map | {} | Additional optional tags. |


### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|
| PrivateDNSZoneFull | `azurerm_private_dns_zone.PrivateDNSZone` | send all the resource information available in the output. |


## How to call the module

Use as follow:

```bash

module "NSG" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//241_PrivateDNSZone/"

    #Module variable
    PrivateDNSDomainName                  = "test.domain.ninja"
    RGName                                ="rsgdnsprivate"
    SOARecordEmail                        = "kakashi@konoha.ninja"
    


}

```

### Sample display

terraform plan should gives the following output:

```powershell



```

## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/privdnszone001.png)