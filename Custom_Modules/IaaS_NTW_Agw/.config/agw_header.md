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