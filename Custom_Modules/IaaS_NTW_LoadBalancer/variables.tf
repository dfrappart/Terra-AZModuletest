######################################################
# main variables variables
######################################################

variable "TargetRG" {
  type        = string
  description = "The Name of the RG targeted for the deployment"
  default     = "unspecified"
}

variable "TargetLocation" {
  type        = string
  description = "The location of the resources to be deployed"
  default     = "francecentral"
}

variable "LawLogId" {
  type        = string
  description = "The id of the log analytics workspace containing the logs"
  default     = "unspecified"
}

variable "StaLogId" {
  type        = string
  description = "The id of the storage account containing the logs on the subscription level"
  default     = "unspecified"
}

variable "EnableLocalLogSink" {
  type        = bool
  description = "A bool to enable or disable the creation of local log sinks for the logs and metrics"
  default     = false
}

variable "KVId" {
  type        = string
  description = "The target Key Vault ID."
  default     = null
}

variable "RgSuffix" {
  type        = string
  description = "The suffix to be added to the RG name"
  default     = "Lb"

}

######################################################
# Tag related variables and naming convention section

variable "MandatoryTags" {
  type = object({
    data_classification  = optional(string, null)
    operation_commitment = optional(string, null)
    usage                = optional(string, null)
    start_time           = optional(string, null)
    stop_time            = optional(string, null)

  })

  default = {}
}

variable "OptionalTags" {
  type = object({
    owner      = optional(string, "N/A")
    start_date = optional(string, "N/A")

  })
  default = {}
}

variable "ExtraTags" {
  type    = map(string)
  default = {}
}

######################################################
# LB variables

variable "LbConfig" {
  type = object({
    Suffix   = string
    Location = optional(string, "francecentral")
    Tags     = optional(map(string), {})
    Index    = optional(number, 1)
    IsLbPublic = optional(bool, true)
    InternalLbSubnetId = optional(string, null)
    Sku = optional(string, "Standard")
    SkuTier = optional(string, "Regional")
    PrivateIpAddressAllocation = optional(string, "Dynamic")
    PrivateIpAddress = optional(string, null)
    Zones = optional(list(string), ["1", "2", "3"])
    PubIpSkuTier = optional(string, "Regional")


  })

  default = {
    Suffix = "demo"
  }
  description = "An object to describe the Load Balancer"

}



######################################################
# Monitor variable

variable "PubIpAlertingEnabled" {
  type        = bool
  description = "A bool to enable/disable Azure alerts"
  default     = false

}

variable "LbAlertingEnabled" {
  type        = bool
  description = "A bool to enable/disable Azure alerts"
  default     = false

}

variable "ACGIds" {
  type        = list(string)
  description = "A list of Action Groups to send the alert to"
  default     = []
}





variable "PubIpAlerts" {
  description = "A map of object to define alerts on the Public IP"
  type = map(object({
    AlertName         = string
    AlertDescription  = string
    AlertSeverity     = optional(number, 3)
    MetricNameSpace   = optional(string, "Microsoft.Network/publicIPAddresses")
    MetricName        = string
    MetricAggregation = string
    MetricOperator    = string
    MetricThreshold   = number
    DimensionEnabled  = optional(bool, false)
    DimensionName     = optional(string, null)
    DimensionOperator = optional(string, null)
    DimensionValue    = optional(list(string), [])
    AlertFrequency    = optional(string, "PT5M")
    AlertWindow       = optional(string, "PT5M")
  }))

  default = {
    BytesInDDoS = {
      AlertName         = "BytesInDDoS"
      AlertDescription  = "BytesInDDoS"
      MetricName        = "BytesInDDoS"
      MetricAggregation = "Maximum"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 80000000
      AlertSeverity     = 4

    },
    IfUnderDDoSAttack = {
      AlertName         = "IfUnderDDoSAttack"
      AlertDescription  = "IfUnderDDoSAttack"
      MetricName        = "IfUnderDDoSAttack"
      MetricAggregation = "Maximum"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 0
      AlertSeverity     = 1

    },
    PacketsInDDoS = {
      AlertName         = "PacketsInDDoS"
      AlertDescription  = "PacketsInDDoS"
      MetricName        = "PacketsInDDoS"
      MetricAggregation = "Maximum"
      MetricOperator    = "GreaterThanOrEqual"
      MetricThreshold   = 40000
      AlertSeverity     = 4

    },
    TCPBytesInDDoS = {
      AlertName         = "TCPBytesInDDoS"
      AlertDescription  = "TCPBytesInDDoS"
      MetricName        = "TCPBytesInDDoS"
      MetricAggregation = "Maximum"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 40000
      AlertSeverity     = 3
      AlertWindow       = "PT1H"
      AlertFrequency    = "PT1M"

    },
    TCPPacketsInDDoS = {
      AlertName         = "TCPPacketsInDDoS"
      AlertDescription  = "TCPPacketsInDDoS"
      MetricName        = "TCPPacketsInDDoS"
      MetricAggregation = "Maximum"
      MetricOperator    = "GreaterThanOrEqual"
      MetricThreshold   = 40000
      AlertSeverity     = 3
      AlertWindow       = "PT1H"
      AlertFrequency    = "PT1M"

    },
    UDPBytesInDDoS = {
      AlertName         = "UDPBytesInDDoS"
      AlertDescription  = "UDPBytesInDDoS"
      MetricName        = "UDPBytesInDDoS"
      MetricAggregation = "Maximum"
      MetricOperator    = "GreaterThanOrEqual"
      MetricThreshold   = 40000
      AlertSeverity     = 3
      AlertWindow       = "PT1H"
      AlertFrequency    = "PT1M"

    },
    UDPPacketsInDDoS = {
      AlertName         = "UDPPacketsInDDoS"
      AlertDescription  = "UDPPacketsInDDoS"
      MetricName        = "UDPPacketsInDDoS"
      MetricAggregation = "Maximum"
      MetricOperator    = "GreaterThanOrEqual"
      MetricThreshold   = 40000
      AlertSeverity     = 3
      AlertWindow       = "PT1H"
      AlertFrequency    = "PT1M"

    },
    VipAvailability = {
      AlertName         = "VipAvailability"
      AlertDescription  = "VipAvailability"
      MetricName        = "VipAvailability"
      MetricAggregation = "Average"
      MetricOperator    = "LessThan"
      MetricThreshold   = 40000
      AlertSeverity     = 3
      AlertFrequency    = "PT1M"

    }


  }
}

