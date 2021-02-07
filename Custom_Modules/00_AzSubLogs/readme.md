# Basic log config Subscription module

## This module is used to create the basic log config for a subscription

This module aims to setup a subscription with muinimal log configuration.
The following is done by this module:
- Create a storage account to store logs for 365 days
- Create a log analytics worspace to store log for 30 days and get query capabilities
- Activate Activity logs on the subscription level

## How to call this module

Call this module like this:

```hcl

module "BasicLogConfig" {

  #Module Location
  source = "./Modules/02_AzSubLogs/"

  #Module variable

  ResourceOwnerTag      = var.ResourceOwnerTag
  CountryTag            = var.CountryTag
  CostCenterTag         = var.CostCenterTag
  Company               = var.Company
  Project               = var.Project
  Environment           = var.Environment
  SubId                 = data.azurerm_subscription.current.subscription_id

}



```

## Module variables


The following variables are defined in the module: 

|Variable name | Variable type | Variable description | Variable default value |
|--------------|:--------------|:---------------------|:-----------------------|
| ResourceOwnerTag | String | Tag describing the owner | N/A |
| CountryTag | String | Tag describing the Country | N/A |
| CostCenterTag | String | Tag describing the Cost Center| N/A |
| Company | String | A company name | N/A |
| Project | String | A project name | N/A |
| Environment | String | Tag describing the Country | N/A |
| RGLogLocation | String | Variable defining the region for the log resources | westeurope |
| SubLogSuffix | String | Suffix to add to the resources, by default, log" | log |
| LAWSku | String | SKu for Log analytics, PerGB2018 | PerGB2018 |
| LAWRetention | String | Retention in days for the log analytics workspace, default to 30 days | 30 |
| SubId | String | The subscription id, to confiugure the diag logs | N/A |


## Module output


The following output are defined in the module:

|Output name | Output description | Output Sensitivity |
|------------|:-------------------|:-------------------|
| RGLogName | The RG Name | False |
| RGLogLocation | The RG location| False |
| RGLogId | The RG resource Id, should be considered as sensitive when exposed in state | True |
| STALogName | The Id associated to the role definition | True |
| STALogId | The resource Id of the storage account | True |
| STALogPrimaryBlobEP | The storage account primary blob End Point | True |
| STALogPrimaryQueueEP | The storage account primary queue End Point | True |
| STALogPrimaryTableEP | The storage account primary table End Point | True |
| STALogPrimaryFileEP | The storage account primary file End Point | True |
| STALogPrimaryAccessKey | TThe storage account primary access key | True |
| STALogSecondaryAccessKey | The storage account secondary access key | True |
| STALogConnectionURI | The storage account connection URI | True |
| SubLogAnalyticsWSId | The Log Analytics workspace resource ID | True |
| SubLogAnalyticsWS_WSId | The Log Analytics workspace Workspace ID | True |
| SubLogAnalyticsWS_Retention | The Log Analytics workspace retention period in days | True |
| SubLogAnalyticsWS_PrimaryAccessKey | The Log Analytics workspace Primary Access key | True |
| SubLogAnalyticsWS_SecondaryAccessKey | The Log Analytics workspace Secondary Access key | True |
| SubLogAnalyticsWS_PortalURL | The Log Analytics workspace URI | True |




## Module local variable

To follow a naming convention for the resources, local variables are used within the module and concatene values from variables as follow: 

|Local name | Local value          | Local description  |
|-----------|:---------------------|:-------------------|
| STAPrefix | "st${lower(var.Company)}${lower(var.CountryTag)}${lower(var.Environment)}${lower(var.Project)}" | local used to build storage account name with tags and company information |
| ResourcePrefix | "${lower(var.Company)}${lower(var.CountryTag)}-${lower(var.Environment)}-${lower(var.Project)}-"| local used to build resources name with tags and company information |


## Plan sample

The plan looks like that: 

```hcl

