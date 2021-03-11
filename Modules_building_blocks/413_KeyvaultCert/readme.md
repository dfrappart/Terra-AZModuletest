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
  source                                  = "../../Modules/413_KeyvaultCert/"

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


