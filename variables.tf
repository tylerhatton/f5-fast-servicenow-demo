variable "name_prefix" {
  type    = string
  default = "sndemo"
}

variable "owner" {
  type        = string
  default     = null
  description = "The name of the owner that will be tagged to the provisioned resources."
}

variable "servicenow_url" {
  type = string
}

variable "servicenow_username" {
  type = string
}

variable "servicenow_password" {
  type = string
}
