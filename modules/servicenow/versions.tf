terraform {
  required_version = ">= 0.15.1"

  required_providers {
    servicenow = {
      version = ">= 0.9.4"
      source  = "tylerhatton/servicenow"
    }
  }
}
