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
                                            LogCatName                        = "QueryStoreWaitStatistics"
                                            IsLogCatEnabledForLAW             = true
                                            IsLogCatEnabledForSTA             = true
                                            IsRetentionEnabled                = true
                                            RetentionDaysValue                = 365
    }
                                          "Category2" = {
                                            LogCatName                        = "PostgreSQLLogs"
                                            IsLogCatEnabledForLAW             = true
                                            IsLogCatEnabledForSTA             = true
                                            IsRetentionEnabled                = true
                                            RetentionDaysValue                = 365
    }
                                          "Category3" = {
                                            LogCatName                        = "QueryStoreRuntimeStatistics"
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

variable "PostgreSkuName" {
  type                                        = string
  description                                 = "SKU string for the PostgreSQL server. String building pattern: SKU letter + tier + family + number of cores (e.g. B_Gen4_1, GP_Gen5_8)."
  default                                     = "GP_Gen5_2"
}

variable "PostgreStorage" {
  type                                        = string
  description                                 = "Max storage (in MB) allowed for a server. Possible values are between 5120 MB (5GB) and 1048576 MB (1TB) for the Basic SKU and between 5120 MB (5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs. "
  default                                     = 5120
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

variable "PostgreAutoGrow" {
  type                                        = bool
  description                                 = "Choice whether enabling auto-growing of the storage. Possible values are true or false."
  default                                     = true
}

variable "PostgreVersion" {
  type                                        = string
  description                                 = "Version of PostgreSQL to use. Current valid values are 9.5, 9.6, 10, 10.0, or 11."
  default                                     = 11
}

variable "PostgreLogin" {
  type                                        = string
  description                                 = "Administrator login for the PostgreSQL server."
  default                                     = "sqladmin"
}

variable "PostgrePwd" {
  type                                        = string
  description                                 = "Password associated with the administrator_login for the PostgreSQL server."
}

variable "IsManagedIdentityEnabled" {
  type                                        = bool
  description                                 = "A boolean to activate the MSI. Default to true"
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

variable "PostgreMSIType" {
  type                                        = string
  description                                 = " Specifies the type of Managed Service Identity that should be configured on this PostgreSQL Server. The only possible value is SystemAssigned."
  default                                     = "SystemAssigned"
}

variable "IsPublicAccessEnabledEnabled" {
  type                                        = bool
  description                                 = "Whether or not public network access is allowed for this server. Defaults to true."
  default                                     = true
}

variable "IsInfrastructureEncryptionEnabled" {
  type                                        = bool
  description                                 = "Whether or not infrastructure is encrypted for this server. Defaults to false. Changing this forces a new resource to be created."
  default                                     = false
}

variable "IsSSLEnforcmentEnabled" {
  type                                        = bool
  description                                 = "Specifies if SSL should be enforced on connections. Possible values are true and false."
  default                                     = true
}

variable "PostgreTLSVer" {
  type                                        = string
  description                                 = "The mimimun TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLSEnforcementDisabled."
  default                                     = "TLS1_2"
}

variable "IsthreatDetectionPolicyEnabled" {
  type                                        = bool
  description                                 = "Define if Threat Detection Policy is enabled"
  default                                     = true
}

variable "PostgreThreatDetectionDisabledAlertList" {
  type                                        = list
  description                                 = "Specifies a list of alerts which should be disabled. Possible values include Access_Anomaly, Sql_Injection and Sql_Injection_Vulnerability."
  default                                     = null
}

variable "PostgreThreatDetectionEmailAdminAccount" {
  type                                        = bool
  description                                 = "Should the account administrators be emailed when this alert is triggered?"
  default                                     = null
}

variable "PostgreThreatDetectionEmailRecipientsList" {
  type                                        = list
  description                                 = "A list of email addresses which alerts should be sent to."
  default                                     = null
}

variable "PostgreThreatDetectionRetention" {
  type                                        = number
  description                                 = "Specifies the number of days to keep in the Threat Detection audit logs."
  default                                     = null
}

variable "PostgreThreatDetectionSTAKey" {
  type                                        = string
  description                                 = "Specifies the identifier key of the Threat Detection audit storage account."
  default                                     = null
}

variable "PostgreThreatDetectionSTAEP" {
  type                                        = string
  description                                 = "Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs."
  default                                     = null
}

# PostgreSQL databases

variable "PostgreDbList" {
  type                                        = list
  description                                 = "List of PostrgreSQL databases names."
  default                                     = []
}

variable "PostgreDbCharset" {
  type                                        = string
  description                                 = "Charset for PostreSQL database(s)."
  default                                     = "UTF8"
}

variable "PostgreDbCollation" {
  type                                        = string
  description                                 = "Collation for PostreSQL database(s)."
  default                                     = "English_United States.1252"
}


variable "SubnetIds" {
    type                                      = list
    description                               = "List of Subnet Id to be added in the firewall Virtual Network Subnet rule, default to [] so the count meta argument disable de resource by default"
    default                                   = []
}

variable "AllowedPubIPs" {
    type                                      = list
    description                               = "List of sigle public IP to be added in the firewall allowed IP rule, default to [] so the count meta argument disable de resource by default"
    default                                   = []
}

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



variable "DBLowConnectionThreshold" {
  type                                        = number
  description                                 = "threshold for Memory server load on DB"
  default                                     = 3
}

variable "DBHighConnectionThreshold" {
  type                                        = number
  description                                 = "threshold for Memory server load on DB"
  default                                     = 200
}

variable "DBFailedConnectionThreshold" {
  type                                        = number
  description                                 = "threshold for failed connection on DB"
  default                                     = 10
}

variable "DBStoragePercentHighThreshold" {
  type                                        = number
  description                                 = "threshold for Storage high threshold on DB"
  default                                     = 80
}

variable "DBCPUPercentHighThreshold" {
  type                                        = number
  description                                 = "threshold for CPU high threshold on DB"
  default                                     = 80
}