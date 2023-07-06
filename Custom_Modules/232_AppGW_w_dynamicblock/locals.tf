locals {
  
   Tags                           = merge(var.DefaultTags, var.extra_tags, {ManagedBy = "Terraform"})


}