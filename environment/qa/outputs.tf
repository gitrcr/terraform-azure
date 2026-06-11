output "admin_username" { value = local.admin_username }
output "admin_password" { value = local.password }

output "nat_public_ip" { value = module.security.nat_public_ip }

output "rdp_vm_info" { value = module.rdp[*].vm_info }
output "ssh_vm_info" { value = module.ssh[*].vm_info }

output "windows_vm_info" { value = module.windows[*].vm_info }
output "linux_vm_info" { value = module.linux[*].vm_info }

output "webpub_info" { value = module.webpub[*].container_info }
