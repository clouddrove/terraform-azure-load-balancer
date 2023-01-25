#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "application" {
  type        = string
  default     = ""
  description = "Application (e.g. `cd` or `clouddrove`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "managedby" {
  type        = string
  default     = "anmol@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'."
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. `name`,`application`."
}
variable "repository" {
  type        = string
  default     = ""
  description = "Terraform current module repo"
}

## Common Variables

variable "ip_count" {
  type        = number
  default     = 0
  description = "Number of Public IP Addresses to create."
}

variable "enabled" {
  type        = bool
  default     = false
  description = "Flag to control the module creation."
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the resource group in which to create the virtual network."
}

variable "location" {
  type        = string
  default     = ""
  description = "Location where resource should be created."
}

variable "create" {
  type        = string
  default     = "60m"
  description = "Used when creating the Resource Group."
}

variable "update" {
  type        = string
  default     = "60m"
  description = "Used when updating the Resource Group."
}

variable "read" {
  type        = string
  default     = "5m"
  description = "Used when retrieving the Resource Group."
}

variable "delete" {
  type        = string
  default     = "60m"
  description = "Used when deleting the Resource Group."
}


## Pubilc IP

variable "public_ip_enabled" {
  type        = bool
  default     = false
  description = "Whether public IP is enabled."
}

variable "sku" {
  type        = string
  default     = "Basic"
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
}

variable "allocation_method" {
  type        = string
  default     = ""
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic."
}

variable "ip_version" {
  type        = string
  default     = ""
  description = "The IP Version to use, IPv6 or IPv4."
}

variable "idle_timeout_in_minutes" {
  type        = number
  default     = 10
  description = "Specifies the timeout for the TCP idle connection. The value can be set between 4 and 60 minutes."
}

variable "domain_name_label" {
  type        = string
  default     = null
  description = "Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
}

variable "reverse_fqdn" {
  type        = string
  default     = ""
  description = "A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN."
}

variable "public_ip_prefix_id" {
  type        = string
  default     = null
  description = "If specified then public IP address allocated will be provided from the public IP prefix resource."
}

variable "zones" {
  type        = list(any)
  default     = null
  description = "A collection containing the availability zone to allocate the Public IP in."
}

variable "ddos_protection_mode" {
  type        = string
  description = "(Optional) The DDoS protection mode of the public IP. Possible values are `Disabled`, `Enabled`, and `VirtualNetworkInherited`. Defaults to `VirtualNetworkInherited`."
  default     = "VirtualNetworkInherited"
}


## Load Balancer

variable "edge_zone" {
  type        = string
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Public IP and Load Balancer should exist. Changing this forces new resources to be created."
  default     = null
}

variable "frontend_name" {
  description = "(Required) Specifies the name of the frontend ip configuration."
  type        = string
  default     = "myip"
}

variable "frontend_private_ip_address" {
  description = "(Optional) Private ip address to assign to frontend. Use it with type = private"
  type        = string
  default     = ""
}

variable "frontend_private_ip_address_allocation" {
  description = "(Optional) Frontend ip allocation type (Static or Dynamic)"
  type        = string
  default     = "Dynamic"
}

variable "frontend_subnet_id" {
  description = "(Optional) Frontend subnet id to use when in private mode"
  type        = string
  default     = ""
}

variable "lb_port" {
  description = "Protocols to be used for lb rules. Format as [frontend_port, protocol, backend_port]"
  type        = map(any)
  default     = {}
}

variable "lb_probe" {
  description = "(Optional) Protocols to be used for lb health probes. Format as [protocol, port, request_path]"
  type        = map(any)
  default     = {}
}

variable "lb_probe_interval" {
  description = "Interval in seconds the load balancer health probe rule does a check"
  type        = number
  default     = 5
}

variable "lb_probe_unhealthy_threshold" {
  description = "Number of times the load balancer health probe has an unsuccessful attempt before considering the endpoint unhealthy."
  type        = number
  default     = 2
}

variable "lb_sku" {
  description = "(Optional) The SKU of the Azure Load Balancer. Accepted values are Basic and Standard."
  type        = string
  default     = "Basic"
}

variable "remote_port" {
  description = "Protocols to be used for remote vm access. [protocol, backend_port].  Frontend port will be automatically generated starting at 50000 and in the output."
  type        = map(any)
  default     = {}
}

variable "backendpoolname" {
  description = "(Required) Specifies the name of the Backend Address Pool. Changing this forces a new resource to be created."
  type        = string
  default     = "test-backendpool"
}

variable "nat_protocol" {
  description = "(Required) The protocol of Load Balancer's NAT rule."
  type        = string
  default     = "Tcp"
}