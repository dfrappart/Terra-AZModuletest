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
  default     = "eastus"
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

variable "EnabledDiagSettings" {
  type        = bool
  description = "A bool to enable or disable the diagnostic settings"
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
  default     = "appsvc"

}

######################################################
# Tag related variables and naming convention section

variable "mandatory_tags" {
  type = object({
    data_classification  = optional(string, null)
    operation_commitment = optional(string, null)
    usage                = optional(string, null)
    start_time           = optional(string, null)
    stop_time            = optional(string, null)

  })

  default = {}
}

variable "optional_tags" {
  type = object({
    owner      = optional(string, "N/A")
    start_date = optional(string, "N/A")

  })
  default = {}
}

variable "extra_tags" {
  type    = map(string)
  default = {}
}

######################################################
# App Service plan variables

variable "AppSvcPlan" {
  type = object({
    Name                        = string
    Location                    = string
    SkuName                     = optional(string, "B1")
    OsType                      = optional(string, "Linux")
    AppServiceEnvironmentId     = optional(string, null)
    PerSiteScalingEnabled       = optional(bool, false)
    PremiumPlanAutoScaleEnabled = optional(bool, false)
    MaximumElasticWorkerCount   = optional(number, null)
    WorkerCount                 = optional(number, null)
    ZoneBalancingEnabled        = optional(bool, true)
  })

  description = "An object to describe the App Service Plan"

}

######################################################
# App Service variables

variable "AppSvc" {
  type = map(object({
    Name                       = string
    PublicNetworkAccessEnabled = optional(bool, true)
    HttpsOnly                  = optional(bool, false)
    EnableVnetIntegration      = optional(bool, false)
    VnetSubnetId               = optional(string, null)

    #AppSvcSiteConfig
    SiteConfigAlwaysOn                                 = optional(bool, true)
    SiteConfigApiDefinitionUrl                         = optional(string, null)
    SiteConfigApiMgmtApiId                             = optional(string, null)
    SiteConfigAppCommandLine                           = optional(string, null)
    SiteConfigContainerRegistryManagedIdentityClientId = optional(string, null)
    SiteConfigContainerRegistryUseManagedIdentity      = optional(bool, false)
    SiteConfigFtpsState                                = optional(string, "Disabled")
    SiteConfigHealthCheckPath                          = optional(string, null)
    SiteConfigHealthCheckEvictionTimeInMinutes         = optional(number, null)
    SiteConfigHttp2Enabled                             = optional(bool, false)
    SiteConfigAllowedIps                               = optional(list(string), [])
    SiteConfigIpRestrictionDefaultAction               = optional(string, "Deny")
    SiteConfigLoadBalancingMode                        = optional(string, "LeastRequests")
    SiteConfigLocalMySqlEnabled                        = optional(bool, false)
    SiteConfigManagedPipelineMode                      = optional(string, "Integrated")
    SiteConfigMinTlsVersion                            = optional(string, "1.2")
    SiteConfigRemoteDebuggingEnabled                   = optional(bool, false)
    SiteConfigRemoteDebuggingVersion                   = optional(string, null)
    SiteConfigScmAllowedIps                            = optional(list(string), [])
    SiteConfigScmIpRestrictionDefaultAction            = optional(string, "Deny")
    SiteConfigScmMinimumTlsVersion                     = optional(string, "1.2")
    SiteConfigScmUseMainIpRestriction                  = optional(bool, false)
    SiteConfigUse32BitWorker                           = optional(bool, true)
    SiteConfigVnetRouteAllEnabled                      = optional(bool, false)
    SiteConfigWebSocketsEnabled                        = optional(bool, false)
    SiteConfigWorkerCount                              = optional(number, 1)

    # Site ConfigApplicationStack Container
    SiteConfigAppStackDockerImageName        = optional(string, "appsvc/staticsite:latest")
    SiteConfigAppStackDockerRegistryUrl      = optional(string, "https://mcr.microsoft.com")
    SiteConfigAppStackDockerRegistryUsername = optional(string, null)
    SiteConfigAppStackDockerRegistryPassword = optional(string, null)

    # Site ConfigApplicationStack .NET
    SiteConfigAppStackDotNetVersion = optional(string, null)

    # Site ConfigApplicationStack Go
    SiteConfigAppStackGoVersion = optional(string, null)

    # Site ConfigApplicationStack Java
    SiteConfigAppStackJavaVersion       = optional(string, null)
    SiteConfigAppStackJavaServer        = optional(string, null)
    SiteConfigAppStackJavaServerVersion = optional(string, null)

    # Site ConfigApplicationStack Node
    SiteConfigAppStackNodeVersion = optional(string, null)

    # Site ConfigApplicationStack PHP
    SiteConfigAppStackPhpVersion = optional(string, null)

    # Site ConfigApplicationStack Python
    SiteConfigAppStackPythonVersion = optional(string, null)

    # Site ConfigApplicationStack Ruby
    SiteConfigAppStackRubyVersion = optional(string, null)

    #AutoHealing = optional(object({}, {}))





  }))

  description = "An object to describe the App Service"
  default = {
    "App1" = {
      Name = "appsvctestmap"

    }
  }
}


