# Domain Group outputs
output "domain_group_id" {
  description = "The ID of the domain group"
  value       = var.create_domain_group ? alicloud_alidns_domain_group.domain_group[0].id : null
}

# Domain outputs
output "domain_id" {
  description = "The ID of the domain"
  value       = var.create_domain ? alicloud_alidns_domain.domain[0].domain_id : null
}

output "domain_name" {
  description = "The name of the domain"
  value       = var.create_domain ? alicloud_alidns_domain.domain[0].domain_name : null
}

output "dns_servers" {
  description = "A list of the DNS server names"
  value       = var.create_domain ? alicloud_alidns_domain.domain[0].dns_servers : null
}

output "puny_code" {
  description = "The punycode of the domain name"
  value       = var.create_domain ? alicloud_alidns_domain.domain[0].puny_code : null
}

# DNS Instance outputs
output "dns_instance_id" {
  description = "The ID of the DNS instance"
  value       = var.create_dns_instance ? alicloud_alidns_instance.dns_instance[0].id : null
}

output "dns_instance_version_name" {
  description = "The version name of the DNS instance"
  value       = var.create_dns_instance ? alicloud_alidns_instance.dns_instance[0].version_name : null
}

# Domain Attachment outputs
output "domain_attachment_id" {
  description = "The ID of the domain attachment"
  value       = var.create_domain_attachment ? alicloud_alidns_domain_attachment.domain_attachment[0].id : null
}

# GTM Instance outputs
output "gtm_instance_id" {
  description = "The ID of the GTM instance"
  value       = var.create_gtm_instance ? alicloud_alidns_gtm_instance.gtm_instance[0].id : null
}

# Address Pools outputs
output "address_pool_ids" {
  description = "A map of address pool names to their IDs"
  value       = { for k, v in alicloud_alidns_address_pool.address_pools : k => v.id }
}

# Access Strategies outputs
output "access_strategy_ids" {
  description = "A map of access strategy names to their IDs"
  value       = { for k, v in alicloud_alidns_access_strategy.access_strategies : k => v.id }
}

# Monitor Configs outputs
output "monitor_config_ids" {
  description = "A map of monitor config names to their IDs"
  value       = { for k, v in alicloud_alidns_monitor_config.monitor_configs : k => v.id }
}

# DNS Records outputs
output "dns_record_ids" {
  description = "A map of DNS record names to their IDs"
  value       = { for k, v in alicloud_alidns_record.dns_records : k => v.id }
}

# Custom Lines outputs
output "custom_line_ids" {
  description = "A map of custom line names to their IDs"
  value       = { for k, v in alicloud_alidns_custom_line.custom_lines : k => v.id }
}

