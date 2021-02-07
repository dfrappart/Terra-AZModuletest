######################################################################
# This module create a keyvault secret
######################################################################

#Resource Creation

locals {
  StartingDate                            = timeadd(timestamp(), "1m")
  ExpirationDate                          = timeadd(timestamp(), "720h")
}

resource "random_password" "TerraRandomPWD" {



    length                                = var.stringlenght
    special                               = var.stringspecial
    upper                                 = var.stringupper
    number                                = var.stringnumber

}

resource "azurerm_key_vault_secret" "TerraSecret" {

  lifecycle {
    ignore_changes                        = [
      
      expiration_date,
      not_before_date

    ]
  }

  name                                    = "kvs-${lower(var.KeyVaultSecretSuffix)}"
  value                                   = var.PasswordValue != "notspecified" ? var.PasswordValue : random_password.TerraRandomPWD.result
  key_vault_id                            = var.KeyVaultId
  not_before_date                         = var.StartingDate != "notspecified" ? var.StartingDate : local.StartingDate
  expiration_date                         = var.ExpirationDate != "notspecified" ? var.ExpirationDate : local.ExpirationDate


    tags = {
        ResourceOwner                     = var.ResourceOwnerTag
        Country                           = var.CountryTag
        CostCenter                        = var.CostCenterTag   
        environment                       = var.Environment
        managedBy                         = "Terraform"
        UsedBy                            = var.SecretUsedBy
    }
}