variable "PubIpDiagnosticSettingsEnabled" {
  type        = bool
  description = "A bool to enable/disable Diagnostic settings"
  default     = false

}


variable "PubIpLogCategories" {

  description = "A list of log categories to activate on the PubIp Cluster. If set to null, it will use a data source to enable all categories"
  type        = list(string)
  default     = [
    "DDoSMitigationFlowLogs",
    "DDoSMitigationReports",
    "DDoSProtectionNotifications",]

}

variable "PubIpMetricsEnabled" {
  type        = bool
  description = "A bool to enable/disable Diagnostic settings metrics on the Public IP"
  default     = false

}

variable "PubIpMetricCategories" {

  description = "A list of metric categories to activate on the PubIp Cluster. If set to null, it will use a data source to enable all categories"
  type        = list(string)
  default     = ["AllMetrics"]

}

variable "LbAlerts" {
  description = "A map of object to define alerts on the Load Balancer"
  type = map(object({
    AlertName         = string
    AlertDescription  = string
    AlertSeverity     = optional(number, 3)
    MetricNameSpace   = optional(string, "Microsoft.Network/loadBalancers")
    MetricName        = string
    MetricAggregation = string
    MetricOperator    = string
    MetricThreshold   = number
    DimensionEnabled  = optional(bool, false)
    DimensionName     = optional(string, null)
    DimensionOperator = optional(string, null)
    DimensionValue    = optional(list(string), [])
    AlertFrequency    = optional(string, "PT5M")
    AlertWindow       = optional(string, "PT5M")
  }))

  default = {
    DipAvailability = {
      AlertName         = "DipAvailability"
      AlertDescription  = "DipAvailability"
      MetricName        = "DipAvailability"
      MetricAggregation = "Average"
      MetricOperator    = "LessThan"
      MetricThreshold   = 90
      AlertSeverity     = 0
      AlertFrequency    = "PT1M"

    },/*
    GlobalBackendAvailability = {
      AlertName         = "GlobalBackendAvailability"
      AlertDescription  = "GlobalBackendAvailability"
      MetricName        = "GlobalBackendAvailability"
      MetricAggregation = "Average"
      MetricOperator    = "LessThan"
      MetricThreshold   = 90
      AlertSeverity     = 0
      AlertFrequency    = "PT1M"

    },/*
    SnatConnectionCount = {
      AlertName         = "SnatConnectionCount"
      AlertDescription  = "SnatConnectionCount"
      MetricName        = "SnatConnectionCount"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 0
      AlertSeverity     = 1
      DimensionEnabled  = true
      DimensionName     = "connectionstate"
      DimensionOperator = "Include"
      DimensionValue    = ["failed"]

    },*/
    UsedSNATPorts = {
      AlertName         = "UsedSNATPorts"
      AlertDescription  = "UsedSNATPorts"
      MetricName        = "UsedSNATPorts"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 900
      AlertSeverity     = 1
      AlertFrequency    = "PT1M"

    },
    VipAvailability = {
      AlertName         = "VipAvailability"
      AlertDescription  = "VipAvailability"
      MetricName        = "VipAvailability"
      MetricAggregation = "Average"
      MetricOperator    = "LessThan"
      MetricThreshold   = 90
      AlertSeverity     = 0
      AlertFrequency    = "PT1M"

    }

  }
}

variable "LbDiagnosticSettingsEnabled" {
  type        = bool
  description = "A bool to enable/disable Diagnostic settings"
  default     = false

}

variable "LbLogCategories" {

  description = "A list of log categories to activate on the Load Balancer. If set to null, it will use a data source to enable all categories"
  type        = list(string)
  default     = [
    "LoadBalancerHealthEvent",]

}

variable "LbMetricsEnabled" {
  type        = bool
  description = "A bool to enable/disable Diagnostic settings metrics on the Load Balancer"
  default     = false

}
variable "LbMetricCategories" {

  description = "A list of metric categories to activate on the Load balancer. If set to null, it will use a data source to enable all categories"
  type        = list(string)
  default     = ["AllMetrics"]

}