output "bigip_public_ip" {
  value = module.bigip.bigip_public_ip
}

output "bigip_private_ip" {
  value = module.bigip.bigip_private_ip
}

output "bigip_username" {
  value = module.bigip.admin_username
}

output "bigip_password" {
  value     = module.bigip.admin_password
  sensitive = true
}
