######################################################
# Data sources variables
######################################################


variable "CreateRg" {
  type        = bool
  default     = false
  description = "A bool to decide if the RG is to be created. Set to true, it forces the creation of a new RG"

}
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
}

######################################################
# Application GW variables

variable "PubIpLogCategories" {

  description = "A list of log categories to activate on the public ip"
  type        = list(any)
  default     = null

}

variable "PubIpMetricCategories" {

  description = "A list of metric categories to activate on the public ip"
  type        = list(any)
  default     = null

}

variable "AgwLogCategories" {

  description = "A list of log categories to activate on the Application Gateway"
  type        = list(any)
  default     = null

}

variable "AgwMetricCategories" {

  description = "A list of metric categories to activate on the Application Gateway"
  type        = list(any)
  default     = null

}

variable "AZList" {
  type        = list(any)
  default     = [1, 2, 3]
  description = "A list of AZ"
}


variable "TargetSubnetId" {
  type        = string
  description = "The subnet Id for the app gw"
}

variable "TargetSubnetAddressPrefix" {
  type        = string
  description = "The subnet prefix for the app gw"
}

variable "AppGwPrivateFrontendIpAddressHostnum" {
  type        = string
  description = "Determines the priv ip of the application gateway"
  default     = 10
}

variable "AGWSuffix" {
  type        = string
  description = "A short string to add at the end of the app gw name"
  default     = "-1"
}

variable "AppGatewaySkuName" {
  type        = string
  description = "The AppGW Sku Name"
  default     = "WAF_v2"
}

variable "AppGatewaySkuTier" {
  type        = string
  description = "The AppGW Sku Tier"
  default     = "WAF_v2"
}

variable "WafMode" {
  type        = string
  description = "The waf mode, can be prevention or Detection"
  default     = "Prevention"
}

variable "WafRuleSetVersions" {
  type        = string
  description = "The OWASP Rule set version, can be 2.9, 3.0 or 3.1"
  default     = "3.1"
}

variable "AppGatewaySkuCapacity" {
  type        = string
  description = "The AppGW capacity. Optional if the autoscale is enabled"
  default     = 3
}

variable "FirewallPolicyId" {
  type        = string
  description = "The Id of the Waf Policy applied on the Agw"
  default     = null
}

# settings for probe

variable "ProbeInterval" {
  type        = string
  description = "Time interval (in seconds) between 2 consecutive probes for health probe #1. Possible values range from 1 second to a maximum of 86400 seconds."
  default     = 10
}

variable "ProbeProtocol" {
  type        = string
  description = "The Protocol used for this Probe. Possible values are Http and Https."
  default     = "Http"
}

variable "ProbePath" {
  type        = string
  description = "The probe path. URI test path for health probe #1. Must begin with a /."
  default     = "/"
}

variable "ProbeTimeOut" {
  type        = string
  description = "The timeout (in seconds) for health probe #1, which indicates when a probe becomes unhealthy. Possible values range from 1 second to a maximum of 86400 seconds."
  default     = 31
}

variable "ProbeUnhealthyThreshold" {
  type        = string
  description = "Unhealthy threshold (number) for health probe #1, which indicates the amount of retries which should be attempted before a node is deemed unhealthy. Possible values are from 1 - 20 retries."
  default     = 3
}

variable "ProbeHost" {
  type        = string
  description = "The Hostname used for this Probe. If the Application Gateway is configured for a single site, by default the Host name should be specified as ‘127.0.0.1’, unless otherwise configured in custom probe. Cannot be set if pick_host_name_from_backend_http_settings is set to true."
  default     = "127.0.0.1"
}

variable "ProbePort" {
  type        = string
  description = "Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from http settings will be used. This property is valid for Standard_v2 and WAF_v2 only."
  default     = 80
}

# settings for backend http settings

variable "BHSPort" {
  type        = string
  description = "The port which should be used for this Backend HTTP Settings Collection."
  default     = 80
}

variable "BHSCookieConfig" {
  type        = string
  description = "Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled."
  default     = "Disabled"
}

variable "BHSProtocol" {
  type        = string
  description = "The Protocol which should be used. Possible values are Http and Https."
  default     = "Http"
}

variable "BEHTTPSettingsRequestTimeOut" {
  type        = string
  description = "The request timeout in seconds, which must be between 1 and 86400 seconds."
  default     = 31
}

######################################################
# settings for dynamic block

# map for mabnaging multiple Front end port with dynamic block

variable "FrontEndPort" {
  type        = string
  description = "The port used for the Frontend Port."
  default     = 443
}

variable "FrontEndPorts" {
  type        = map(any)
  description = "A map used to feed the dynamic blocks of the gw configuration for the front end port"
  default = {
    "FrontEndPortDefault" = {
      FrontEndPort = 443

    }
  }
}

# map for mabnaging multi sites with dynamic block

variable "SitesConf" {
  type = map(object({

    HostName = string

    BePoolIps           = optional(list(string), [])
    BePoolInternalFqdns = optional(list(string), [])
    BePoolName          = optional(string, "")

    BhsName                      = optional(string, "")
    BhsPort                      = optional(number, 80)
    BhsProtocol                  = optional(string, "Http")
    BhsAffinityCookieName        = optional(string, null)
    BhsCookieBasedAffinityConfig = optional(string, "Disabled")
    BhsProbeName                 = optional(string, null)
    BhsRequestTimeOut            = optional(number, null)
    BhsPath                      = optional(string, null)
    BhsTrustedRootCert           = optional(list(string), [])
    BhsHostName                  = optional(string, "")

    LstName             = optional(string, "")
    LstProtocol         = optional(string, "Https")
    LstFirewallPolicyId = optional(string, null)

    SslCertName   = optional(string, null)
    SslKvSecretId = optional(string, null)

    ReqRuleName     = optional(string, "")
    ReqRulePriority = number

    EnableProbe             = optional(bool, false)
    ProbeName               = optional(string, "")
    ProbeHost               = optional(string, null)
    ProbeInterval           = optional(string, null)
    ProbeProtocol           = optional(string, null)
    ProbePath               = optional(string, null)
    ProbeTimeOut            = optional(string, null)
    ProbeUnhealthyThreshold = optional(string, null)










  }))
  description = "A map used to feed the dynamic blocks of the gw configuration"
  default = {
    "Site 1" = {
      HostName        = "default"
      ReqRulePriority = 1
    }
  }
}


variable "TrustedRootCertificates" {
  type = map(object({
    CertName       = string
    CertKvSecretId = optional(string, null)
    CertData       = optional(string, null)

  }))
}
######################################################
# Tag related variables and naming convention section

variable "DefaultTags" {
  type        = map(any)
  description = "Default Tags"
  default = {
    Environment   = "dev"
    Project       = "tfmodule"
    Company       = "dfitc"
    CostCenter    = "lab"
    Country       = "fr"
    ResourceOwner = "That would be me"
  }
}

variable "extra_tags" {
  type        = map(any)
  description = "Additional optional tags."
  default     = {}
}