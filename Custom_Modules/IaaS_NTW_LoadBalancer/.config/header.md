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

