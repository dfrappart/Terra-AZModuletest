##############################################################
#This module allows the creation of a Subnet Gateway
##############################################################

#Variable declaration for Module

variable "SubnetSuffix" {
  type              = string
  description       = "A suffix for the subnet. Changing this forces a new resource to be created."

}


variable "RGName" {
  type              = string
  description       = "The name of the resource group in which to create the subnet. Changing this forces a new resource to be created."

}

variable "VNetName" {
  type              = string
  default           = "The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created."

}

variable "Subnetaddressprefixes" {
  type              = list
  description       = "The address prefixes to use for the subnet."

}

variable "ServicesEP" {
  type              = list
  description       = "The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web."
  default           = null

}

variable "SubnetDelegationName" {
  type              = string
  default           = "A name for this delegation."

}


variable "DelegationServiceName" {
  type              = string
  description       = "The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, and Microsoft.Web/serverFarms."
  default           = null

}

variable "DelegationServiceActionList" {
  type              = list
  description       = "A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action."
  default           = null

}

