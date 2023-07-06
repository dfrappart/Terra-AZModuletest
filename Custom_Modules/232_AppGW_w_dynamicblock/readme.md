<!-- BEGIN_TF_DOCS -->

# Module Azure Application Gateway

This module is used to provision an Azure Application Gateway and related resources

## Sample

The module in its current forms requires at least one site to be defined, with a certificate referenced from a Key Vault.

```hcl

######################################################################
# Creating an Application Gateway

locals {

  SitesConf = {
    "Site 1" = {
      SiteIdentifier                                = data.azurerm_key_vault_certificate.akscert.name 
      AppGWSSLCertNameSite                          = data.azurerm_key_vault_certificate.akscert.name 
      AppGwPublicCertificateSecretIdentifierSite    = data.azurerm_key_vault_secret.akscertsecret.id
      HostnameSite                                  = "aks.teknews.cloud"
      RoutingRulePriority                           = 1
    }
  }
}


module "AGW" {

  for_each = var.TrainingConfig
  source                                        = "../../Terra-AZModuletest/Custom_Modules/232_AppGW_w_dynamicblock"

  TargetRG                                      = azurerm_resource_group.RG[each.key].name
  TargetLocation                                = azurerm_resource_group.RG[each.key].location
  LawSubLogId                                   = data.azurerm_log_analytics_workspace.monitorlaw.id
  STASubLogId                                   = data.azurerm_storage_account.STALog.id
  TargetSubnetId                                = azurerm_subnet.subnetagic[each.key].id
  KVId                                          = data.azurerm_key_vault.SharedKv.id
  SitesConf                                     = local.SitesConf
  AGWSuffix                                     = "agw${each.key}"
  TargetSubnetAddressPrefix                     = azurerm_subnet.subnetagic[each.key].address_prefixes[0]



}

```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.50.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.50.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AGWSuffix"></a> [AGWSuffix](#input\_AGWSuffix) | A short string to add at the end of the app gw name | `string` | `"-1"` | no |
| <a name="input_AZList"></a> [AZList](#input\_AZList) | A list of AZ | `list` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| <a name="input_AppGatewaySkuCapacity"></a> [AppGatewaySkuCapacity](#input\_AppGatewaySkuCapacity) | The AppGW capacity. Optional if the autoscale is enabled | `string` | `3` | no |
| <a name="input_AppGatewaySkuName"></a> [AppGatewaySkuName](#input\_AppGatewaySkuName) | The AppGW Sku Name | `string` | `"WAF_v2"` | no |
| <a name="input_AppGatewaySkuTier"></a> [AppGatewaySkuTier](#input\_AppGatewaySkuTier) | The AppGW Sku Tier | `string` | `"WAF_v2"` | no |
| <a name="input_AppGwPrivateFrontendIpAddressHostnum"></a> [AppGwPrivateFrontendIpAddressHostnum](#input\_AppGwPrivateFrontendIpAddressHostnum) | Determines the priv ip of the application gateway | `string` | `10` | no |
| <a name="input_BEHTTPSettingsRequestTimeOut"></a> [BEHTTPSettingsRequestTimeOut](#input\_BEHTTPSettingsRequestTimeOut) | The request timeout in seconds, which must be between 1 and 86400 seconds. | `string` | `31` | no |
| <a name="input_BHSCookieConfig"></a> [BHSCookieConfig](#input\_BHSCookieConfig) | Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled. | `string` | `"Disabled"` | no |
| <a name="input_BHSPort"></a> [BHSPort](#input\_BHSPort) | The port which should be used for this Backend HTTP Settings Collection. | `string` | `80` | no |
| <a name="input_BHSProtocol"></a> [BHSProtocol](#input\_BHSProtocol) | The Protocol which should be used. Possible values are Http and Https. | `string` | `"Http"` | no |
| <a name="input_DefaultTags"></a> [DefaultTags](#input\_DefaultTags) | Default Tags | `map` | <pre>{<br>  "Company": "dfitc",<br>  "CostCenter": "lab",<br>  "Country": "fr",<br>  "Environment": "dev",<br>  "Project": "tfmodule",<br>  "ResourceOwner": "That would be me"<br>}</pre> | no |
| <a name="input_FrontEndPort"></a> [FrontEndPort](#input\_FrontEndPort) | The port used for the Frontend Port. | `string` | `443` | no |
| <a name="input_FrontEndPorts"></a> [FrontEndPorts](#input\_FrontEndPorts) | A map used to feed the dynamic blocks of the gw configuration for the front end port | `map` | <pre>{<br>  "FrontEndPortDefault": {<br>    "FrontEndPort": 443<br>  }<br>}</pre> | no |
| <a name="input_KVId"></a> [KVId](#input\_KVId) | The target Key Vault ID. | `string` | n/a | yes |
| <a name="input_LawSubLogId"></a> [LawSubLogId](#input\_LawSubLogId) | The id of the log analytics workspace containing the logs | `string` | n/a | yes |
| <a name="input_ProbeHost"></a> [ProbeHost](#input\_ProbeHost) | The Hostname used for this Probe. If the Application Gateway is configured for a single site, by default the Host name should be specified as ‘127.0.0.1’, unless otherwise configured in custom probe. Cannot be set if pick\_host\_name\_from\_backend\_http\_settings is set to true. | `string` | `"127.0.0.1"` | no |
| <a name="input_ProbeInterval"></a> [ProbeInterval](#input\_ProbeInterval) | Time interval (in seconds) between 2 consecutive probes for health probe #1. Possible values range from 1 second to a maximum of 86400 seconds. | `string` | `10` | no |
| <a name="input_ProbePath"></a> [ProbePath](#input\_ProbePath) | The probe path. URI test path for health probe #1. Must begin with a /. | `string` | `"/"` | no |
| <a name="input_ProbePort"></a> [ProbePort](#input\_ProbePort) | Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from http settings will be used. This property is valid for Standard\_v2 and WAF\_v2 only. | `string` | `80` | no |
| <a name="input_ProbeProtocol"></a> [ProbeProtocol](#input\_ProbeProtocol) | The Protocol used for this Probe. Possible values are Http and Https. | `string` | `"Http"` | no |
| <a name="input_ProbeTimeOut"></a> [ProbeTimeOut](#input\_ProbeTimeOut) | The timeout (in seconds) for health probe #1, which indicates when a probe becomes unhealthy. Possible values range from 1 second to a maximum of 86400 seconds. | `string` | `31` | no |
| <a name="input_ProbeUnhealthyThreshold"></a> [ProbeUnhealthyThreshold](#input\_ProbeUnhealthyThreshold) | Unhealthy threshold (number) for health probe #1, which indicates the amount of retries which should be attempted before a node is deemed unhealthy. Possible values are from 1 - 20 retries. | `string` | `3` | no |
| <a name="input_STASubLogId"></a> [STASubLogId](#input\_STASubLogId) | The id of the storage account containing the logs on the subscription level | `string` | n/a | yes |
| <a name="input_SitesConf"></a> [SitesConf](#input\_SitesConf) | A map used to feed the dynamic blocks of the gw configuration | <pre>map(object({<br>    SiteIdentifier = string<br>    AppGWSSLCertNameSite = string<br>    AppGwPublicCertificateSecretIdentifierSite = string<br>    HostnameSite = string<br>    RoutingRulePriority = number<br>  }))</pre> | <pre>{<br>  "Site 1": {<br>    "AppGWSSLCertNameSite": "default",<br>    "AppGwPublicCertificateSecretIdentifierSite": "default",<br>    "HostnameSite": "default",<br>    "RoutingRulePriority": 1,<br>    "SiteIdentifier": "default"<br>  }<br>}</pre> | no |
| <a name="input_TargetLocation"></a> [TargetLocation](#input\_TargetLocation) | The location of the resources to be deployed | `string` | n/a | yes |
| <a name="input_TargetRG"></a> [TargetRG](#input\_TargetRG) | The Name of the RG targeted for the deployment | `string` | n/a | yes |
| <a name="input_TargetSubnetAddressPrefix"></a> [TargetSubnetAddressPrefix](#input\_TargetSubnetAddressPrefix) | The subnet prefix for the app gw | `string` | n/a | yes |
| <a name="input_TargetSubnetId"></a> [TargetSubnetId](#input\_TargetSubnetId) | The subnet Id for the app gw | `string` | n/a | yes |
| <a name="input_WafMode"></a> [WafMode](#input\_WafMode) | The waf mode, can be prevention or Detection | `string` | `"Prevention"` | no |
| <a name="input_WafRuleSetVersions"></a> [WafRuleSetVersions](#input\_WafRuleSetVersions) | The OWASP Rule set version, can be 2.9, 3.0 or 3.1 | `string` | `"3.1"` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Additional optional tags. | `map` | `{}` | no |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.AGW](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_key_vault_access_policy.KeyVaultAccessPolicy01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_monitor_diagnostic_setting.AppGWDiag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.AppGWPIPDiag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.AppGWPIP](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_user_assigned_identity.AppGatewayManagedId](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_AppGW"></a> [AppGW](#output\_AppGW) | n/a |
| <a name="output_AppGWDiag"></a> [AppGWDiag](#output\_AppGWDiag) | n/a |
| <a name="output_AppGWPubIP"></a> [AppGWPubIP](#output\_AppGWPubIP) | n/a |
| <a name="output_AppGWPubIPDiag"></a> [AppGWPubIPDiag](#output\_AppGWPubIPDiag) | n/a |
| <a name="output_AppGWUAI"></a> [AppGWUAI](#output\_AppGWUAI) | n/a |
| <a name="output_AppGWUAIKV_AccessPolicy"></a> [AppGWUAIKV\_AccessPolicy](#output\_AppGWUAIKV\_AccessPolicy) | n/a |
| <a name="output_AppGW_BEPool"></a> [AppGW\_BEPool](#output\_AppGW\_BEPool) | n/a |
| <a name="output_AppGW_BEPoolId"></a> [AppGW\_BEPoolId](#output\_AppGW\_BEPoolId) | n/a |
| <a name="output_AppGW_Id"></a> [AppGW\_Id](#output\_AppGW\_Id) | n/a |

## How to update this documentation

In the module folder, use the following command.

```bash

terraform-docs --config ./.config/.terraform-doc.yml .

```
<!-- END_TF_DOCS -->