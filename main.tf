## Managed By : CloudDrove
## Copyright @ CloudDrove. All Right Reserved.

#Module      : labels
#Description : Terraform module to create consistent naming for multiple names.
module "labels" {
  source      = "clouddrove/labels/azure"
  version     = "1.0.0"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  repository  = var.repository
}



#Resource    : PUBLIC IP
#Description : Terraform resource to create a public IP for network interface.
resource "azurerm_public_ip" "default" {
  count                   = var.enabled && var.public_ip_enabled ? var.ip_count : 0
  name                    = format("%s-public-ip-%s", module.labels.id, count.index + 1)
  resource_group_name     = var.resource_group_name
  location                = var.location
  sku                     = var.sku
  allocation_method       = var.sku == "Standard" ? "Static" : var.allocation_method
  ip_version              = var.ip_version
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  domain_name_label       = var.domain_name_label
  reverse_fqdn            = var.reverse_fqdn
  public_ip_prefix_id     = var.public_ip_prefix_id
  zones                   = var.zones
  ddos_protection_mode    = var.ddos_protection_mode
  tags                    = module.labels.tags

  timeouts {
    create = var.create
    update = var.update
    read   = var.read
    delete = var.delete
  }
}


#Resource    : Load Balancer
#Description : Terraform resource to create a Load balancer.
resource "azurerm_lb" "load-balancer" {
  location            = var.location
  name                = format("%s-load-balancer", module.labels.id)
  resource_group_name = var.resource_group_name
  edge_zone           = var.edge_zone
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                          = var.frontend_name
    private_ip_address            = var.frontend_private_ip_address
    private_ip_address_allocation = var.frontend_private_ip_address_allocation
    private_ip_address_version    = var.frontend_private_ip_address_version
    public_ip_address_id          = try(azurerm_public_ip.default[0].id, "")
    subnet_id                     = var.frontend_subnet_id
  }

  timeouts {
    create = var.create
    update = var.update
    read   = var.read
    delete = var.delete
  }
}

## Backend Address Pool for Load Balancer
resource "azurerm_lb_backend_address_pool" "load-balancer" {
  loadbalancer_id = azurerm_lb.load-balancer.id
  name            = var.backendpoolname
}

## NAT rule for Load Balancer
resource "azurerm_lb_nat_rule" "load-balancer" {
  count = length(var.remote_port)

  backend_port                   = element(var.remote_port[element(keys(var.remote_port), count.index)], 1)
  frontend_ip_configuration_name = var.frontend_name
  loadbalancer_id                = azurerm_lb.load-balancer.id
  name                           = "VM-lb-nat-rule${count.index}"
  protocol                       = var.nat_protocol
  resource_group_name            = var.resource_group_name
  frontend_port                  = "5000${count.index + 1}"
}

## Health Probe for the Load Balancer
resource "azurerm_lb_probe" "load-balancer" {
  count = length(var.lb_probe)

  loadbalancer_id     = azurerm_lb.load-balancer.id
  name                = element(keys(var.lb_probe), count.index)
  port                = element(var.lb_probe[element(keys(var.lb_probe), count.index)], 1)
  interval_in_seconds = var.lb_probe_interval
  number_of_probes    = var.lb_probe_unhealthy_threshold
  protocol            = element(var.lb_probe[element(keys(var.lb_probe), count.index)], 0)
  request_path        = element(var.lb_probe[element(keys(var.lb_probe), count.index)], 2)
}

## Load Balancer Rule
resource "azurerm_lb_rule" "load-balancer" {
  count = length(var.lb_port)

  backend_port                   = element(var.lb_port[element(keys(var.lb_port), count.index)], 2)
  frontend_ip_configuration_name = var.frontend_name
  frontend_port                  = element(var.lb_port[element(keys(var.lb_port), count.index)], 0)
  loadbalancer_id                = azurerm_lb.load-balancer.id
  name                           = element(keys(var.lb_port), count.index)
  protocol                       = element(var.lb_port[element(keys(var.lb_port), count.index)], 1)
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.load-balancer.id]
  enable_floating_ip             = false
  idle_timeout_in_minutes        = 5
  probe_id                       = element(azurerm_lb_probe.load-balancer[*].id, count.index)
}

resource "azurerm_network_interface_backend_address_pool_association" "default" {
  count                   = var.is_enable_backend_pool ? length(var.network_interaface_id_association) : 0
  network_interface_id    = var.network_interaface_id_association[count.index]
  ip_configuration_name   = var.ip_configuration_name_association[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.load-balancer.id
}