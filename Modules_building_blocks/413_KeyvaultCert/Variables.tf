######################################################################
# This module create a keyvault resource
######################################################################

#Variable declaration for Module

variable "KeyVaultCertName" {
  type                = string
  description         = "The name of the certificate"

}

variable "KeyVaultId" {
  type                = string
  description         = "The target Keyvault"
}

variable "IsKeyExportable" {
  type                = string
  default             = true
  description         = "Is this Certificate Exportable? Changing this forces a new resource to be created."
}

variable "KeySize" {
  type                = string
  default             = 2048
  description         = "The size of the Key used in the Certificate. Possible values include 2048, 3072, and 4096. Changing this forces a new resource to be created."
}

variable "KeyType" {
  type                = string
  default             = "RSA"
  description         = "Specifies the Type of Key, such as RSA. Changing this forces a new resource to be created."
}

variable "IsKeyReusable" {
  type                = string
  default             = true
  description         = "Is the key reusable? Changing this forces a new resource to be created."
}


variable "x509Properties_KeyUsage" {
  type          = list
  description   = "A list of uses associated with this Key. Possible values include cRLSign, dataEncipherment, decipherOnly, digitalSignature, encipherOnly, keyAgreement, keyCertSign, keyEncipherment and nonRepudiation and are case-sensitive. Changing this forces a new resource to be created."
  default       = [
    "cRLSign",
    "dataEncipherment",
    "digitalSignature",
    "keyAgreement",
    "keyCertSign",
    "keyEncipherment",
  ]
}

variable "CertSubject" {
  type          = string
  description   = "The Certificate's Subject. Changing this forces a new resource to be created."

}

variable "DNSNames" {
  type          = list
  description   = " A list of alternative DNS names (FQDNs) identified by the Certificate. Changing this forces a new resource to be created."

}

variable "CertValidity" {
  type          = string
  description   = "The Certificates Validity Period in Months. Changing this forces a new resource to be created." 
  default       = 12
}
