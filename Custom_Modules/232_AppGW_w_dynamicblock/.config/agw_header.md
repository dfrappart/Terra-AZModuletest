# Module Azure Application Gateway

This module is used to provision an Azure Application Gateway and related resources

## Module description

This module deploys an Azure Application Gateway
It includes configuration for:

- Application Gateway and related object. Refer to terraform documentation for details
- Application GatewayPublic IP
- Azure Diagnostic settings for Applicatyion Gateway
- Azure diagnostic settings for Application Gateway Public IP
- User Assign managed identity to allow Application Gateway to get its certificate directly from a key vault
- A Keyvault Access Policy applyed on the targeted key vault to allow Application Gateway to fetch its certificate

## Dependencies

Diagnostic settings send logs to a storage account and a log analytic workspace which **must exist prior to the deployment**.
Those repositories of logs are referenced through data sources. Names for those resources follow the names as described in naming convention.