# VNet Module

## Mpdule description

This module allows to deploy a virtual network with an application gateway.
The virtual network is configured to have a /24 CIDR ip range and is divided in 4 subnets:

- A dedicated subnet for Azure Application Gateway
- A dedicated subnet for Azure Bastion
- A subnet for VMs or virtual machine scale set which are planed to be exposed on the Internet through the Application Gateway
- A subnet for non exposed VMs or virtual machine scale set

A default filtering is configured through Network Security Groups on the subnet level:

- Application Gateway subnet **Ingress** rules

| Rule Priority | Rule name | Port | Protocol | Source | Destination | Action | Comment |
|:-------------:|:---------:|:----:|:--------:|:------:|:-----------:|:------:|:-------:|
| 2010 | Default_AppGWSubnet_GatewayManager | 65200-65535 | Any | GatewayManager | Any | Allow | Required rules for Application Gateway Control Plane |
| 65000 | AllowVnetInBound | Any | Any | VirtualNetwork | VirtualNetwork | Allow | Default Virtual Network rule - Allow all inside VNet |
| 65500 | AllowAzureLoadBalancerInBound | Any | Any | AzureLoadBalancer | Any | Allow | Default Virtual Network rule - Allow Azure Load Balancer traffic |
| 65501 | DenyAllInBound | Any | Any | Any | Any | Deny | Default Virtual Network rule - Deny All Inbound |

- Application Gateway subnet **Egress** rules

| Rule Priority | Rule name | Port | Protocol | Source | Destination | Action | Comment |
|:-------------:|:---------:|:----:|:--------:|:------:|:-----------:|:------:|:-------:|
| 65000 | AllowVnetOutBound | Any | Any | VirtualNetwork | VirtualNetwork | Allow | Default Virtual Network rule - Allow all inside VNet |
| 65500 | AllowInternetOutBound | Any | Any | Any | Any | Allow | Default Virtual Network rule - Allow Egress Internet |
| 65501 | DenyAllOutBound | Any | Any | Any | Any | Deny | Default Virtual Network rule - Deny All Outbound |

- Azure Bastion Subnet **Ingress** rules

| Rule Priority | Rule name | Port | Protocol | Source | Destination | Action | Comment |
|:-------------:|:---------:|:----:|:--------:|:------:|:-----------:|:------:|:-------:|
| 2010 |  |  |  |  |  |  |  |
| 65000 | AllowVnetInBound | Any | Any | VirtualNetwork | VirtualNetwork | Allow | Default Virtual Network rule - Allow all inside VNet |
| 65500 | AllowAzureLoadBalancerInBound | Any | Any | AzureLoadBalancer | Any | Allow | Default Virtual Network rule - Allow Azure Load Balancer traffic |
| 65501 | DenyAllInBound | Any | Any | Any | Any | Deny | Default Virtual Network rule - Deny All Inbound |

- Azure Bastion Subnet **Egress** rules

| Rule Priority | Rule name | Port | Protocol | Source | Destination | Action | Comment |
|:-------------:|:---------:|:----:|:--------:|:------:|:-----------:|:------:|:-------:|
| 65000 | AllowVnetOutBound | Any | Any | VirtualNetwork | VirtualNetwork | Allow | Default Virtual Network rule - Allow all inside VNet |
| 65500 | AllowInternetOutBound | Any | Any | Any | Any | Allow | Default Virtual Network rule - Allow Egress Internet |
| 65501 | DenyAllOutBound | Any | Any | Any | Any | Deny | Default Virtual Network rule - Deny All Outbound |

- Front End Subnet **Ingress** rules

| Rule Priority | Rule name | Port | Protocol | Source | Destination | Action | Comment |
|:-------------:|:---------:|:----:|:--------:|:------:|:-----------:|:------:|:-------:|
| 2010 |  |  |  |  |  |  |  |
| 65000 | AllowVnetInBound | Any | Any | VirtualNetwork | VirtualNetwork | Allow | Default Virtual Network rule - Allow all inside VNet |
| 65500 | AllowAzureLoadBalancerInBound | Any | Any | AzureLoadBalancer | Any | Allow | Default Virtual Network rule - Allow Azure Load Balancer traffic |
| 65501 | DenyAllInBound | Any | Any | Any | Any | Deny | Default Virtual Network rule - Deny All Inbound |

