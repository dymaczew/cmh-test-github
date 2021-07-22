#output "public_ssh_key" {
#  value = local.public_ssh_key
#}

#output "private_ssh_key" {
#  value = local.private_ssh_key
#}

output "uuid" {
  value = vsphere_virtual_machine.vm.uuid
}

output "ip_address" {
  value = vsphere_virtual_machine.vm.default_ip_address
}
