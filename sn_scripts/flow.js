// Create pool array from service catalog server_addresses variable
var gr = new GlideRecord("cmdb_ci_server")
var pool = []
var serverList = fd_data.trigger.request_item.variables.server_addresses.toString().split(",")

for (var i = 0; i < serverList.length; i++) {
  gr.get(serverList[i])
  pool.push(gr.ip_address.toString())
}

// Create Payload for FAST template from service catalog variable
var fastPayload = {
  "name": "examples/simple_http",
  "parameters": {
    "tenant_name": fd_data.trigger.request_item.variables.tenant_name.toString(),
    "application_name": fd_data.trigger.request_item.variables.application_name.toString(),
    "virtual_port": parseInt(fd_data.trigger.request_item.variables.virtual_port),
    "virtual_address": fd_data.trigger.request_item.variables.virtual_address.toString(),
    "server_port": parseInt(fd_data.trigger.request_item.variables.server_port),
    "server_addresses": pool
  }
}

return fastPayload