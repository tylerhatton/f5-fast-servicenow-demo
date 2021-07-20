## Service Catalog Configuration

data "servicenow_service_catalog" "service_catalog" {
  title = "Service Catalog"
}

data "servicenow_service_catalog_category" "services" {
  title = "Network Standard Changes"
}

resource "servicenow_service_catalog_item" "f5_simple_http" {
  name              = "F5 HTTP VIP"
  service_catalogs  = data.servicenow_service_catalog.service_catalog.id
  category          = data.servicenow_service_catalog_category.services.id
  short_description = "Request and configure an F5 Loadbalancing virtual IP."
  no_cart           = true
  no_quantity       = true
  no_delivery_time  = true
  no_wishlist       = true
  no_attachment     = true
}

resource "servicenow_service_catalog_variable" "tenant_name" {
  type         = "Single Line Text"
  name         = "tenant_name"
  question     = "Tenant Name"
  order        = "100"
  mandatory    = true
  catalog_item = servicenow_service_catalog_item.f5_simple_http.id
}

resource "servicenow_service_catalog_variable" "application_name" {
  type         = "Single Line Text"
  name         = "application_name"
  question     = "Application Name"
  order        = "200"
  mandatory    = true
  catalog_item = servicenow_service_catalog_item.f5_simple_http.id
}

resource "servicenow_service_catalog_variable" "virtual_address" {
  type         = "Single Line Text"
  name         = "virtual_address"
  question     = "Virtual Address"
  order        = "300"
  mandatory    = true
  catalog_item = servicenow_service_catalog_item.f5_simple_http.id
}

resource "servicenow_service_catalog_variable" "virtual_port" {
  type         = "Single Line Text"
  name         = "virtual_port"
  question     = "Virtual Port"
  order        = "400"
  mandatory    = true
  catalog_item = servicenow_service_catalog_item.f5_simple_http.id
}

resource "servicenow_service_catalog_variable" "server_port" {
  type         = "Single Line Text"
  name         = "server_port"
  question     = "Server Port"
  order        = "500"
  mandatory    = true
  catalog_item = servicenow_service_catalog_item.f5_simple_http.id
}

resource "servicenow_service_catalog_variable" "server_addresses" {
  type                = "List Collector"
  name                = "server_addresses"
  question            = "Server Addresses"
  list_table          = "cmdb_ci_server"
  reference_qualifier = "javascript:'ip_address!=' + ''"
  order               = "600"
  catalog_item        = servicenow_service_catalog_item.f5_simple_http.id
}

## Flow Configurations

resource "servicenow_alias" "f5_credentials" {
  name = "f5_credentials"
  type = "credential"
}

resource "servicenow_basic_auth_credential" "f5_credentials" {
  name             = "f5_credentials"
  username         = var.bigip_username
  password         = var.bigip_password
  credential_alias = servicenow_alias.f5_credentials.id
}

resource "servicenow_alias" "f5_connection" {
  name            = "f5_connection"
  type            = "connection"
  connection_type = "http_connection"
}

resource "servicenow_http_connection" "f5_bigip" {
  name             = "f5_bigip"
  credential       = servicenow_basic_auth_credential.f5_credentials.id
  connection_alias = servicenow_alias.f5_connection.id
  connection_url   = "https://${var.bigip_public_ip}:8443"
}

## Server CMDB Entries

resource "servicenow_server" "nginx" {
  count      = length(var.server_names)
  name       = var.server_names[count.index]
  ip_address = var.server_private_ips[count.index]
}
