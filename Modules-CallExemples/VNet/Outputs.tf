#Output for the vNet

#Output for the vNET module

output "VnetName" {

  value = "${module.VNet.Name}"
}

output "VNetId" {

  value = "${module.VNet.Id}"
}

output "VNetAddressspace" {

  value = "${module.VNet.Addressspace}"
}

output "VNetLocation" {

  value = "${module.VNet.Location}"
}