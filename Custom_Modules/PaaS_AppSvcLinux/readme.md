<!-- BEGIN_TF_DOCS -->

# Module Azure Application Gateway

This module is used to provision an Azure Application Gateway and related resources

## Module description

This module deploys an Azure Application Gateway
It includes configuration for:

- Application Gateway and related object. Refer to terraform documentation for details
- Application Gateway Public IP
- Azure Diagnostic settings for Applicayion Gateway
- Azure diagnostic settings for Application Gateway Public IP
- User Assign managed identity to allow Application Gateway to get its certificate directly from a key vault
- A Keyvault Access Policy applied on the targeted key vault to allow Application Gateway to fetch its certificate

## Deployment options

Diagnostic settings send logs to a storage account and a log analytic workspace. The resources are referenced through their resource ids. If not specified, the module will create a storage acocunt and a log analytics workspace. The variables `StaLogId` and `LawLogId` are set to `unspecified` by default so that the log repositories are created by the module. If set at module call, the values must be valid resource Ids

The target resource group can also either be specified, by its name, or be created by the module. The default value of the variable `TargetRg` is set to `unspecified` so that the RG is created by the module.

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.72.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AGWSuffix"></a> [AGWSuffix](#input\_AGWSuffix) | A short string to add at the end of the app gw name | `string` | `"-1"` | no |
| <a name="input_AZList"></a> [AZList](#input\_AZList) | A list of AZ | `list(any)` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| <a name="input_AgwLogCategories"></a> [AgwLogCategories](#input\_AgwLogCategories) | A list of log categories to activate on the Application Gateway | `list(any)` | `null` | no |
| <a name="input_AgwMetricCategories"></a> [AgwMetricCategories](#input\_AgwMetricCategories) | A list of metric categories to activate on the Application Gateway | `list(any)` | `null` | no |
| <a name="input_AppGatewaySkuCapacity"></a> [AppGatewaySkuCapacity](#input\_AppGatewaySkuCapacity) | The AppGW capacity. Optional if the autoscale is enabled | `string` | `3` | no |
| <a name="input_AppGatewaySkuName"></a> [AppGatewaySkuName](#input\_AppGatewaySkuName) | The AppGW Sku Name | `string` | `"WAF_v2"` | no |
| <a name="input_AppGatewaySkuTier"></a> [AppGatewaySkuTier](#input\_AppGatewaySkuTier) | The AppGW Sku Tier | `string` | `"WAF_v2"` | no |
| <a name="input_AppGwPrivateFrontendIpAddressHostnum"></a> [AppGwPrivateFrontendIpAddressHostnum](#input\_AppGwPrivateFrontendIpAddressHostnum) | Determines the priv ip of the application gateway | `string` | `10` | no |
| <a name="input_BEHTTPSettingsRequestTimeOut"></a> [BEHTTPSettingsRequestTimeOut](#input\_BEHTTPSettingsRequestTimeOut) | The request timeout in seconds, which must be between 1 and 86400 seconds. | `string` | `31` | no |
| <a name="input_BHSCookieConfig"></a> [BHSCookieConfig](#input\_BHSCookieConfig) | Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled. | `string` | `"Disabled"` | no |
| <a name="input_BHSPort"></a> [BHSPort](#input\_BHSPort) | The port which should be used for this Backend HTTP Settings Collection. | `string` | `80` | no |
| <a name="input_BHSProtocol"></a> [BHSProtocol](#input\_BHSProtocol) | The Protocol which should be used. Possible values are Http and Https. | `string` | `"Http"` | no |
| <a name="input_CreateRg"></a> [CreateRg](#input\_CreateRg) | A bool to decide if the RG is to be created. Set to true, it forces the creation of a new RG | `bool` | `false` | no |
| <a name="input_DefaultTags"></a> [DefaultTags](#input\_DefaultTags) | Default Tags | `map(any)` | <pre>{<br>  "Company": "dfitc",<br>  "CostCenter": "lab",<br>  "Country": "fr",<br>  "Environment": "dev",<br>  "Project": "tfmodule",<br>  "ResourceOwner": "That would be me"<br>}</pre> | no |
| <a name="input_EnabledDiagSettings"></a> [EnabledDiagSettings](#input\_EnabledDiagSettings) | A bool to enable or disable the diagnostic settings | `bool` | `false` | no |
| <a name="input_FirewallPolicyId"></a> [FirewallPolicyId](#input\_FirewallPolicyId) | The Id of the Waf Policy applied on the Agw | `string` | `null` | no |
| <a name="input_FrontEndPort"></a> [FrontEndPort](#input\_FrontEndPort) | The port used for the Frontend Port. | `string` | `443` | no |
| <a name="input_FrontEndPorts"></a> [FrontEndPorts](#input\_FrontEndPorts) | A map used to feed the dynamic blocks of the gw configuration for the front end port | `map(any)` | <pre>{<br>  "FrontEndPortDefault": {<br>    "FrontEndPort": 443<br>  }<br>}</pre> | no |
| <a name="input_KVId"></a> [KVId](#input\_KVId) | The target Key Vault ID. | `string` | n/a | yes |
| <a name="input_LawLogId"></a> [LawLogId](#input\_LawLogId) | The id of the log analytics workspace containing the logs | `string` | `"unspecified"` | no |
| <a name="input_ProbeHost"></a> [ProbeHost](#input\_ProbeHost) | The Hostname used for this Probe. If the Application Gateway is configured for a single site, by default the Host name should be specified as ‘127.0.0.1’, unless otherwise configured in custom probe. Cannot be set if pick\_host\_name\_from\_backend\_http\_settings is set to true. | `string` | `"127.0.0.1"` | no |
| <a name="input_ProbeInterval"></a> [ProbeInterval](#input\_ProbeInterval) | Time interval (in seconds) between 2 consecutive probes for health probe #1. Possible values range from 1 second to a maximum of 86400 seconds. | `string` | `10` | no |
| <a name="input_ProbePath"></a> [ProbePath](#input\_ProbePath) | The probe path. URI test path for health probe #1. Must begin with a /. | `string` | `"/"` | no |
| <a name="input_ProbePort"></a> [ProbePort](#input\_ProbePort) | Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from http settings will be used. This property is valid for Standard\_v2 and WAF\_v2 only. | `string` | `80` | no |
| <a name="input_ProbeProtocol"></a> [ProbeProtocol](#input\_ProbeProtocol) | The Protocol used for this Probe. Possible values are Http and Https. | `string` | `"Http"` | no |
| <a name="input_ProbeTimeOut"></a> [ProbeTimeOut](#input\_ProbeTimeOut) | The timeout (in seconds) for health probe #1, which indicates when a probe becomes unhealthy. Possible values range from 1 second to a maximum of 86400 seconds. | `string` | `31` | no |
| <a name="input_ProbeUnhealthyThreshold"></a> [ProbeUnhealthyThreshold](#input\_ProbeUnhealthyThreshold) | Unhealthy threshold (number) for health probe #1, which indicates the amount of retries which should be attempted before a node is deemed unhealthy. Possible values are from 1 - 20 retries. | `string` | `3` | no |
| <a name="input_PubIpLogCategories"></a> [PubIpLogCategories](#input\_PubIpLogCategories) | A list of log categories to activate on the public ip | `list(any)` | `null` | no |
| <a name="input_PubIpMetricCategories"></a> [PubIpMetricCategories](#input\_PubIpMetricCategories) | A list of metric categories to activate on the public ip | `list(any)` | `null` | no |
| <a name="input_SitesConf"></a> [SitesConf](#input\_SitesConf) | A map used to feed the dynamic blocks of the gw configuration | <pre>map(object({<br><br>    HostName = string<br><br>    BePoolIps           = optional(list(string), [])<br>    BePoolInternalFqdns = optional(list(string), [])<br>    BePoolName          = optional(string, "")<br><br>    BhsName                      = optional(string, "")<br>    BhsPort                      = optional(number, 80)<br>    BhsProtocol                  = optional(string, "Http")<br>    BhsAffinityCookieName        = optional(string, null)<br>    BhsCookieBasedAffinityConfig = optional(string, "Disabled")<br>    BhsProbeName                 = optional(string, null)<br>    BhsRequestTimeOut            = optional(number, null)<br>    BhsPath                      = optional(string, null)<br>    BhsTrustedRootCert           = optional(list(string), [])<br>    BhsHostName                  = optional(string, "")<br><br>    LstName             = optional(string, "")<br>    LstProtocol         = optional(string, "Https")<br>    LstFirewallPolicyId = optional(string, null)<br><br>    SslCertName   = optional(string, null)<br>    SslKvSecretId = optional(string, null)<br><br>    ReqRuleName     = optional(string, "")<br>    ReqRulePriority = number<br><br>    EnableProbe             = optional(bool, false)<br>    ProbeName               = optional(string, "")<br>    ProbeHost               = optional(string, null)<br>    ProbeInterval           = optional(string, null)<br>    ProbeProtocol           = optional(string, null)<br>    ProbePath               = optional(string, null)<br>    ProbeTimeOut            = optional(string, null)<br>    ProbeUnhealthyThreshold = optional(string, null)<br><br><br><br><br><br><br><br><br><br><br>  }))</pre> | <pre>{<br>  "Site 1": {<br>    "HostName": "default",<br>    "ReqRulePriority": 1<br>  }<br>}</pre> | no |
| <a name="input_StaLogId"></a> [StaLogId](#input\_StaLogId) | The id of the storage account containing the logs on the subscription level | `string` | `"unspecified"` | no |
| <a name="input_TargetLocation"></a> [TargetLocation](#input\_TargetLocation) | The location of the resources to be deployed | `string` | `"eastus"` | no |
| <a name="input_TargetRG"></a> [TargetRG](#input\_TargetRG) | The Name of the RG targeted for the deployment | `string` | `"unspecified"` | no |
| <a name="input_TargetSubnetAddressPrefix"></a> [TargetSubnetAddressPrefix](#input\_TargetSubnetAddressPrefix) | The subnet prefix for the app gw | `string` | n/a | yes |
| <a name="input_TargetSubnetId"></a> [TargetSubnetId](#input\_TargetSubnetId) | The subnet Id for the app gw | `string` | n/a | yes |
| <a name="input_TrustedRootCertificates"></a> [TrustedRootCertificates](#input\_TrustedRootCertificates) | n/a | <pre>map(object({<br>    CertName       = string<br>    CertKvSecretId = optional(string, null)<br>    CertData       = optional(string, null)<br><br>  }))</pre> | n/a | yes |
| <a name="input_WafMode"></a> [WafMode](#input\_WafMode) | The waf mode, can be prevention or Detection | `string` | `"Prevention"` | no |
| <a name="input_WafRuleSetVersions"></a> [WafRuleSetVersions](#input\_WafRuleSetVersions) | The OWASP Rule set version, can be 2.9, 3.0 or 3.1 | `string` | `"3.1"` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Additional optional tags. | `map(any)` | `{}` | no |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.AGW](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_key_vault_access_policy.KeyVaultAccessPolicy01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_log_analytics_workspace.LawMonitor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_diagnostic_setting.AgwDiagSettings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.PubIpAgwDiagSettings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.AppGWPIP](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.RgAgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.kvRoleAssignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.StaMonitor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_user_assigned_identity.AppGatewayManagedId](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_monitor_diagnostic_categories.Agw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_monitor_diagnostic_categories.AgwPubIP](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_AgwDiagConfig"></a> [AgwDiagConfig](#output\_AgwDiagConfig) | The diagnostic settings configuration for the Agw |
| <a name="output_AgwDiagInfo"></a> [AgwDiagInfo](#output\_AgwDiagInfo) | the list of diagnistic settings categories available for the Agw |
| <a name="output_AgwWPubIpDiagConfig"></a> [AgwWPubIpDiagConfig](#output\_AgwWPubIpDiagConfig) | The Diagnostic settings configuration for the Agw public Ip |
| <a name="output_AppGWPubIP"></a> [AppGWPubIP](#output\_AppGWPubIP) | The Pub Ip full output |
| <a name="output_AppGWUAI"></a> [AppGWUAI](#output\_AppGWUAI) | The Agw User Assign Identity full output |
| <a name="output_AppGW_BEPool"></a> [AppGW\_BEPool](#output\_AppGW\_BEPool) | The Application Gateway backend address pools |
| <a name="output_AppGW_BEPoolId"></a> [AppGW\_BEPoolId](#output\_AppGW\_BEPoolId) | The Application Gateway backend pool ids |
| <a name="output_AppGw"></a> [AppGw](#output\_AppGw) | The full Agw module output |
| <a name="output_AppGw_Id"></a> [AppGw\_Id](#output\_AppGw\_Id) | The Application Gateway Id |
| <a name="output_PubIpDiagInfo"></a> [PubIpDiagInfo](#output\_PubIpDiagInfo) | The list of diagnostic settings categories available for the Agw Public Ip |

## How to update this documentation

In the module folder, use the following command.

```bash

terraform-docs --config ./.config/.terraform-doc.yml .

```
<!-- END_TF_DOCS -->