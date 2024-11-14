

locals {



  DefaultTags = tomap({
    ResourceOwner = var.ResourceOwnerTag
    Country       = var.CountryTag
    CostCenter    = var.CostCenterTag
    Project       = var.Project
    Environment   = var.Environment
    ManagedBy     = "Terraform"
  })

}