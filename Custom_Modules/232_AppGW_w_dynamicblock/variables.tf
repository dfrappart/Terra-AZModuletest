######################################################
# Data sources variables
######################################################

variable "TargetRG" {
  type                              = string
  description                       = "The Name of the RG targeted for the deployment"
}

variable "TargetLocation" {
  type                              = string
  description                       = "The location of the resources to be deployed"
}

variable "LawSubLogId" {
  type                              = string
  description                       = "The id of the log analytics workspace containing the logs"
}

variable "STASubLogId" {
  type                              = string
  description                       = "The id of the storage account containing the logs on the subscription level"
}

variable "KVId" {
  type        = string
  description = "The target Key Vault ID."
}

######################################################
# Application GW variables

variable "AZList" {
  type                  = list
  description           = [1,2,3]
}
AZList

variable "TargetSubnetId" {
  type                  = string
  description           = "The subnet Id for the app gw"
}

variable "AGWSuffix" {
  type                  = string
  description           = "A short string to add at the end of the app gw name"
  default               = "-1"
}

variable "AppGatewaySkuName" {
  type                  = string
  description           = "The AppGW Sku Name"
  default               = "WAF_v2"
}

variable "AppGatewaySkuTier" {
  type                  = string
  description           = "The AppGW Sku Tier"
  default               = "WAF_v2"
}

variable "WafMode" {
  type                  = string
  description           = "The waf mode, can be prevention or Detection"
  default               = "Prevention"
}

variable "WafRuleSetVersions" {
  type                  = string
  description           = "The OWASP Rule set version, can be 2.9, 3.0 or 3.1"
  default               = "3.1"
}

variable "AppGatewaySkuCapacity" {
  type                  = string
  description           = "The AppGW capacity. Optional if the autoscale is enabled"
  default               = 3
}


variable "BEHTTPSettingsRequestTimeOut" {
  type                  = string
  description           = "The request timeout in seconds, which must be between 1 and 86400 seconds."
  default               = 31
}

# settings for probe

variable "ProbeInterval" {
  type                  = string
  description           = "Time interval (in seconds) between 2 consecutive probes for health probe #1. Possible values range from 1 second to a maximum of 86400 seconds."
  default               = 10
}

variable "ProbeProtocol" {
  type                  = string
  description           = "The Protocol used for this Probe. Possible values are Http and Https."
  default               = "http"
}

variable "ProbePath" {
  type                  = string
  description           = "The probe path. URI test path for health probe #1. Must begin with a /."
  default               = "/"
}

variable "ProbeTimeOut" {
  type                  = string
  description           = "The timeout (in seconds) for health probe #1, which indicates when a probe becomes unhealthy. Possible values range from 1 second to a maximum of 86400 seconds."
  default               = 31
}

variable "ProbeUnhealthyThreshold" {
  type                  = string
  description           = "Unhealthy threshold (number) for health probe #1, which indicates the amount of retries which should be attempted before a node is deemed unhealthy. Possible values are from 1 - 20 retries."
  default               = 3
}

variable "ProbeHost" {
  type                  = string
  description           = "The Hostname used for this Probe. If the Application Gateway is configured for a single site, by default the Host name should be specified as ‘127.0.0.1’, unless otherwise configured in custom probe. Cannot be set if pick_host_name_from_backend_http_settings is set to true."
  default               = "127.0.0.1"
}

variable "ProbePort" {
  type                  = string
  description           = "Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from http settings will be used. This property is valid for Standard_v2 and WAF_v2 only."
  default               = null
}

# settings for backend http settings

variable "BHSPort" {
  type                  = string
  description           = "The port which should be used for this Backend HTTP Settings Collection."
  default               = 80
}

variable "BHSCookieConfig" {
  type                  = string
  description           = "Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled."
  default               = "Disabled"
}

variable "BHSProtocol" {
  type                  = string
  description           = "The Protocol which should be used. Possible values are Http and Https."
  default               = "Http"
}

variable "BEHTTPSettingsRequestTimeOut" {
  type                  = string
  description           = "The request timeout in seconds, which must be between 1 and 86400 seconds."
  default               = 31
}

# settings for backend http settings

variable "FrontEndPort" {
  type                  = string
  description           = "The port used for the Frontend Port."
  default               = 443
}

######################################################
# settings for dynamic block

# map for mabnaging multiple Front end port with dynamic block

variable "FrontEndPort" {
  type                  = string
  description           = "The port used for the Frontend Port."
  default               = 443
}

variable "FrontEndPorts" {
  type                  = map
  description            = "A map used to feed the dynamic blocks of the gw configuration for the front end port"
  default                = {
      "FrontEndPortDefault" = {
        FrontEndPort                                = 443

    }
  }
}

# map for mabnaging multi sites with dynamic block

variable "SitesConf" {
  type                  = map
  description            = "A map used to feed the dynamic blocks of the gw configuration"
  default                = {
      "Site 1" = {
        SiteIdentifier                                = "default"
        AppGWSSLCertNameSite                          = "default"
        AppGwPublicCertificateSecretIdentifierSite    = "default"
        HostnameSite                                  = "default"
    }
  }
}

######################################################
# Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type          = string
  description   = "Tag describing the owner"
  default       = "That would be me"
}

variable "CountryTag" {
  type          = string
  description   = "Tag describing the Country"
  default       = "fr"
}

variable "CostCenterTag" {
  type          = string
  description   = "Tag describing the Rexel Cost Center which is the same as the one on the EA"
  default       = "tflab"
}

variable "Project" {
  type          = string
  description   = "The name of the project"
  default       = "azure"
}

variable "Environment" {
  type          = string
  description   = "The environment, dev, prod..."
  default       = "lab"
}