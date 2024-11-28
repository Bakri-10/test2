# Azure region where resources will be created
variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

# List of VM names
variable "vm_names" {
  description = "List of VM names"
  type        = list(string)
}

# Resource Group name
variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

# Virtual Network name
variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
}

# Resource group of the Virtual Network
variable "vnet_resource_group" {
  description = "Resource group of the Virtual Network"
  type        = string
}

# Subnet name
variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

# Private IP address for the Load Balancer frontend
variable "private_ip_address" {
  description = "Private IP address for the Load Balancer frontend"
  type        = string
}

# SKU name for the Load Balancer
variable "sku_name" {
  description = "SKU name for the Load Balancer"
  type        = string
  default     = "Standard"
}

# Load Balancer name
variable "lb_name" {
  description = "Load Balancer name"
  type        = string
}

# Frontend IP configuration name
variable "frontend_ip_config_name" {
  description = "Frontend IP configuration name"
  type        = string
}

# Backend pool name
variable "backend_pool_name" {
  description = "Backend pool name"
  type        = string
}

# Probe name
variable "probe_name" {
  description = "Probe name"
  type        = string
}

# Probe port
variable "probe_port" {
  description = "Probe port"
  type        = number
  default     = 20000
}

# Probe interval in seconds
variable "probe_interval" {
  description = "Probe interval in seconds"
  type        = number
  default     = 5
}

# Number of probes
variable "number_of_probes" {
  description = "Number of probes"
  type        = number
  default     = 5
}

# TCP rule name
variable "tcp_rule_name" {
  description = "TCP rule name"
  type        = string
}

# TCP frontend port
variable "tcp_frontend_port" {
  description = "TCP frontend port"
  type        = number
  default     = 20000
}

# TCP backend port
variable "tcp_backend_port" {
  description = "TCP backend port"
  type        = number
  default     = 20000
}

# TCP idle timeout in minutes
variable "tcp_idle_timeout" {
  description = "TCP idle timeout in minutes"
  type        = number
  default     = 5
}

# HTTPS rule name
variable "https_rule_name" {
  description = "HTTPS rule name"
  type        = string
}

# HTTPS frontend port
variable "https_frontend_port" {
  description = "HTTPS frontend port"
  type        = number
  default     = 443
}

# HTTPS backend port
variable "https_backend_port" {
  description = "HTTPS backend port"
  type        = number
  default     = 443
}

# HTTPS idle timeout in minutes
variable "https_idle_timeout" {
  description = "HTTPS idle timeout in minutes"
  type        = number
  default     = 4
}
