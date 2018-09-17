#Output

output "RGName" {

  value = "${module.ResourceGroup.Name}"
}

output "RGLocation" {

  value = "${module.ResourceGroup.Location}"
}

output "RGId" {

  value = "${module.ResourceGroup.Id}"
}