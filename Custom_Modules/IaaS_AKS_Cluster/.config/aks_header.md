# Module Azure Kubernetes Cluster

This module is used to provision an Azure Kubernetes Cluster and related resources

## Module description

This module deploys an Azure Kubernetes Cluster
It includes configuration for:

- The cluster,
- Azure diagnostic settings for the cluster,
- User Assign managed identity for the control plane,
- Azure monitor alerts for the cluster,
- Azure role assignment for the OMS managed identity if the addon is enabled.

## Deployment options

Diagnostic settings send logs to a storage account and a log analytic workspace. The resources are referenced through their resource ids. If not specified, the module can create a storage acocunt and a log analytics workspace. The variables `StaLogId` and `LawLogId` are set to `unspecified`. If set at module call, the values must be valid resource Ids. However, there is no variable validation at this time

The target resource group can also either be specified, by its name, or be created by the module. The default value of the variable `AKSRGName` is set to `unspecified` so that the RG is created by the module.