######################################################
# Monitor variable

variable "AlertingEnabled" {
  type        = bool
  description = "A bool to enable/disable Azure alerts"
  default     = true

}

variable "ACGIds" {
  type        = list(string)
  description = "A list of Action Groups to send the alert to"
  default     = []
}


variable "AppSvcPlanAlerts" {
  description = "A map of object to define alerts on the App Service Plan"
  type = map(object({
    AlertName         = string
    AlertDescription  = string
    AlertSeverity     = optional(number, 3)
    MetricNameSpace   = optional(string, "Microsoft.Web/serverFarms")
    MetricName        = string
    MetricAggregation = string
    MetricOperator    = string
    MetricThreshold   = number
    AlertFrequency    = optional(string, "PT5M")
    AlertWindow       = optional(string, "PT5M")
  }))

  default = {
    BytesReceived = {
      AlertName         = "BytesReceived"
      AlertDescription  = "The average incoming bandwidth used across all instances of the plan."
      MetricName        = "BytesReceived"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 100000
    }, /*
    BytesSent = {
      AlertName         = "BytesSent"
      AlertDescription  = "The average outgoing bandwidth used across all instances of the plan."
      MetricName        = "Network In Total"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 500000000000
    },*/
    CpuPercentage = {
      AlertName         = "CpuPercentage"
      AlertDescription  = "The average CPU used across all instances of the plan."
      MetricName        = "CpuPercentage"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 90
      AlertFrequency    = "PT1M"
    },
    DiskQueueLength = {
      AlertName         = "DiskQueueLength"
      AlertDescription  = "The average number of both read and write requests that were queued on storage. A high disk queue length is an indication of an app that might be slowing down because of excessive disk I/O."
      MetricName        = "DiskQueueLength"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 100
      AlertFrequency    = "PT1M"
    },
    HttpQueueLength = {
      AlertName         = "HttpQueueLength"
      AlertDescription  = "The average number of HTTP requests that had to sit on the queue before being fulfilled. A high or increasing HTTP Queue length is a symptom of a plan under heavy load."
      MetricName        = "HttpQueueLength"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 100
      AlertFrequency    = "PT1M"
    },
    MemoryPercentage = {
      AlertName         = "MemoryPercentage"
      AlertDescription  = "The average memory used across all instances of the plan."
      MetricName        = "MemoryPercentage"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 90
      AlertFrequency    = "PT1M"
    }
  }
}


