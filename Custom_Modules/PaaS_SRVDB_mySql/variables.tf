##############################################################
#TVariable definition file
##############################################################

#Variable declaration for Module

variable "mysqlsuffix" {
  type        = string
  description = "suffix for the resources names"
  default     = "-1"
}

variable "Location" {
  type        = string
  description = "Azure region."
  default     = "westeurope"
}

variable "RGName" {
  type        = string
  description = "Name of resource group containing the resources"

}

######################################################
####################  MySQL  ####################
######################################################

# MySQL server

variable "MySQLSkuName" {
  type        = string
  description = "Specifies the SKU Name for this MySQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)."
  default     = "GP_Gen5_2"
}

variable "MySQLVersion" {
  type        = string
  description = "Specifies the version of MySQL to use. Valid values are 5.6, 5.7, and 8.0. Changing this forces a new resource to be created."
  default     = "5.7"
}

variable "MySQLLogin" {
  type        = string
  description = "The Administrator Login for the MySQL Server. Required when create_mode is Default. Changing this forces a new resource to be created."
  default     = "dbadmin"
}

variable "MySQLPwd" {
  type        = string
  description = "The Password associated with the administrator_login for the MySQL Server. Required when create_mode is Default."

}

variable "MySQLAutoGrow" {
  type        = bool
  description = "Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true."
  default     = null
}

variable "MySQLRetentionDays" {
  type        = string
  description = " Backup retention days for the server, supported values are between 7 and 35 days."
  default     = 35
}

variable "MySQLCreateMode" {
  type        = string
  description = "The creation mode. Can be used to restore or replicate existing servers. Possible values are Default, Replica, GeoRestore, and PointInTimeRestore. Defaults to Default."
  default     = null
}

variable "SRCSRVId" {
  type        = string
  description = "For creation modes other than Default, the source server ID to use."
  default     = null
}

variable "MySQLGeoRedundantBackup" {
  type        = string
  description = "Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not supported for the Basic tier."
  default     = null
}

variable "IsInfraEncrypted" {
  type        = string
  description = "Whether or not infrastructure is encrypted for this server. Defaults to false. Changing this forces a new resource to be created."
  default     = null
}

variable "IsPublicAccessEnabled" {
  type        = string
  description = "Whether or not public network access is allowed for this server. Defaults to true."
  default     = null
}

variable "RestorePIT" {
  type        = string
  description = "When create_mode is PointInTimeRestore, specifies the point in time to restore from creation_source_server_id."
  default     = null
}

variable "IsSSLEnforcementEnabled" {
  type        = bool
  description = "Specifies if SSL should be enforced on connections. Possible values are true and false."
  default     = true
}


variable "TLSVersion" {
  type        = string
  description = "The minimum TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLSEnforcementDisabled."
  default     = null
}


variable "MySQLStorageSize" {
  type        = string
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs. For more information see the product documentation."
  default     = 5120
}

# Threat detection

variable "IsThreatDetectionEnabled" {
  type        = bool
  description = "Is the policy enabled?"
  default     = true
}

variable "DisabledThreatAlertList" {
  type        = list(any)
  description = "Specifies a list of alerts which should be disabled. Possible values include Access_Anomaly, Sql_Injection and Sql_Injection_Vulnerability."
  default     = null
}

variable "EmailAccountAdminEnabled" {
  type        = bool
  description = " Should the account administrators be emailed when this alert is triggered?"
  default     = null

}

variable "ThreatAlertEmail" {
  type        = list(any)
  description = "A list of email addresses which alerts should be sent to"

}

variable "ThreatAlertRetentionDays" {
  type        = string
  description = "Specifies the number of days to keep in the Threat Detection audit logs."
  default     = 365
}


variable "ThreatAlertTargetStorageKey" {
  type        = string
  description = " Specifies the identifier key of the Threat Detection audit storage account."

}


variable "ThreatAlertTargetEP" {
  type        = string
  description = " Specifies the identifier key of the Threat Detection audit storage account."

}

# MySQL Azure AD administrator

variable "MySQLADAdminObjectId" {
  type        = string
  description = "Specifies the identifier key of the Threat Detection audit storage account."

}

variable "MySQLADAdminLogin" {
  type        = string
  description = "The login name of the principal to set as the server administrator"
  default     = "mysqlaadadmin"
}

# MySQL databases

variable "MySQLDbList" {
  type        = list(any)
  description = "List of MySQL databases names."
  default     = []
}

variable "MySQLDbCharset" {
  type        = string
  description = "Specifies the Charset for the MySQL Database, which needs to be a valid MySQL Charset. Changing this forces a new resource to be created."
  default     = "latin2"
}

variable "MySQLDbCollation" {
  type        = string
  description = "Specifies the Collation for the MySQL Database, which needs to be a valid MySQL Collation. Changing this forces a new resource to be created."
  default     = "latin2_general_ci"
}


variable "SubnetIds" {
  type        = list(any)
  description = "The ID of the subnets that the MySQL server will be connected to. We use a list and the count feature to add more than 1 subnet if necessary. It does impact the way we output the resources."
  default     = ["empty"]
}

variable "AllowedPubIPs" {
  type        = list(any)
  description = "The accept list for the FW rules. We use a list and the count feature to add more than 1 IP if necessary. It does impact the way we output the resources."
  default     = ["empty"]
}
variable "LawId" {
  type        = string
  description = "The ID of the storage account used for diag log storage"
  default     = "empty"
}

variable "STAId" {
  type        = string
  description = "The ID of log analytics used for diag log storage"
  default     = "empty"
}

# Tags variables
variable "ResourceOwnerTag" {
  type        = string
  description = "Application owner's e-mail address."
}

variable "CountryTag" {
  type        = string
  description = "Country name encoded on two letters. Possible values are FR, DE, US, HQ, etc."
}

variable "CostCenterTag" {
  type        = string
  description = "Project trigram."
}

variable "EnvironmentTag" {
  type        = string
  description = "Environment trigram. Possible values are DEV, UAT, PPD, PRD"
}

variable "ManagedByTag" {
  type        = string
  description = "Resource provisioner."
  default     = "Terraform"
}

######################################################
############### Monitoring Variable ##################
######################################################

variable "ACG1Id" {
  type        = string
  description = "Resource Id of the 1st action group"
}



variable "DBLowConnectionThreshold" {
  type        = string
  description = "threshold for Memory server load on DB"
  default     = 3
}

variable "DBHighConnectionThreshold" {
  type        = string
  description = "threshold for Memory server load on DB"
  default     = 200
}

variable "DBFailedConnectionThreshold" {
  type        = string
  description = "threshold for failed connection on DB"
  default     = 10
}

variable "DBStoragePercentHighThreshold" {
  type        = string
  description = "threshold for Storage high threshold on DB"
  default     = 80
}

variable "DBCPUPercentHighThreshold" {
  type        = string
  description = "threshold for CPU high threshold on DB"
  default     = 80
}