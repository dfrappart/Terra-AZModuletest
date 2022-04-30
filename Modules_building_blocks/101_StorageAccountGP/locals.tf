
locals {
    blobid = split("/",azurerm_storage_account.STOA.id[6])
}