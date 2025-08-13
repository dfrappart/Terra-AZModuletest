terraform {
  required_version = ">= 1.12.0"

  required_providers {
    azurerm = {
      version = ">= 4.0.0"
    }

    azapi = {
      source  = "azure/azapi"
      version = ">=2.5"
    }
  }
}