variable "AppSvcAlerts" {
  description = "A map of object to define alerts on the App Service"
  type = map(object({
    AlertName         = string
    AlertDescription  = string
    AlertSeverity     = optional(number, 3)
    MetricNameSpace   = optional(string, "Microsoft.Web/sites")
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
    /*AppConnections = {
      AlertName         = "AppConnections"
      AlertDescription  = "The number of bound sockets existing in the sandbox (w3wp.exe and its child processes). A bound socket is created by calling bind()/connect() APIs and remains until said socket is closed with CloseHandle()/closesocket(). For WebApps and FunctionApps."
      MetricName        = "AppConnections"
      MetricAggregation = "Maximum"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 6000
      AlertWindow       = "PT15M"
      DimensionEnabled  = true
      DimensionName     = "instance"
      DimensionOperator = "include"
      DimensionValue    = ["*"]
    },*/
    AverageResponseTime = {
      AlertName         = "AverageResponseTime"
      AlertDescription  = "The average time taken for the app to serve requests, in seconds. For WebApps and FunctionApps."
      MetricName        = "AverageResponseTime"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 60
    },
    BytesReceived = {
      AlertName         = "BytesReceived"
      AlertDescription  = "The amount of incoming bandwidth consumed by the app, in MiB. For WebApps and FunctionApps."
      MetricName        = "BytesReceived"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 2048000000
      AlertFrequency    = "PT1M"
    }, /*
    BytesSent = {}
    */
    CpuTime = {
      AlertName         = "CpuTime"
      AlertDescription  = "The amount of CPU consumed by the app, in seconds. For more information about this metric. Please see https://aka.ms/website-monitor-cpu-time-vs-cpu-percentage (CPU time vs CPU percentage). For WebApps only."
      MetricName        = "CpuTime"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 120
      AlertFrequency    = "PT1M"
    }, /*
    CurrentAssemblies = {
      AlertName         = "CurrentAssemblies"
      AlertDescription  = "The current number of Assemblies loaded across all AppDomains in this application. For WebApps and FunctionApps."
      MetricName        = "CurrentAssemblies"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 0
      AlertSeverity     = 0
      AlertFrequency    = "PT1M"
      AlertWindow       = "PT1M"
    },*/
    FileSystemUsage = {
      AlertName         = "FileSystemUsage"
      AlertDescription  = "Percentage of filesystem quota consumed by the app. For WebApps and FunctionApps."
      MetricName        = "FileSystemUsage"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 400000000
      AlertFrequency    = "PT1H"
      AlertWindow       = "PT6H"
    }, /*
    FunctionExecutionCount = {
      AlertName         = "FunctionExecutionCount"
      AlertDescription  = "Function Execution Count. For FunctionApps only."
      MetricName        = "FunctionExecutionCount"
      MetricAggregation = "Total"
      MetricOperator    = "LessThanOrEqual"
      MetricThreshold   = 0
      AlertFrequency    = "PT1M"
      AlertSeverity     = 1
    },
    FunctionExecutionUnits = {
      AlertName         = "FunctionExecutionUnits"
      AlertDescription  = "Function Execution Count. For FunctionApps only."
      MetricName        = "FunctionExecutionUnits"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 13000000000
      AlertFrequency    = "PT1M"
    },*/ /*Dynamic threshold
    Handles = {
      AlertName         = "Handles"
      AlertDescription  = "The total number of handles currently open by the app process. For WebApps and FunctionApps."
      MetricName        = "Handles"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterOrLessThan"
      MetricThreshold   = 13000000000
      AlertFrequency    = "PT1M"
      AlertSeverity     = 2
    },*/
    Http2xx = {
      AlertName         = "Http2xx"
      AlertDescription  = "The count of requests resulting in an HTTP status code >= 200 but < 300. For WebApps and FunctionApps."
      MetricName        = "Http2xx"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 15
    },
    Http3xx = {
      AlertName         = "Http3xx"
      AlertDescription  = "The count of requests resulting in an HTTP status code >= 300 but < 400. For WebApps and FunctionApps."
      MetricName        = "Http3xx"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 15
    },
    Http401 = {
      AlertName         = "Http401"
      AlertDescription  = "The count of requests resulting in HTTP 401 status code. For WebApps and FunctionApps."
      MetricName        = "Http401"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 20
      AlertSeverity     = 2
    },
    Http406 = {
      AlertName         = "Http406"
      AlertDescription  = "The count of requests resulting in HTTP 406 status code. For WebApps and FunctionApps."
      MetricName        = "Http406"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 1
      AlertSeverity     = 1
      AlertWindow       = "PT15M"
    },
    MemoryWorkingSet = {
      AlertName         = "MemoryWorkingSet"
      AlertDescription  = "The current amount of memory used by the app, in MiB. For WebApps and FunctionApps."
      MetricName        = "MemoryWorkingSet"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 1500000000
      AlertFrequency    = "PT1M"
    }, /*
    PrivateBytes = {
      AlertName         = "PrivateBytes"
      AlertDescription  = "Private Bytes is the current size, in bytes, of memory that the app process has allocated that can't be shared with other processes. For WebApps and FunctionApps."
      MetricName        = "PrivateBytes"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 1200000000
      AlertFrequency    = "PT1M"
    },*/
    Requests = {
      AlertName         = "Requests"
      AlertDescription  = "Private Bytes is the current size, in bytes, of memory that the app process has allocated that can't be shared with other processes. For WebApps and FunctionApps."
      MetricName        = "Requests"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 1000
      AlertFrequency    = "PT1M"
    }, /*
    RequestsInApplicationQueue = {
      AlertName         = "RequestsInApplicationQueue"
      AlertDescription  = "The number of requests in the application request queue. For WebApps and FunctionApps."
      MetricName        = "RequestsInApplicationQueue"
      MetricAggregation = "Maximum"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 10
      AlertWindow       = "PT15M"
      DimensionEnabled  = true
      DimensionName     = "instance"
      DimensionOperator = "include"
      DimensionValue    = ["*"]
    },*/ /*
    AverageMemoryWorkingSetSlot = {
      AlertName         = "AverageMemoryWorkingSetSlot"
      AlertDescription  = "The average amount of memory used by the app, in megabytes (MiB)."
      MetricName        = "AverageMemoryWorkingSet"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 800000000
      MetricNameSpace   = "Microsoft.Web/sites/slots"
    },
    HealthCheckStatusSlot = {
      AlertName         = "HealthCheckStatusSlot"
      AlertDescription  = "Health check status"
      MetricName        = "HealthCheckStatus"
      MetricAggregation = "Average"
      MetricOperator    = "LessThan"
      MetricThreshold   = 100
      AlertFrequency    = "PT1M"
      MetricNameSpace   = "Microsoft.Web/sites/slots"
    },
    Http403Slot = {
      AlertName         = "Http403Slot"
      AlertDescription  = "The count of requests resulting in HTTP 403 status code."
      MetricName        = "Http403"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 5
      AlertFrequency    = "PT15M"
      AlertWindow       = "PT30M"
      MetricNameSpace   = "Microsoft.Web/sites/slots"
    },
    Http404Slot = {
      AlertName         = "Http404Slot"
      AlertDescription  = "The count of requests resulting in HTTP 404 status code."
      MetricName        = "Http404"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 30
      AlertWindow       = "PT15M"
      AlertSeverity     = 2
      MetricNameSpace   = "Microsoft.Web/sites/slots"
    },
    Http4xxSlot = {
      AlertName         = "Http4xxSlot"
      AlertDescription  = "The count of requests resulting in HTTP 404 status code."
      MetricName        = "Http4xx"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 5
      AlertWindow       = "PT30M"
      AlertSeverity     = 1
      MetricNameSpace   = "Microsoft.Web/sites/slots"
    },
    Http5xxSlot = {
      AlertName         = "Http5xxSlot"
      AlertDescription  = "The count of requests resulting in an HTTP status code >= 500 but < 600."
      MetricName        = "Http5xx"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 10
      AlertWindow       = "PT15M"
      AlertSeverity     = 1
      MetricNameSpace   = "Microsoft.Web/sites/slots"
    },
    HttpResponseTimeSlot = {
      AlertName         = "HttpResponseTimeSlot"
      AlertDescription  = "The time taken for the app to serve requests, in seconds."
      MetricName        = "HttpResponseTime"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 5
      AlertWindow       = "PT15M"
      AlertSeverity     = 1
      MetricNameSpace   = "Microsoft.Web/sites/slots"
    }/*,
    Threads = {
      AlertName         = "Threads"
      AlertDescription  = "The number of threads currently active in the app process. For WebApps and FunctionApps."
      MetricName        = "Threads"
      MetricAggregation = "Average"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 200
      AlertWindow       = "PT15M"
      AlertSeverity     = 4
    }/*,
    WorkflowRunsFailureRate = {
      AlertName         = "WorkflowRunsFailureRate"
      AlertDescription  = "Workflow Runs Failure Rate. For LogicApps only."
      MetricName        = "WorkflowRunsFailureRate"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 0
      AlertSeverity     = 1
    },
    WorkflowRunsFailureRate = {
      AlertName         = "WorkflowRunsFailureRate"
      AlertDescription  = "Workflow Runs Failure Rate. For LogicApps only."
      MetricName        = "WorkflowRunsFailureRate"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 50
      AlertSeverity     = 1
    },
    WorkflowRunsFailureRate = {
      AlertName         = "WorkflowRunsFailureRate"
      AlertDescription  = "Workflow Runs Failure Rate. For LogicApps only."
      MetricName        = "WorkflowRunsFailureRate"
      MetricAggregation = "Total"
      MetricOperator    = "GreaterThan"
      MetricThreshold   = 0
      AlertSeverity     = 1
    }*/

  }
}