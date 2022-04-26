######################################################
# Globals
variable "RgName" {
  type                                        = string
  description                                 = "Resource Group name provided as a string. chaning this input will recreate everything"
}

variable "Location" {
  type                                        = string
  description                                 = "Azure region."
  default                                     = "westeurope"
}

variable "PSQLSuffix" {
  type                                        = string
  description                                 = "a suffix to add to the composed name, changing this change the name and thus recreate the resource"
  default                                     = "1"
}

######################################################
# Diagnostic settings variables

variable "LawLogId" {
  type                                        = string
  description                                 = "The Id of the Log Analytics workspace used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0"
  default                                     = "unspecified"
}

variable "STALogId" {
  type                                        = string
  description                                 = "The Id of the storage account used as log sink. If not specified, a conditional set the count of the diagnostic settings to 0"
  default                                     = "unspecified"
}

variable "LogCategory" {
  type                                        = map(object({
                                                  LogCatName                  = string
                                                  IsLogCatEnabledForLAW       = bool
                                                  IsLogCatEnabledForSTA       = bool
                                                  IsRetentionEnabled          = bool
                                                  RetentionDaysValue          = number
  }))

  description                               = "A map to feed the log categories of the diagnostic settings"
  
  default                                   = {

                                          "Category1" = {
                                            LogCatName                        = "PostgreSQLLogs"
                                            IsLogCatEnabledForLAW             = true
                                            IsLogCatEnabledForSTA             = true
                                            IsRetentionEnabled                = true
                                            RetentionDaysValue                = 365
    }

  }
}

variable "MetricCategory" {
  type                                        = map(object({
                                                  MetricCatName               = string
                                                  IsMetricCatEnabledForLAW    = bool
                                                  IsMetricCatEnabledForSTA    = bool
                                                  IsRetentionEnabled          = bool
                                                  RetentionDaysValue          = number
  }))

  description                               = "A map to feed the log categories of the diagnostic settings"
  
  default                                   = {

                                          "Category1" = {
                                            MetricCatName                     = "AllMetrics"
                                            IsMetricCatEnabledForLAW          = false
                                            IsMetricCatEnabledForSTA          = true
                                            IsRetentionEnabled                = true
                                            RetentionDaysValue                = 365
    }


  }
}

######################################################
####################  PostgreSQL  ####################
######################################################

# PostreSQL server

variable "PostgreLogin" {
  type                                        = string
  description                                 = "Administrator login for the PostgreSQL server."
  default                                     = "sqladmin"
}

variable "PostgrePwd" {
  type                                        = string
  description                                 = "Password associated with the administrator_login for the PostgreSQL server."
}

variable "PostgreRetentionDays" {
  type                                        = string
  description                                 = "Backup retention days for the server. Supported values are between 7 and 35 days."
  default                                     = 7
}

variable "PostgreGeoRedundantBackup" {
  type                                        = bool
  description                                 = "Choice whether enabling Geo-redundant server backups. This is not support for the Basic tier. Possible values are true or false."
  default                                     = false
}

variable "PostgreCreateMode" {
  type                                        = string
  description                                 = "The creation mode. Can be used to restore or replicate existing servers. Possible values are Default, Replica, GeoRestore, and PointInTimeRestore. Defaults to Default."
  default                                     = "Default"
}

variable "PostgreCreationSrcSrvId" {
  type                                        = string
  description                                 = "For creation modes other then default the source server ID to use."
  default                                     = null
}

variable "PostgreRestorePIT" {
  type                                        = string
  description                                 = "When create_mode is PointInTimeRestore the point in time to restore from creation_source_server_id. "
  default                                     = null
}

variable "PSQLSubnetId" {
  type                                        = string
  description                                 = "The ID of the virtual network subnet to create the PostgreSQL Flexible Server. The provided subnet should not have any other resource deployed in it and this subnet will be delegated to the PostgreSQL Flexible Server, if not already delegated. Changing this forces a new PostgreSQL Flexible Server to be created."
  default                                     = "unspecified"
}

variable "PSQLPrivateDNSZoneId" {
  type                                        = string
  description                                 = " The ID of the private dns zone to create the PostgreSQL Flexible Server. Changing this forces a new PostgreSQL Flexible Server to be created."
  default                                     = "unspecified"
}

variable "HAMode" {
  type                                        = string
  description                                 = "The high availability mode for the PostgreSQL Flexible Server. The only possible value is ZoneRedundant."
  default                                     = "ZoneRedundant"
}

variable "HAStandbyAZ" {
  type                                        = string
  description                                 = " The ID of the private dns zone to create the PostgreSQL Flexible Server. Changing this forces a new PostgreSQL Flexible Server to be created."
  default                                     = null
}

variable "PostgreZone" {
  type                                        = string
  description                                 = "Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located."
  default                                     = null
}

variable "PostgreSkuName" {
  type                                        = string
  description                                 = "The SKU Name for the PostgreSQL Flexible Server. The name of the SKU, follows the tier + name pattern (e.g. B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3)."
  default                                     = "B_Standard_B1ms"
}

variable "PostgreStorage" {
  type                                        = number
  description                                 = "The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, and 33554432."
  default                                     = 32768
}

variable "PostgreVersion" {
  type                                        = number
  description                                 = "The version of PostgreSQL Flexible Server to use. Possible values are 11,12 and 13. Required when create_mode is Default. Changing this forces a new PostgreSQL Flexible Server to be created."
  default                                     = 11
}

variable "CustomMaintenanceWindow" {
  type                                        = bool
  description                                 = "A booleen used to activate the dynamic block for maintenance windiws"
  default                                     = false
}

variable "CustomMaintenanceWindowDay" {
  type                                        = number
  description                                 = "The day of week for maintenance window, where the week starts on a Sunday, i.e. Sunday = 0, Monday = 1. Defaults to 0."
  default                                     = null
}

variable "CustomMaintenanceWindowHour" {
  type                                        = number
  description                                 = "The start hour for maintenance window. Defaults to 0"
  default                                     = null
}

variable "CustomMaintenanceWindowMinute" {
  type                                        = number
  description                                 = "The start minute for maintenance window. Defaults to 0."
  default                                     = null
}

# PostgreSQL databases



###################################################################
#Tag related variables section

variable "DefaultTags" {
  type                                        = map
  description                                 = "Define a set of default tags"
  default                                       = {
    ResourceOwner                                   = "That would be me"
    Country                                         = "fr"
    CostCenter                                      = "labtf"
    Project                                         = "tfmodule"
    Environment                                     = "lab"
    ManagedBy                                       = "Terraform"

  }
}

variable "ExtraTags" {
  type                                        = map
  description                                 = "Define a set of additional optional tags."
  default                                       = {}
}

######################################################
############### Monitoring Variable ##################
######################################################

variable "ACGIds" {
  type                                        = set(string)
  description                                 = "A set of Action GroupResource Id"
  default                                     = []
}