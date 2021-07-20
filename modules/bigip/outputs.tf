output "bigip_public_ip" {
  value = aws_instance.f5_ltm.public_ip
}

output "bigip_private_ip" {
  value = aws_instance.f5_ltm.private_ip
}

output "admin_username" {
  value = "admin"
}

output "admin_password" {
  value     = random_password.admin_password.result
  sensitive = true
}
