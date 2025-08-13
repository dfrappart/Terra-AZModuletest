<!-- BEGIN_TF_DOCS -->

# Module Load Balancer

This module is used to provision an Azure Azure Load Balancer
## Module description

This module deploys an Azure App service.
It includes configuration for:

- A load balancer
- Optionaly, a puiblic IP if the Load Balancer to be created is public
- Optionaly, diagnostics settings for both the load balancer and the public IP
- Optionaly, alerts rules for both the load balancer and the public IP

## Deployment options

It is possible to deploy a load balancer of type public or internal with the variable `LbConfig.IsLbPublic`
When set to true, it is required to set `LbConfig.InternalLbSubnetId`
When the load balancer is internal, it is also possible to select the `gateway` sku.

Monitoring can be configured optionnaly with

- `PubIpAlertingEnabled` which enables alerting for the public IP
- `LbAlertingEnabled` which enables alerting for the load balancer
- `PubIpDiagnosticSettingsEnabled` which enable diagnosting settings for the load balancer
- `LbDiagnosticSettingsEnabled` which enables diagnostic settings for the load balancer

Additionaly, metrics in diagnostic settings are not enabled by default. The following variables allow to set this parameter:

- `LbMetricsEnabled` is used to enable/disable metrics for the load balancer.
- `PubIpMetricsEnabled` is used to enable/disable metrics for the load balancer.

## Sample

Configuration to create a public load balancer.

 ```hcl

module "PublicLB" {
    source = "../modules/LoadBalancer"

    TargetRG = "<rg_name>"

    LbConfig = {
    Suffix             = "demo"

  }
 

}


 ```

Configuration to create an internal load balancer.

 ```hcl

module "InternalLB" {
    source = "../modules/LoadBalancer"

    TargetRG = "<rg_name>"
    LbConfig = {
        IsLbPublic              = false
        InternalLbSubnetId      = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/<rg_name>/providers/Microsoft.Network/virtualNetworks/<vnet_name>/subnets/<subnet_name>"
        Suffix                  = "internal"
    }
}

 ```

Configuration to create an internal gateway load balancer.

 ```hcl

module "GatewayLb" {
    source = "../modules/LoadBalancer"

    TargetRG = "<rg_name>"
    LbConfig = {
        Suffix                  = "gateway"
        Sku                     = "Gateway"
        IsLbPublic              = false
        InternalLbSubnetId      = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/<rg_name>/providers/Microsoft.Network/virtualNetworks/<vnet_name>/subnets/<subnet_name>"

    }

    depends_on = [ module.vnet ]
}

 `

Configuration to create a public load balancer with diagnostics and alerting enabled.

 ```hcl

module "PublicLB" {
    source = "../modules/LoadBalancer"

    TargetRG = "<rg_name>"
    LbDiagnosticSettingsEnabled = true
    PubIpDiagnosticSettingsEnabled = true
    StaLogId = azurerm_storage_account.StaMonitor.id # mandatory when diagnostics are enabled
    LawLogId = azurerm_log_analytics_workspace.LawMonitor.id # mandatory when diagnostics are enabled
    LbAlertingEnabled = true
    PubIpAlertingEnabled = true

}


 ```

Configuration to create a public load balancer Ddos protection.

 ```hcl

module "PublicLB" {
  source = "../modules/LoadBalancer"

  TargetRG = "rsg-spoke-frontend"
  LbConfig = {
        Suffix                  = "demo"
        DDosProtectionMode      = "Enabled"
        DDosProtectionPlanId    = azurerm_network_ddos_protection_plan.DdosPlan.id
  }


}

 ```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >=2.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ACGIds"></a> [ACGIds](#input\_ACGIds) | A list of Action Groups to send the alert to | `list(string)` | `[]` | no |