- Front End Subnet **Egress** rules

| Rule Priority | Rule name | Port | Protocol | Source | Destination | Action | Comment |
|:-------------:|:---------:|:----:|:--------:|:------:|:-----------:|:------:|:-------:|
| 65000 | AllowVnetOutBound | Any | Any | VirtualNetwork | VirtualNetwork | Allow | Default Virtual Network rule - Allow all inside VNet |
| 65500 | AllowInternetOutBound | Any | Any | Any | Any | Allow | Default Virtual Network rule - Allow Egress Internet |
| 65501 | DenyAllOutBound | Any | Any | Any | Any | Deny | Default Virtual Network rule - Deny All Outbound |

- Backend Subnet **Ingress** rules

| Rule Priority | Rule name | Port | Protocol | Source | Destination | Action | Comment |
|:-------------:|:---------:|:----:|:--------:|:------:|:-----------:|:------:|:-------:|
| 2010 |  |  |  |  |  |  |  |
| 65000 | AllowVnetInBound | Any | Any | VirtualNetwork | VirtualNetwork | Allow | Default Virtual Network rule - Allow all inside VNet |
| 65500 | AllowAzureLoadBalancerInBound | Any | Any | AzureLoadBalancer | Any | Allow | Default Virtual Network rule - Allow Azure Load Balancer traffic |
| 65501 | DenyAllInBound | Any | Any | Any | Any | Deny | Default Virtual Network rule - Deny All Inbound |

- Backend Subnet **Egress** rules

| Rule Priority | Rule name | Port | Protocol | Source | Destination | Action | Comment |
|:-------------:|:---------:|:----:|:--------:|:------:|:-----------:|:------:|:-------:|
| 65000 | AllowVnetOutBound | Any | Any | VirtualNetwork | VirtualNetwork | Allow | Default Virtual Network rule - Allow all inside VNet |
| 65500 | AllowInternetOutBound | Any | Any | Any | Any | Allow | Default Virtual Network rule - Allow Egress Internet |
| 65501 | DenyAllOutBound | Any | Any | Any | Any | Deny | Default Virtual Network rule - Deny All Outbound |

### Module inputs  
  


| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
|   |   |   |   |

### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|

## How to call the module

Use as follow:

```bash



```

## Sample display

terraform plan should gives the following output:

