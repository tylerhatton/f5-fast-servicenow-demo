output "private_ips" {
  value = aws_instance.nginx[*].private_ip
}

output "names" {
  value = aws_instance.nginx[*].tags.Name
}
