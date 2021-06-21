
locals {
  UAIName           = "uai${lower(var.UAISuffix)}"
  DefaultTags = tomap({
    ResourceOwner   = var.ResourceOwnerTag
    Country         = var.CountryTag
    CostCenter      = var.CostCenterTag
    Project         = var.Project
    Environment     = var.EnvironmentTag
    ManagedBy       = "Terraform"
  })


}