```powershell

PS C:\Users\User1\Documents\IaC\Azure\Terra-AZModuletest\Tests\RG> terraform plan

An execution plan has been generated and is shown below.  
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.AKSSpokeVNet.azurerm_bastion_host.SpokeBastion will be created
  + resource "azurerm_bastion_host" "SpokeBastion" {
      + dns_name            = (known after apply)
      + id                  = (known after apply)
      + location            = "westeurope"
      + name                = "bstlab"
      + resource_group_name = "rsg-lab-1"
      + tags                = {
          + "CostCenter"    = "labaks"
          + "Country"       = "fr"
          + "Environment"   = "lab"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "aksmeetup"
          + "ResourceOwner" = "That would be me"    
        }

      + ip_configuration {
          + name                 = "bst-ipconfiglab"
          + public_ip_address_id = (known after apply)
          + subnet_id            = (known after apply)
        }
    }

  # module.AKSSpokeVNet.azurerm_monitor_diagnostic_setting.AZBastionDiag will be created
  + resource "azurerm_monitor_diagnostic_setting" "AZBastionDiag" {
      + id                         = (known after apply)
      + log_analytics_workspace_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.OperationalInsights/workspaces/law-dffr-lab-subsetup-log49816259"
      + name                       = "bstlabdiag"
      + storage_account_id         = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.Storage/storageAccounts/stdffrlab49816259log"
      + target_resource_id         = (known after apply)

      + log {
          + category = "BastionAuditLogs"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
    }

  # module.AKSSpokeVNet.azurerm_monitor_diagnostic_setting.AZBastionPIPDiag will be created
  + resource "azurerm_monitor_diagnostic_setting" "AZBastionPIPDiag" {
      + id                         = (known after apply)
      + log_analytics_workspace_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.OperationalInsights/workspaces/law-dffr-lab-subsetup-log49816259"
      + name                       = "bst-pubipdiag"
      + storage_account_id         = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.Storage/storageAccounts/stdffrlab49816259log"
      + target_resource_id         = (known after apply)

      + log {
          + category = "DDoSMitigationFlowLogs"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
      + log {
          + category = "DDoSMitigationReports"
          + enabled  = true   

          + retention_policy {
              + days    = 365 
              + enabled = true
            }
        }
      + log {
          + category = "DDoSProtectionNotifications"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }

      + metric {
          + category = "AllMetrics"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
    }

  # module.AKSSpokeVNet.azurerm_monitor_diagnostic_setting.AppGWSubnetNSGDiag will be created
  + resource "azurerm_monitor_diagnostic_setting" "AppGWSubnetNSGDiag" {
      + id                         = (known after apply)
      + log_analytics_workspace_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.OperationalInsights/workspaces/law-dffr-lab-subsetup-log49816259"
      + name                       = "nsg-agwlabdiag"
      + storage_account_id         = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.Storage/storageAccounts/stdffrlab49816259log"
      + target_resource_id         = (known after apply)

      + log {
          + category = "NetworkSecurityGroupEvent"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
      + log {
          + category = "NetworkSecurityGroupRuleCounter"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
    }

  # module.AKSSpokeVNet.azurerm_monitor_diagnostic_setting.AzureBastionNSGDiag will be created
  + resource "azurerm_monitor_diagnostic_setting" "AzureBastionNSGDiag" {
      + id                         = (known after apply)
      + log_analytics_workspace_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.OperationalInsights/workspaces/law-dffr-lab-subsetup-log49816259"
      + name                       = "nsg-bstlabdiag"
      + storage_account_id         = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.Storage/storageAccounts/stdffrlab49816259log"
      + target_resource_id         = (known after apply)

      + log {
          + category = "NetworkSecurityGroupEvent"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
      + log {
          + category = "NetworkSecurityGroupRuleCounter"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
    }

  # module.AKSSpokeVNet.azurerm_monitor_diagnostic_setting.BESubnetNSGDiag will be created
  + resource "azurerm_monitor_diagnostic_setting" "BESubnetNSGDiag" {
      + id                         = (known after apply)
      + log_analytics_workspace_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.OperationalInsights/workspaces/law-dffr-lab-subsetup-log49816259"
      + name                       = "nsg-subBElabdiag"
      + storage_account_id         = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.Storage/storageAccounts/stdffrlab49816259log"
      + target_resource_id         = (known after apply)

      + log {
          + category = "NetworkSecurityGroupEvent"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
      + log {
          + category = "NetworkSecurityGroupRuleCounter"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
    }

  # module.AKSSpokeVNet.azurerm_monitor_diagnostic_setting.FESubnetNSGDiag will be created
  + resource "azurerm_monitor_diagnostic_setting" "FESubnetNSGDiag" {
      + id                         = (known after apply)
      + log_analytics_workspace_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.OperationalInsights/workspaces/law-dffr-lab-subsetup-log49816259"
      + name                       = "nsg-subFElabdiag"
      + storage_account_id         = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.Storage/storageAccounts/stdffrlab49816259log"
      + target_resource_id         = (known after apply)

      + log {
          + category = "NetworkSecurityGroupEvent"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
      + log {
          + category = "NetworkSecurityGroupRuleCounter"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
    }

  # module.AKSSpokeVNet.azurerm_monitor_diagnostic_setting.SpokeVNetDiag will be created
  + resource "azurerm_monitor_diagnostic_setting" "SpokeVNetDiag" {
      + id                         = (known after apply)
      + log_analytics_workspace_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.OperationalInsights/workspaces/law-dffr-lab-subsetup-log49816259"
      + name                       = "vnetlabdiag"
      + storage_account_id         = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.Storage/storageAccounts/stdffrlab49816259log"
      + target_resource_id         = (known after apply)

      + log {
          + category = "VMProtectionAlerts"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }

      + metric {
          + category = "AllMetrics"
          + enabled  = true

          + retention_policy {
              + days    = 365
              + enabled = true
            }
        }
    }

  # module.AKSSpokeVNet.azurerm_network_security_group.AppGWSubnetNSG will be created
  + resource "azurerm_network_security_group" "AppGWSubnetNSG" {
      + id                  = (known after apply)
      + location            = "westeurope"
      + name                = "nsg-agwlab"
      + resource_group_name = "rsg-lab-1"
      + security_rule       = (known after apply)
      + tags                = {
          + "CostCenter"    = "labaks"
          + "Country"       = "fr"
          + "Environment"   = "lab"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "aksmeetup"
          + "ResourceOwner" = "That would be me"
        }
    }

  # module.AKSSpokeVNet.azurerm_network_security_group.AzureBastionNSG will be created
  + resource "azurerm_network_security_group" "AzureBastionNSG" {
      + id                  = (known after apply)
      + location            = "westeurope"
      + name                = "nsg-bstlab"
      + resource_group_name = "rsg-lab-1"
      + security_rule       = (known after apply)
      + tags                = {
          + "CostCenter"    = "labaks"
          + "Country"       = "fr"
          + "Environment"   = "lab"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "aksmeetup"
          + "ResourceOwner" = "That would be me"
        }
    }

  # module.AKSSpokeVNet.azurerm_network_security_group.BESubnetNSG will be created
  + resource "azurerm_network_security_group" "BESubnetNSG" {
      + id                  = (known after apply)
      + location            = "westeurope"
      + name                = "nsg-subBElab"
      + resource_group_name = "rsg-lab-1"
      + security_rule       = (known after apply)
      + tags                = {
          + "CostCenter"    = "labaks"
          + "Country"       = "fr"
          + "Environment"   = "lab"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "aksmeetup"
          + "ResourceOwner" = "That would be me"
        }
    }

  # module.AKSSpokeVNet.azurerm_network_security_group.FESubnetNSG will be created
  + resource "azurerm_network_security_group" "FESubnetNSG" {
      + id                  = (known after apply)
      + location            = "westeurope"
      + name                = "nsg-subFElab"
      + resource_group_name = "rsg-lab-1"
      + security_rule       = (known after apply)
      + tags                = {
          + "CostCenter"    = "labaks"
          + "Country"       = "fr"
          + "Environment"   = "lab"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "aksmeetup"
          + "ResourceOwner" = "That would be me"
        }
    }

  # module.AKSSpokeVNet.azurerm_network_security_rule.Default_AllowAzureCloudHTTPSOut will be created
  + resource "azurerm_network_security_rule" "Default_AllowAzureCloudHTTPSOut" {
      + access                      = "Allow"
      + destination_address_prefix  = "AzureCloud"
      + destination_port_range      = "443"
      + direction                   = "Outbound"
      + id                          = (known after apply)
      + name                        = "Default_AllowAzureCloudHTTPSOut"
      + network_security_group_name = "nsg-bstlab"
      + priority                    = 2020
      + protocol                    = "Tcp"
      + resource_group_name         = "rsg-lab-1"
      + source_address_prefix       = "*"
      + source_port_range           = "*"
    }

  # module.AKSSpokeVNet.azurerm_network_security_rule.Default_AppGWSubnet_GatewayManager will be created
  + resource "azurerm_network_security_rule" "Default_AppGWSubnet_GatewayManager" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_ranges     = [
          + "65200-65535",
        ]
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "Default_AppGWSubnet_GatewayManager"
      + network_security_group_name = "nsg-agwlab"
      + priority                    = 2010
      + protocol                    = "*"
      + resource_group_name         = "rsg-lab-1"
      + source_address_prefix       = "GatewayManager"
      + source_port_range           = "*"
    }

  # module.AKSSpokeVNet.azurerm_network_security_rule.Default_BESubnet_AllowLB will be created
  + resource "azurerm_network_security_rule" "Default_BESubnet_AllowLB" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "*"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "Default_BESubnet_AllowLB"
      + network_security_group_name = "nsg-subBElab"
      + priority                    = 2020
      + protocol                    = "*"
      + resource_group_name         = "rsg-lab-1"
      + source_address_prefix       = "AzureLoadBalancer"
      + source_port_range           = "*"
    }

  # module.AKSSpokeVNet.azurerm_network_security_rule.Default_BESubnet_AllowRDPSSHFromBastion will be created
  + resource "azurerm_network_security_rule" "Default_BESubnet_AllowRDPSSHFromBastion" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_ranges     = [
          + "22",
          + "3389",
        ]
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "Default_BESubnet_AllowRDPSSHFromBastion"
      + network_security_group_name = "nsg-subBElab"
      + priority                    = 2010
      + protocol                    = "Tcp"
      + resource_group_name         = "rsg-lab-1"
      + source_address_prefixes     = [
          + "172.20.0.0/26",
        ]
      + source_port_range           = "*"
    }

  # module.AKSSpokeVNet.azurerm_network_security_rule.Default_BastionSubnet_AllowGatewayManager will be created
  + resource "azurerm_network_security_rule" "Default_BastionSubnet_AllowGatewayManager" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_ranges     = [
          + "443",
          + "4443",
        ]
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "Default_BastionSubnet_AllowGatewayManager"
      + network_security_group_name = "nsg-bstlab"
      + priority                    = 2020
      + protocol                    = "Tcp"
      + resource_group_name         = "rsg-lab-1"
      + source_address_prefix       = "GatewayManager"
      + source_port_range           = "*"
    }

  # module.AKSSpokeVNet.azurerm_network_security_rule.Default_BastionSubnet_AllowHTTPSBastionIn will be created
  + resource "azurerm_network_security_rule" "Default_BastionSubnet_AllowHTTPSBastionIn" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "443"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "Default_BastionSubnet_AllowHTTPSBastionIn"
      + network_security_group_name = "nsg-bstlab"
      + priority                    = 2010
      + protocol                    = "Tcp"
      + resource_group_name         = "rsg-lab-1"
      + source_address_prefix       = "Internet"
      + source_port_range           = "*"
    }

  # module.AKSSpokeVNet.azurerm_network_security_rule.Default_BastionSubnet_AllowRemoteBastionOut will be created
  + resource "azurerm_network_security_rule" "Default_BastionSubnet_AllowRemoteBastionOut" {
      + access                      = "Allow"
      + destination_address_prefix  = "VirtualNetwork"
      + destination_port_ranges     = [
          + "22",
          + "3389",
        ]
      + direction                   = "Outbound"
      + id                          = (known after apply)
      + name                        = "Default_BastionSubnet_AllowRemoteBastionOut"
      + network_security_group_name = "nsg-bstlab"
      + priority                    = 2010
      + protocol                    = "Tcp"
      + resource_group_name         = "rsg-lab-1"
      + source_address_prefix       = "*"
      + source_port_range           = "*"
    }

  # module.AKSSpokeVNet.azurerm_network_security_rule.Default_BastionSubnet_DenyInternetOut will be created
  + resource "azurerm_network_security_rule" "Default_BastionSubnet_DenyInternetOut" {
      + access                      = "Deny"
      + destination_address_prefix  = "Internet"
      + destination_port_range      = "*"
      + direction                   = "Outbound"
      + id                          = (known after apply)
      + name                        = "Default_BastionSubnet_DenyInternetOut"
      + network_security_group_name = "nsg-bstlab"
      + priority                    = 2520
      + protocol                    = "*"
      + resource_group_name         = "rsg-lab-1"
      + source_address_prefix       = "*"
      + source_port_range           = "*"
    }

  # module.AKSSpokeVNet.azurerm_network_security_rule.Default_BastionSubnet_DenyVNetOut will be created
  + resource "azurerm_network_security_rule" "Default_BastionSubnet_DenyVNetOut" {
      + access                      = "Deny"
      + destination_address_prefix  = "VirtualNetwork"
      + destination_port_range      = "*"
      + direction                   = "Outbound"
      + id                          = (known after apply)
      + name                        = "Default_BastionSubnet_DenyVNetOut"
      + network_security_group_name = "nsg-bstlab"
      + priority                    = 2510
      + protocol                    = "Tcp"
      + resource_group_name         = "rsg-lab-1"
      + source_address_prefix       = "*"
      + source_port_range           = "*"
    }

  # module.AKSSpokeVNet.azurerm_network_security_rule.Default_FESubnet_AllowLB will be created
  + resource "azurerm_network_security_rule" "Default_FESubnet_AllowLB" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "*"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "Default_FESubnet_AllowLB"
      + network_security_group_name = "nsg-subFElab"
      + priority                    = 2020
      + protocol                    = "*"
      + resource_group_name         = "rsg-lab-1"
      + source_address_prefix       = "AzureLoadBalancer"
      + source_port_range           = "*"
    }

  # module.AKSSpokeVNet.azurerm_network_security_rule.Default_FESubnet_AllowRDPSSHFromBastion will be created
  + resource "azurerm_network_security_rule" "Default_FESubnet_AllowRDPSSHFromBastion" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_ranges     = [
          + "22",
          + "3389",
        ]
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "Default_FESubnet_AllowRDPSSHFromBastion"
      + network_security_group_name = "nsg-subFElab"
      + priority                    = 2010
      + protocol                    = "Tcp"
      + resource_group_name         = "rsg-lab-1"
      + source_address_prefixes     = [
          + "172.20.0.0/26",
        ]
      + source_port_range           = "*"
    }

  # module.AKSSpokeVNet.azurerm_network_security_rule.Default_FESubnet_DenyVNetSSHRDPIn will be created
  + resource "azurerm_network_security_rule" "Default_FESubnet_DenyVNetSSHRDPIn" {
      + access                      = "Deny"
      + destination_address_prefix  = "*"
      + destination_port_ranges     = [
          + "22",
          + "3389",
        ]
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "Default_FESubnet_DenyVNetSSHRDPIn"
      + network_security_group_name = "nsg-subFElab"
      + priority                    = 2510
      + protocol                    = "Tcp"
      + resource_group_name         = "rsg-lab-1"
      + source_address_prefix       = "VirtualNetwork"
      + source_port_range           = "*"
    }

  # module.AKSSpokeVNet.azurerm_network_watcher_flow_log.AppGWSubnetNSGFlowLog will be created
  + resource "azurerm_network_watcher_flow_log" "AppGWSubnetNSGFlowLog" {
      + enabled                   = true
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + network_watcher_name      = "NetworkWatcher_westeurope"
      + resource_group_name       = "NetworkWatcherRG"
      + storage_account_id        = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.Storage/storageAccounts/stdffrlab49816259log"
      + version                   = 2

      + retention_policy {
          + days    = 365
          + enabled = true
        }

      + traffic_analytics {
          + enabled               = true
          + interval_in_minutes   = 10
          + workspace_id          = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
          + workspace_region      = "westeurope"
          + workspace_resource_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.OperationalInsights/workspaces/law-dffr-lab-subsetup-log49816259"
        }
    }

  # module.AKSSpokeVNet.azurerm_network_watcher_flow_log.AzureBastionNSGFlowLog will be created
  + resource "azurerm_network_watcher_flow_log" "AzureBastionNSGFlowLog" {
      + enabled                   = true
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + network_watcher_name      = "NetworkWatcher_westeurope"
      + resource_group_name       = "NetworkWatcherRG"
      + storage_account_id        = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.Storage/storageAccounts/stdffrlab49816259log"
      + version                   = 2

      + retention_policy {
          + days    = 365
          + enabled = true
        }

      + traffic_analytics {
          + enabled               = true
          + interval_in_minutes   = 10
          + workspace_id          = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
          + workspace_region      = "westeurope"
          + workspace_resource_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.OperationalInsights/workspaces/law-dffr-lab-subsetup-log49816259"
        }
    }

  # module.AKSSpokeVNet.azurerm_network_watcher_flow_log.BESubnetNSGFlowLog will be created
  + resource "azurerm_network_watcher_flow_log" "BESubnetNSGFlowLog" {
      + enabled                   = true
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + network_watcher_name      = "NetworkWatcher_westeurope"
      + resource_group_name       = "NetworkWatcherRG"
      + storage_account_id        = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.Storage/storageAccounts/stdffrlab49816259log"
      + version                   = 2

      + retention_policy {
          + days    = 365
          + enabled = true
        }

      + traffic_analytics {
          + enabled               = true
          + interval_in_minutes   = 10
          + workspace_id          = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
          + workspace_region      = "westeurope"
          + workspace_resource_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.OperationalInsights/workspaces/law-dffr-lab-subsetup-log49816259"
        }
    }

  # module.AKSSpokeVNet.azurerm_network_watcher_flow_log.FESubnetNSGFlowLog will be created
  + resource "azurerm_network_watcher_flow_log" "FESubnetNSGFlowLog" {
      + enabled                   = true
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + network_watcher_name      = "NetworkWatcher_westeurope"
      + resource_group_name       = "NetworkWatcherRG"
      + storage_account_id        = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.Storage/storageAccounts/stdffrlab49816259log"
      + version                   = 2

      + retention_policy {
          + days    = 365
          + enabled = true
        }

      + traffic_analytics {
          + enabled               = true
          + interval_in_minutes   = 10
          + workspace_id          = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
          + workspace_region      = "westeurope"
          + workspace_resource_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsg-dffr-lab-subsetup-log/providers/Microsoft.OperationalInsights/workspaces/law-dffr-lab-subsetup-log49816259"
        }
    }

  # module.AKSSpokeVNet.azurerm_public_ip.BastionPublicIP will be created
  + resource "azurerm_public_ip" "BastionPublicIP" {
      + allocation_method       = "Static"
      + domain_name_label       = "bst-pubiplab"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "westeurope"
      + name                    = "bst-pubip"
      + resource_group_name     = "rsg-lab-1"
      + sku                     = "standard"
      + tags                    = {
          + "CostCenter"    = "labaks"
          + "Country"       = "fr"
          + "Environment"   = "lab"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "aksmeetup"
          + "ResourceOwner" = "That would be me"
        }
    }

  # module.AKSSpokeVNet.azurerm_subnet.AppGWSubnet will be created
  + resource "azurerm_subnet" "AppGWSubnet" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "172.20.0.64/26",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "subAGWlab"
      + resource_group_name                            = "rsg-lab-1"
      + virtual_network_name                           = "vnetlab"
    }

  # module.AKSSpokeVNet.azurerm_subnet.AzBastionmanagedSubnet will be created
  + resource "azurerm_subnet" "AzBastionmanagedSubnet" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "172.20.0.0/26",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "AzureBastionSubnet"
      + resource_group_name                            = "rsg-lab-1"
      + virtual_network_name                           = "vnetlab"
    }

  # module.AKSSpokeVNet.azurerm_subnet.BESubnet will be created
  + resource "azurerm_subnet" "BESubnet" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "172.20.0.192/26",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "subBElab"
      + resource_group_name                            = "rsg-lab-1"
      + service_endpoints                              = [
          + "Microsoft.Sql",
          + "Microsoft.ContainerRegistry",
        ]
      + virtual_network_name                           = "vnetlab"
    }

  # module.AKSSpokeVNet.azurerm_subnet.FESubnet will be created
  + resource "azurerm_subnet" "FESubnet" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "172.20.0.128/26",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "subFElab"
      + resource_group_name                            = "rsg-lab-1"
      + service_endpoints                              = [
          + "Microsoft.Sql",
          + "Microsoft.ContainerRegistry",
        ]
      + virtual_network_name                           = "vnetlab"
    }

  # module.AKSSpokeVNet.azurerm_subnet_network_security_group_association.AppGWSubnetNSGAssociation will be created
  + resource "azurerm_subnet_network_security_group_association" "AppGWSubnetNSGAssociation" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.AKSSpokeVNet.azurerm_subnet_network_security_group_association.BESubnetNSGAssociation will be created
  + resource "azurerm_subnet_network_security_group_association" "BESubnetNSGAssociation" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.AKSSpokeVNet.azurerm_subnet_network_security_group_association.BastionSubnetNSGAssociation will be created
  + resource "azurerm_subnet_network_security_group_association" "BastionSubnetNSGAssociation" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.AKSSpokeVNet.azurerm_subnet_network_security_group_association.FESubnetNSGAssociation will be created
  + resource "azurerm_subnet_network_security_group_association" "FESubnetNSGAssociation" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.AKSSpokeVNet.azurerm_virtual_network.SpokeVNet will be created
  + resource "azurerm_virtual_network" "SpokeVNet" {
      + address_space         = [
          + "172.20.0.0/24",
        ]
      + guid                  = (known after apply)
      + id                    = (known after apply)
      + location              = "westeurope"
      + name                  = "vnetlab"
      + resource_group_name   = "rsg-lab-1"
      + subnet                = (known after apply)
      + tags                  = {
          + "CostCenter"    = "labaks"
          + "Country"       = "fr"
          + "Environment"   = "lab"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "aksmeetup"
          + "ResourceOwner" = "That would be me"
        }
      + vm_protection_enabled = false
    }

  # module.ResourceGroup.azurerm_resource_group.TerraRG will be created
  + resource "azurerm_resource_group" "TerraRG" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "rsg-lab-1"
      + tags     = {
          + "CostCenter"    = "labaks"
          + "Country"       = "fr"
          + "Environment"   = "lab"
          + "ManagedBy"     = "Terraform"
          + "Project"       = "aksmeetup"
          + "ResourceOwner" = "That would be me"
        }
    }

Plan: 39 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + RGId       = (sensitive value)
  + RGLocation = "westeurope"
  + RGName     = "rsg-lab-1"

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

output should be similar to this:

```powershell

