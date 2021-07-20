variable "server_private_ips" {
  type = list(string)
}

variable "server_names" {
  type = list(string)
}

variable "bigip_public_ip" {
  type = string
}

variable "bigip_username" {
  type = string
}

variable "bigip_password" {
  type = string
}
