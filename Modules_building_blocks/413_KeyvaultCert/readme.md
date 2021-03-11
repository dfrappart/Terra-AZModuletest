# Azure Keyvault secret

## Module description

This module deploys an Azure KeyVault self signed certificate .

### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| KeyVaultCertName | string | N/A | The name of the certificate |
| KeyVaultId | string | N/A | The ID of the Key Vault where the Cert should be created. |
| IsKeyExportable |string | true | Is this Certificate Exportable? Changing this forces a new resource to be created. |
| KeySize | string | 2048 | The size of the Key used in the Certificate. Possible values include 2048, 3072, and 4096. Changing this forces a new resource to be created. |
| KeyType | number | RSA | Specifies the Type of Key, such as RSA. Changing this forces a new resource to be created. |
| IsKeyReusable | string | true | Is the key reusable? Changing this forces a new resource to be created. |
| x509Properties_KeyUsage | list | ["cRLSign","dataEncipherment","digitalSignature","keyAgreement","keyCertSign","keyEncipherment"] | A list of uses associated with this Key. Possible values include cRLSign, dataEncipherment, decipherOnly, digitalSignature, encipherOnly, keyAgreement, keyCertSign, keyEncipherment and nonRepudiation and are case-sensitive. Changing this forces a new resource to be created. |
| CertSubject | string | N/A | The Certificate's Subject. Changing this forces a new resource to be created. |
| DNSNames | list | N/A |  A list of alternative DNS names (FQDNs) identified by the Certificate. Changing this forces a new resource to be created. |
| CertValidity | string | 12 |The Certificates Validity Period in Months. Changing this forces a new resource to be created. |



### Module outputs

| Output name | value | Description |
|:------------|:------|:------------|
| Full | `azurerm_key_vault_certificate.TerraCert` | send all the resource information available in the output. In future version, this may be the only output and detailed informtion will probably be queried specifically from the root module |
| Id | `azurerm_key_vault_certificate.TerraCert.id` | The resource id of the keyvault secret |
| Version | `azurerm_key_vault_secret.TerraSecret.version` | The version of the keyvault secret |

  
  

## How to call the module
 

Use as follow:

```bash

module "AKS_AGW_Cert_Wildcard" {

  count                                   = length(var.CertName_Wildcard)
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//413_KeyvaultCert/"

  #Module variable     
  KeyVaultCertName                        = var.CertName_Wildcard[count.index]
  KeyVaultId                              = module.AKS_AGW_KeyVaultAccessPolicyTF.KeyVaultId
  CertSubject                             = var.CertSubject_Wildcard[count.index]
  DNSNames                                = [var.DNSNames_Wildcard[count.index]]


}

```

## Sample display

terraform plan should gives the following output:

```powershell

An execution plan has been generated and is shown below.  
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.AKS_AGW_Cert_Wildcard[0].azurerm_key_vault_certificate.Cert will be created
  + resource "azurerm_key_vault_certificate" "Cert" {
      + certificate_attribute   = (known after apply)
      + certificate_data        = (known after apply)
      + certificate_data_base64 = (known after apply)
      + id                      = (known after apply)
      + key_vault_id            = (sensitive)
      + name                    = "self-signed-aks-teknews-cloud"
      + secret_id               = (known after apply)
      + thumbprint              = (known after apply)
      + version                 = (known after apply)

      + certificate_policy {
          + issuer_parameters {
              + name = "Self"
            }

          + key_properties {
              + exportable = true
              + key_size   = 2048
              + key_type   = "RSA"
              + reuse_key  = true
            }

          + lifetime_action {
              + action {
                  + action_type = "AutoRenew"
                }

              + trigger {
                  + days_before_expiry = 30
                }
            }

          + secret_properties {
              + content_type = "application/x-pkcs12"
            }

          + x509_certificate_properties {
              + extended_key_usage = [
                  + "1.3.6.1.5.5.7.3.1",
                  + "1.3.6.1.5.5.7.3.2",
                ]
              + key_usage          = [
                  + "cRLSign",
                  + "dataEncipherment",
                  + "digitalSignature",
                  + "keyAgreement",
                  + "keyCertSign",
                  + "keyEncipherment",
                ]
              + subject            = "CN=*.aks.teknews.cloud"
              + validity_in_months = 12

              + subject_alternative_names {
                  + dns_names = [
                      + "*.aks.teknews.cloud",
                    ]
                }
            }
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

Output should be similar to this:

```powershell

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

========================Truncated=============================


```

## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/akvcert001.png)

![Illustration 2](./Img/akvcert002.png)


