# Module App service

This module is used to provision an Azure App service

## Module description

This module deploys an Azure App service.
It includes configuration for:

- 

## Deployment options

Diagnostic settings send logs to a storage account and a log analytic workspace. The resources are referenced through their resource ids. If not specified, the module will create a storage acocunt and a log analytics workspace. The variables `StaLogId` and `LawLogId` are set to `unspecified` by default so that the log repositories are created by the module. If set at module call, the values must be valid resource Ids

The target resource group can also either be specified, by its name, or be created by the module. The default value of the variable `TargetRg` is set to `unspecified` so that the RG is created by the module.