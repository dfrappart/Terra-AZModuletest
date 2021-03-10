# Application GW Module

## Module description

This module deploys an Azure Application Gateway
It includes configuration for:

- Application Gateway and related object. Refer to terraform documentation for details
- Application GatewayPublic IP
- Azure Diagnostic settings for Applicatyion Gateway
- Azure diagnostic settings for Application Gateway Public IP
- User Assign managed identity to allow Application Gateway to get its certificate directly from a key vault
- A Keyvault Access Policy applyed on the targeted key vault to allow Application Gateway to fetch its certificate

### Dependencies

Diagnostic settings send logs to a storage account and a log analytic workspace which **must exist prior to the deployment**.
Those repositories of logs are referenced through data sources. Names for those resources follow the names as described in naming convention.

### Module inputs

|Variable name | Variable type | Variable description | Variable default value |
|--------------|:--------------|:---------------------|:-----------------------|
| TargetRG | String | The Name of the RG targeted for the deployment | N/A |
| TargetLocation | String | The location of the resources to be deployed | N/A |
| LawSubLogId | String | The id of the log analytics workspace containing the logs | N/A |
| StaSubLogId | String | The id of the storage account containing the logs on the subscription level | N/A |
| KVId | String | The target Key Vault ID. | N/A |
| TargetSubnetId | String | The subnet Id for the app gw | N/A |
| AGWSuffix | String | A short string to add at the end of the app gw name | "-1" |
| AppGatewaySkuName | String | The AppGW Sku Name | "WAF_v2" |
| AppGatewaySkuTier | String | The AppGW Sku Name | "WAF_v2" |
| WafMode | String | The waf mode, can be prevention or Detection | "Prevention" |
| WafRuleSetVersions | String | The OWASP Rule set version, can be 2.9, 3.0 or 3.1 | "3.1" |
| AppGatewaySkuCapacity | String | The AppGW capacity. Optional if the autoscale is enabled | 3 |
| BEHTTPSettingsRequestTimeOut | String | The request timeout in seconds, which must be between 1 and 86400 seconds. | 31 |
| ProbeInterval | String | Time interval (in seconds) between 2 consecutive probes for health probe #1. Possible values range from 1 second to a maximum of 86400 seconds. | 10 |
| ProbeProtocol | String | The Protocol used for this Probe. Possible values are Http and Https. | http |
| ProbePath | String | The probe path. URI test path for health probe #1. Must begin with a /. | / |
| ProbeTimeOut | String | The timeout (in seconds) for health probe #1, which indicates when a probe becomes unhealthy. Possible values range from 1 second to a maximum of 86400 seconds. | 31 |
| ProbeUnhealthyThreshold | String | Unhealthy threshold (number) for health probe #1, which indicates the amount of retries which should be attempted before a node is deemed unhealthy. Possible values are from 1 - 20 retries. | 3 |
| ProbePort | String | Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from http settings will be used. This property is valid for Standard_v2 and WAF_v2 only. | null |
| SitesConf | map | A map used to feed the dynamic bloks of the gw configuration, Composed of maps defined with the parameters **SiteIdentifier**, **AppGWSSLCertNameSite**, **AppGwPublicCertificateSecretIdentifierSite**, **HostnameSite**. The **SiteIdentifier** is a short string to identify the site, the **AppGWSSLCertNameSite** specifies the corresponding TLS certificate, the **AppGwPublicCertificateSecretIdentifierSite** refers the secret identifiers in the keyvault in which the agw is taking the certificate, the **HostnameSite** defines the corresponding site name  | Default values are defined but the paramleters are nonetheless mandatory to use this module correctly |
| ResourceOwnerTag | String | Tag describing the owner | `That would be me` |
| CountryTag | String | Tag describing the Country | fr |
| CostCenterTag | String | Tag describing the Cost Center | tflab |
| Project | String | Tag describing the name of the project. Use in the name. Changing this may recreate objects | azure |
| Environment | String | Tag describing the environment, dev, prod... Changing this may recreate objects | dev |

### Module outputs

|Output name | Output type | Output description |
|------------|:------------|:-------------------|
| AppGW | Application Gateway output | Output for the appgw taking all the parameters |
| AppGW_Id | Application Gateway output | Output for the appgw resource id |
| AppGW_BEPool | Application Gateway output | Output for the appgw back end pool |
| AppGW_BEPoolId | Application Gateway output | Output for the appgw back end pool resourceid, useful for association with backend such as vms and vmss |
| AppGWUAI | User assigned identity output| Output for the user assigned identity taking all the parameters |
| AppGWUAIKV_AccessPolicy | Key vault access policy output | Output for the key vault access policy associated to the user assigned identity taking all the parameters |
| AppGWPubIP | Public IP output | Output for the application gateway public ip taking all the parameter |
| AppGWDiag | Diagnostic settings output | Output for the diagnostic settings of the application gateway taking all the parameter |

### Data sources

|datasource name | data source type |  description |
|------------|:------------|:-------------------|
| current | azurerm_subscription | data source for the current subscription |


## How to call the module

Use as follow:

```hcl



```

## Sample display

terraform plan should gives the following output:

```powershell



```

output should be similar to this:

```powershell



```

## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/agw01.png)

![Illustration 2](./Img/agw02.png)

![Illustration 3](./Img/agw03.png)

![Illustration 4](./Img/agw04.png)

![Illustration 5](./Img/agw05.png)
