output "resource_group_id" {
  value       = module.resource_group.resource_group_id
  description = "The id of the resource group in which the subnet is created in."
}

output "resource_group_name" {
  value       = module.resource_group.resource_group_name
  description = "The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created."
}

output "location" {
  value       = module.resource_group.resource_group_location
  description = "The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
}

output "vnet_id" {
  value       = module.vnet.vnet_id
  description = "The virtual NetworkConfiguration ID."
}

output "vnet_name" {
  value       = module.vnet.vnet_name
  description = "The name of the virtual network. Changing this forces a new resource to be created."
}

output "vnet_address_space" {
  value       = module.vnet.vnet_address_space
  description = "The list of address spaces used by the virtual network."
}

output "subnet_id" {
  value       = module.subnet.default_subnet_id
  description = "The subnet ID."
}

output "subnet_name" {
  value       = module.subnet.default_subnet_name
  description = "The subnet Name."
}

output "subnet_address_prefix" {
  value       = module.subnet.default_subnet_name
  description = "The subnet address prefix."
}

