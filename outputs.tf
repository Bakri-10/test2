# Output the Load Balancer ID
output "load_balancer_id" {
  description = "ID of the Load Balancer"
  value       = azurerm_lb.internal_lb.id
}

# Output the Backend Address Pool ID
output "backend_address_pool_id" {
  description = "ID of the Backend Address Pool"
  value       = azurerm_lb_backend_address_pool.internal_lb_bepool.id
}

# Output the Load Balancer Frontend IP Configuration
output "frontend_ip_configuration" {
  description = "Frontend IP Configuration of the Load Balancer"
  value       = azurerm_lb.internal_lb.frontend_ip_configuration
}