| <a name="input_EnableLocalLogSink"></a> [EnableLocalLogSink](#input\_EnableLocalLogSink) | A bool to enable or disable the creation of local log sinks for the logs and metrics | `bool` | `false` | no |
| <a name="input_ExtraTags"></a> [ExtraTags](#input\_ExtraTags) | n/a | `map(string)` | `{}` | no |
| <a name="input_KVId"></a> [KVId](#input\_KVId) | The target Key Vault ID. | `string` | `null` | no |
| <a name="input_LawLogId"></a> [LawLogId](#input\_LawLogId) | The id of the log analytics workspace containing the logs | `string` | `"unspecified"` | no |
| <a name="input_LbAlertingEnabled"></a> [LbAlertingEnabled](#input\_LbAlertingEnabled) | A bool to enable/disable Azure alerts | `bool` | `false` | no |
| <a name="input_LbAlerts"></a> [LbAlerts](#input\_LbAlerts) | A map of object to define alerts on the Load Balancer | <pre>map(object({<br/>    AlertName         = string<br/>    AlertDescription  = string<br/>    AlertSeverity     = optional(number, 3)<br/>    MetricNameSpace   = optional(string, "Microsoft.Network/loadBalancers")<br/>    MetricName        = string<br/>    MetricAggregation = string<br/>    MetricOperator    = string<br/>    MetricThreshold   = number<br/>    DimensionEnabled  = optional(bool, false)<br/>    DimensionName     = optional(string, null)<br/>    DimensionOperator = optional(string, null)<br/>    DimensionValue    = optional(list(string), [])<br/>    AlertFrequency    = optional(string, "PT5M")<br/>    AlertWindow       = optional(string, "PT5M")<br/>  }))</pre> | <pre>{<br/>  "DipAvailability": {<br/>    "AlertDescription": "DipAvailability",<br/>    "AlertFrequency": "PT1M",<br/>    "AlertName": "DipAvailability",<br/>    "AlertSeverity": 0,<br/>    "MetricAggregation": "Average",<br/>    "MetricName": "DipAvailability",<br/>    "MetricOperator": "LessThan",<br/>    "MetricThreshold": 90<br/>  },<br/>  "UsedSNATPorts": {<br/>    "AlertDescription": "UsedSNATPorts",<br/>    "AlertFrequency": "PT1M",<br/>    "AlertName": "UsedSNATPorts",<br/>    "AlertSeverity": 1,<br/>    "MetricAggregation": "Average",<br/>    "MetricName": "UsedSNATPorts",<br/>    "MetricOperator": "GreaterThan",<br/>    "MetricThreshold": 900<br/>  },<br/>  "VipAvailability": {<br/>    "AlertDescription": "VipAvailability",<br/>    "AlertFrequency": "PT1M",<br/>    "AlertName": "VipAvailability",<br/>    "AlertSeverity": 0,<br/>    "MetricAggregation": "Average",<br/>    "MetricName": "VipAvailability",<br/>    "MetricOperator": "LessThan",<br/>    "MetricThreshold": 90<br/>  }<br/>}</pre> | no |
| <a name="input_LbConfig"></a> [LbConfig](#input\_LbConfig) | An object to describe the Load Balancer | <pre>object({<br/>    Suffix                     = string<br/>    Location                   = optional(string, "francecentral")<br/>    Tags                       = optional(map(string), {})<br/>    Index                      = optional(number, 1)<br/>    IsLbPublic                 = optional(bool, true)<br/>    InternalLbSubnetId         = optional(string, null)<br/>    Sku                        = optional(string, "Standard")<br/>    SkuTier                    = optional(string, "Regional")<br/>    PrivateIpAddressAllocation = optional(string, "Dynamic")<br/>    PrivateIpAddress           = optional(string, null)<br/>    Zones                      = optional(list(string), ["1", "2", "3"])<br/>    PubIpSkuTier               = optional(string, "Regional")<br/>    DDosProtectionMode         = optional(string, "VirtualNetworkInherited")<br/>    DDosProtectionPlanId       = optional(string, null)<br/><br/><br/>  })</pre> | <pre>{<br/>  "Suffix": "demo"<br/>}</pre> | no |
| <a name="input_LbDiagnosticSettingsEnabled"></a> [LbDiagnosticSettingsEnabled](#input\_LbDiagnosticSettingsEnabled) | A bool to enable/disable Diagnostic settings | `bool` | `false` | no |
| <a name="input_LbLogCategories"></a> [LbLogCategories](#input\_LbLogCategories) | A list of log categories to activate on the Load Balancer. If set to null, it will use a data source to enable all categories | `list(string)` | <pre>[<br/>  "LoadBalancerHealthEvent"<br/>]</pre> | no |
| <a name="input_LbMetricCategories"></a> [LbMetricCategories](#input\_LbMetricCategories) | A list of metric categories to activate on the Load balancer. If set to null, it will use a data source to enable all categories | `list(string)` | <pre>[<br/>  "AllMetrics"<br/>]</pre> | no |
| <a name="input_LbMetricsEnabled"></a> [LbMetricsEnabled](#input\_LbMetricsEnabled) | A bool to enable/disable Diagnostic settings metrics on the Load Balancer | `bool` | `false` | no |
| <a name="input_MandatoryTags"></a> [MandatoryTags](#input\_MandatoryTags) | n/a | <pre>object({<br/>    data_classification  = optional(string, null)<br/>    operation_commitment = optional(string, null)<br/>    usage                = optional(string, null)<br/>    start_time           = optional(string, null)<br/>    stop_time            = optional(string, null)<br/><br/>  })</pre> | `{}` | no |
| <a name="input_OptionalTags"></a> [OptionalTags](#input\_OptionalTags) | n/a | <pre>object({<br/>    owner      = optional(string, "N/A")<br/>    start_date = optional(string, "N/A")<br/><br/>  })</pre> | `{}` | no |
| <a name="input_PubIpAlertingEnabled"></a> [PubIpAlertingEnabled](#input\_PubIpAlertingEnabled) | A bool to enable/disable Azure alerts | `bool` | `false` | no |
| <a name="input_PubIpAlerts"></a> [PubIpAlerts](#input\_PubIpAlerts) | A map of object to define alerts on the Public IP | <pre>map(object({<br/>    AlertName         = string<br/>    AlertDescription  = string<br/>    AlertSeverity     = optional(number, 3)<br/>    MetricNameSpace   = optional(string, "Microsoft.Network/publicIPAddresses")<br/>    MetricName        = string<br/>    MetricAggregation = string<br/>    MetricOperator    = string<br/>    MetricThreshold   = number<br/>    DimensionEnabled  = optional(bool, false)<br/>    DimensionName     = optional(string, null)<br/>    DimensionOperator = optional(string, null)<br/>    DimensionValue    = optional(list(string), [])<br/>    AlertFrequency    = optional(string, "PT5M")<br/>    AlertWindow       = optional(string, "PT5M")<br/>  }))</pre> | <pre>{<br/>  "BytesInDDoS": {<br/>    "AlertDescription": "BytesInDDoS",<br/>    "AlertName": "BytesInDDoS",<br/>    "AlertSeverity": 4,<br/>    "MetricAggregation": "Maximum",<br/>    "MetricName": "BytesInDDoS",<br/>    "MetricOperator": "GreaterThan",<br/>    "MetricThreshold": 80000000<br/>  },<br/>  "IfUnderDDoSAttack": {<br/>    "AlertDescription": "IfUnderDDoSAttack",<br/>    "AlertName": "IfUnderDDoSAttack",<br/>    "AlertSeverity": 1,<br/>    "MetricAggregation": "Maximum",<br/>    "MetricName": "IfUnderDDoSAttack",<br/>    "MetricOperator": "GreaterThan",<br/>    "MetricThreshold": 0<br/>  },<br/>  "PacketsInDDoS": {<br/>    "AlertDescription": "PacketsInDDoS",<br/>    "AlertName": "PacketsInDDoS",<br/>    "AlertSeverity": 4,<br/>    "MetricAggregation": "Maximum",<br/>    "MetricName": "PacketsInDDoS",<br/>    "MetricOperator": "GreaterThanOrEqual",<br/>    "MetricThreshold": 40000<br/>  },<br/>  "TCPBytesInDDoS": {<br/>    "AlertDescription": "TCPBytesInDDoS",<br/>    "AlertFrequency": "PT1M",<br/>    "AlertName": "TCPBytesInDDoS",<br/>    "AlertSeverity": 3,<br/>    "AlertWindow": "PT1H",<br/>    "MetricAggregation": "Maximum",<br/>    "MetricName": "TCPBytesInDDoS",<br/>    "MetricOperator": "GreaterThan",<br/>    "MetricThreshold": 40000<br/>  },<br/>  "TCPPacketsInDDoS": {<br/>    "AlertDescription": "TCPPacketsInDDoS",<br/>    "AlertFrequency": "PT1M",<br/>    "AlertName": "TCPPacketsInDDoS",<br/>    "AlertSeverity": 3,<br/>    "AlertWindow": "PT1H",<br/>    "MetricAggregation": "Maximum",<br/>    "MetricName": "TCPPacketsInDDoS",<br/>    "MetricOperator": "GreaterThanOrEqual",<br/>    "MetricThreshold": 40000<br/>  },<br/>  "UDPBytesInDDoS": {<br/>    "AlertDescription": "UDPBytesInDDoS",<br/>    "AlertFrequency": "PT1M",<br/>    "AlertName": "UDPBytesInDDoS",<br/>    "AlertSeverity": 3,<br/>    "AlertWindow": "PT1H",<br/>    "MetricAggregation": "Maximum",<br/>    "MetricName": "UDPBytesInDDoS",<br/>    "MetricOperator": "GreaterThanOrEqual",<br/>    "MetricThreshold": 40000<br/>  },<br/>  "UDPPacketsInDDoS": {<br/>    "AlertDescription": "UDPPacketsInDDoS",<br/>    "AlertFrequency": "PT1M",<br/>    "AlertName": "UDPPacketsInDDoS",<br/>    "AlertSeverity": 3,<br/>    "AlertWindow": "PT1H",<br/>    "MetricAggregation": "Maximum",<br/>    "MetricName": "UDPPacketsInDDoS",<br/>    "MetricOperator": "GreaterThanOrEqual",<br/>    "MetricThreshold": 40000<br/>  },<br/>  "VipAvailability": {<br/>    "AlertDescription": "VipAvailability",<br/>    "AlertFrequency": "PT1M",<br/>    "AlertName": "VipAvailability",<br/>    "AlertSeverity": 3,<br/>    "MetricAggregation": "Average",<br/>    "MetricName": "VipAvailability",<br/>    "MetricOperator": "LessThan",<br/>    "MetricThreshold": 40000<br/>  }<br/>}</pre> | no |
| <a name="input_PubIpDiagnosticSettingsEnabled"></a> [PubIpDiagnosticSettingsEnabled](#input\_PubIpDiagnosticSettingsEnabled) | A bool to enable/disable Diagnostic settings | `bool` | `false` | no |
| <a name="input_PubIpLogCategories"></a> [PubIpLogCategories](#input\_PubIpLogCategories) | A list of log categories to activate on the PubIp Cluster. If set to null, it will use a data source to enable all categories | `list(string)` | <pre>[<br/>  "DDoSMitigationFlowLogs",<br/>  "DDoSMitigationReports",<br/>  "DDoSProtectionNotifications"<br/>]</pre> | no |
| <a name="input_PubIpMetricCategories"></a> [PubIpMetricCategories](#input\_PubIpMetricCategories) | A list of metric categories to activate on the PubIp Cluster. If set to null, it will use a data source to enable all categories | `list(string)` | <pre>[<br/>  "AllMetrics"<br/>]</pre> | no |
| <a name="input_PubIpMetricsEnabled"></a> [PubIpMetricsEnabled](#input\_PubIpMetricsEnabled) | A bool to enable/disable Diagnostic settings metrics on the Public IP | `bool` | `false` | no |
| <a name="input_RgSuffix"></a> [RgSuffix](#input\_RgSuffix) | The suffix to be added to the RG name | `string` | `"Lb"` | no |
| <a name="input_StaLogId"></a> [StaLogId](#input\_StaLogId) | The id of the storage account containing the logs on the subscription level | `string` | `"unspecified"` | no |
| <a name="input_TargetLocation"></a> [TargetLocation](#input\_TargetLocation) | The location of the resources to be deployed | `string` | `"francecentral"` | no |
| <a name="input_TargetRG"></a> [TargetRG](#input\_TargetRG) | The Name of the RG targeted for the deployment | `string` | `"unspecified"` | no |

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.Lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_monitor_diagnostic_setting.LbDiagSettings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.PubIpDiagSettings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_metric_alert.LbAlerts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.PubIpAlerts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_public_ip.LbPubIp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.Rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_monitor_diagnostic_categories.Lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_monitor_diagnostic_categories.PubIps](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Lb"></a> [Lb](#output\_Lb) | Exported attributes of the Load Balancer |
| <a name="output_LbDiagCategories"></a> [LbDiagCategories](#output\_LbDiagCategories) | Exported attributes of the Load Balancer Diagnostic Categories |
| <a name="output_PubIpDiagCategories"></a> [PubIpDiagCategories](#output\_PubIpDiagCategories) | Exported attributes of the Public IP Diagnostic Categories |
| <a name="output_PublicLB"></a> [PublicLB](#output\_PublicLB) | Exported attributes of the Public Ip |

## How to update this documentation

In the module folder, use the following command.

```bash

terraform-docs --config ./.config/.terraform-doc.yml .

```
<!-- END_TF_DOCS -->