Apply complete! Resources: 39 added, 0 changed, 0 destroyed.

Outputs:

AGWSubnetFullOutput = <sensitive>
AGWSubnetNSGFullOutput = <sensitive>
AppGWSubnetNSGDiagFullOutput = <sensitive>
AppGWSubnetNSGFlowLogFullOutput = <sensitive>
AzureBastionNSGDiagFullOutput = <sensitive>
AzureBastionNSGFlowLogFullOutput = <sensitive>
AzureBastionNSGFullOutput = <sensitive>
AzureBastionSubnetFullOutput = <sensitive>
BESubnetFullOutput = <sensitive>
BESubnetNSGDiagFullOutput = <sensitive>
BESubnetNSGFlowLogFullOutput = <sensitive>
BESubnetNSGFullOutput = <sensitive>
Default_AllowAzureCloudHTTPSOutOutFullOutput = <sensitive>
Default_AppGWSubnet_GatewayManagerFullOutput = <sensitive>
Default_BESubnet_AllowLBFullOutput = <sensitive>
Default_BESubnet_AllowRDPSSHFromBastionFullOutput = <sensitive>
Default_BastionSubnet_AllowGatewayManagerFullOutput = <sensitive>
Default_BastionSubnet_AllowHTTPSBastionInFullOutput = <sensitive>
Default_BastionSubnet_AllowRemoteBastionOutFullOutput = <sensitive>
Default_BastionSubnet_DenyInternetOutFullOutput = <sensitive>
Default_BastionSubnet_DenyVNetOutFullOutput = <sensitive>
Default_FESubnet_AllowLBFullOutput = <sensitive>
Default_FESubnet_AllowRDPSSHFromBastionFullOutput = <sensitive>
Default_FESubnet_DenyVNetSSHRDPInFullOutput = <sensitive>
FESubnetFullOutput = <sensitive>
FESubnetNSGDiagFullOutput = <sensitive>
FESubnetNSGFlowLogFullOutput = <sensitive>
FESubnetNSGFullOutput = <sensitive>
LAWFullOutput = <sensitive>
RGId = <sensitive>
RGLocation = "westeurope"
RGName = "rsg-lab-1"
STALogsFullOutput = <sensitive>
SpokeBastionFullOutput = <sensitive>
VNetFullOutput = <sensitive>

```

## Sample deployment

After deployment, something simlilar is visible in the portal:


## List of Resources deployed by this module

| Resource type | Usage | naming pattern | Comment |
|:-------------:|:-----:|:--------------:|:-------:|
|   |   |   |   |



