######################################################################
# This module create a keyvault secret
######################################################################

#Resource Creation

resource "azurerm_key_vault_certificate" "Cert" {

  name                                      = var.KeyVaultCertName

  key_vault_id                              = var.KeyVaultId
  
  certificate_policy {
    issuer_parameters {
      name                                  = "Self"
    }
  

    key_properties {
      exportable                            = var.IsKeyExportable
      key_size                              = var.KeySize
      key_type                              = var.KeyType
      reuse_key                             = var.IsKeyReusable
    }

    lifetime_action {
      action {
        action_type                         = "AutoRenew"
      }

      trigger {
        days_before_expiry                  = 30
      }
    }

    secret_properties {
      content_type                          = "application/x-pkcs12"
    }

    x509_certificate_properties {
      extended_key_usage                    = ["1.3.6.1.5.5.7.3.1","1.3.6.1.5.5.7.3.2"]
      key_usage                             = var.x509Properties_KeyUsage
      subject                               = var.CertSubject

      subject_alternative_names {
        dns_names                           = var.DNSNames
      }
      
      validity_in_months                    = var.CertValidity

    }

  }

}

