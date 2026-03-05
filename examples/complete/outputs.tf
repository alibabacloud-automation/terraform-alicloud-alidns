output "domain_group_id" {
  description = "The ID of the created domain group"
  value       = module.alidns.domain_group_id
}

output "domain_id" {
  description = "The ID of the created domain"
  value       = module.alidns.domain_id
}

output "domain_name" {
  description = "The name of the created domain"
  value       = module.alidns.domain_name
}

output "dns_servers" {
  description = "A list of the DNS server names"
  value       = module.alidns.dns_servers
}

output "dns_instance_id" {
  description = "The ID of the created DNS instance"
  value       = module.alidns.dns_instance_id
}

output "gtm_instance_id" {
  description = "The ID of the created GTM instance"
  value       = module.alidns.gtm_instance_id
}

output "address_pool_ids" {
  description = "A map of address pool names to their IDs"
  value       = module.alidns.address_pool_ids
}

output "dns_record_ids" {
  description = "A map of DNS record names to their IDs"
  value       = module.alidns.dns_record_ids
}

output "custom_line_ids" {
  description = "A map of custom line names to their IDs"
  value       = module.alidns.custom_line_ids
}

output "monitor_config_ids" {
  description = "A map of monitor config names to their IDs"
  value       = module.alidns.monitor_config_ids
}

