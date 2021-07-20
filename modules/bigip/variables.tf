variable "default_tags" {
  type    = map(any)
  default = {}
}

variable "name_prefix" {
  type        = string
  default     = ""
  description = "Prefix applied to name of resources"
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_pair" {
  type    = string
  default = null
}

variable "instance_type" {
  type    = string
  default = "t2.large"
}
