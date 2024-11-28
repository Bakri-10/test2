provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.100.0"
    }
  }
}

# Data sources for subscription and client configuration
data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

# Data source for Network Interfaces
data "azurerm_network_interface" "nic" {
  for_each = toset(var.vm_names)

  name                = "${each.value}-nic-01"
  resource_group_name = var.resource_group_name
}

# Data source for Virtual Network
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group
}

# Data source for Subnet
data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.vnet_resource_group
}

# Load Balancer Resource
resource "azurerm_lb" "internal_lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_name

  frontend_ip_configuration {
    name                          = var.frontend_ip_config_name
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address            = var.private_ip_address
    private_ip_address_allocation = "Static"
  }
}

# Backend Address Pool
resource "azurerm_lb_backend_address_pool" "internal_lb_bepool" {
  loadbalancer_id = azurerm_lb.internal_lb.id
  name            = var.backend_pool_name
}

# Network Interface Backend Address Pool Association
resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_association" {
  for_each = {
    for vm_name in var.vm_names :
    vm_name => {
      nic_id                = data.azurerm_network_interface.nic[vm_name].id
      ip_configuration_name = "${vm_name}-nic1_config"
    }
  }

  network_interface_id    = each.value.nic_id
  ip_configuration_name   = each.value.ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.internal_lb_bepool.id
}

# Load Balancer Probe
resource "azurerm_lb_probe" "tcp_probe" {
  name                = var.probe_name
  loadbalancer_id     = azurerm_lb.internal_lb.id
  protocol            = "Tcp"
  port                = var.probe_port
  interval_in_seconds = var.probe_interval
  number_of_probes    = var.number_of_probes
}

# Load Balancer TCP Rule
resource "azurerm_lb_rule" "tcp_rule" {
  name                           = var.tcp_rule_name
  loadbalancer_id                = azurerm_lb.internal_lb.id
  protocol                       = "Tcp"
  frontend_port                  = var.tcp_frontend_port
  backend_port                   = var.tcp_backend_port
  frontend_ip_configuration_name = var.frontend_ip_config_name
  backend_address_pool_id        = azurerm_lb_backend_address_pool.internal_lb_bepool.id
  idle_timeout_in_minutes        = var.tcp_idle_timeout
  enable_floating_ip             = false
  enable_tcp_reset               = false
  disable_outbound_snat          = false
  probe_id                       = azurerm_lb_probe.tcp_probe.id
}

# Load Balancer HTTPS Rule
resource "azurerm_lb_rule" "https_rule" {
  name                           = var.https_rule_name
  loadbalancer_id                = azurerm_lb.internal_lb.id
  protocol                       = "Tcp"
  frontend_port                  = var.https_frontend_port
  backend_port                   = var.https_backend_port
  frontend_ip_configuration_name = var.frontend_ip_config_name
  backend_address_pool_id        = azurerm_lb_backend_address_pool.internal_lb_bepool.id
  idle_timeout_in_minutes        = var.https_idle_timeout
  enable_floating_ip             = false
  enable_tcp_reset               = false
  disable_outbound_snat          = false
  probe_id                       = azurerm_lb_probe.tcp_probe.id
}
