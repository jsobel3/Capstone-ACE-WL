output "appservice_url" {
  value = azurerm_app_service.NBOS_AZ_AS.default_site_hostname
}

output "appservice_ips" {
  value = azurerm_app_service.NBOS_AZ_AS.outbound_ip_addresses
}

output "sql_server_id" {
  value = azurerm_sql_server.NBOS_AZ_sqlserver.id
}

output "virtual_network_id" {
  value = data.azurerm_virtual_network.NBOS_AZ_VN.id
}