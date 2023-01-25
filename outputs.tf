output "azurerm_lb_backend_address_pool_id" {
  description = "the id for the azurerm_lb_backend_address_pool resource"
  value       = azurerm_lb_backend_address_pool.load-balancer.id
}

output "azurerm_lb_frontend_ip_configuration" {
  description = "the frontend_ip_configuration for the azurerm_lb resource"
  value       = azurerm_lb.load-balancer.frontend_ip_configuration
}

output "azurerm_lb_id" {
  description = "the id for the azurerm_lb resource"
  value       = azurerm_lb.load-balancer.id
}

output "azurerm_lb_nat_rule_ids" {
  description = "the ids for the azurerm_lb_nat_rule resources"
  value       = azurerm_lb_nat_rule.load-balancer[*].id
}

output "azurerm_lb_probe_ids" {
  description = "the ids for the azurerm_lb_probe resources"
  value       = azurerm_lb_probe.load-balancer[*].id
}

output "azurerm_public_ip_address" {
  description = "the ip address for the azurerm_lb_public_ip resource"
  value       = azurerm_public_ip.default[*].ip_address
}

output "azurerm_public_ip_id" {
  description = "the id for the azurerm_lb_public_ip resource"
  value       = azurerm_public_ip.default[*].id
}
