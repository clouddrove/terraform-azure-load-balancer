provider "azurerm" {
  features {}
}

module "resource_group" {
  source  = "clouddrove/resource-group/azure"
  version = "1.0.0"

  name        = "app-lb"
  environment = "test"
  label_order = ["name", "environment"]
  location    = "Canada Central"
}

module "vnet" {
  source  = "clouddrove/vnet/azure"
  version = "1.0.0"

  name                = "app"
  environment         = "test"
  label_order         = ["name", "environment"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = "10.0.0.0/16"
  enable_ddos_pp      = false
}

module "subnet" {
  source  = "clouddrove/subnet/azure"
  version = "1.0.1"

  name                 = "app"
  environment          = "test"
  label_order          = ["name", "environment"]
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = join("", module.vnet.vnet_name)

  #subnet
  default_name_subnet = true
  subnet_names        = ["subnet1"]
  subnet_prefixes     = ["10.0.1.0/24"]

  # route_table
  enable_route_table = false
  routes = [
    {
      name           = "rt-test"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}


module "load-balancer" {
  source = "../"

  #   Labels
  name        = "app"
  environment = "test"
  label_order = ["environment", "name"]

  #   Common
  enabled             = true
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  # Load Balancer
  frontend_name                          = "mypublicIP"
  frontend_private_ip_address_allocation = "Static"
  frontend_private_ip_address            = "10.0.1.6"
  lb_sku                                 = "Standard"

  #   Public IP
  ip_count          = 1
  allocation_method = "Static"
  sku               = "Standard"
  nat_protocol      = "Tcp"
  public_ip_enabled = true
  ip_version        = "IPv4"

  # Backend Pool
  is_enable_backend_pool              = false
  network_interaface_id_association   = ""
  ip_configuration_name_association   = ""
  backend_address_pool_id_association = ""

  remote_port = {
    ssh   = ["Tcp", "22"]
    https = ["Tcp", "80"]
  }

  lb_port = {
    http  = ["80", "Tcp", "80"]
    https = ["443", "Tcp", "443"]
  }

  lb_probe = {
    http  = ["Tcp", "80", ""]
    http2 = ["Http", "1443", "/"]
  }

  depends_on = [module.resource_group]
}