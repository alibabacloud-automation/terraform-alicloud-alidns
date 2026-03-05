# Local variables for resource configuration
locals {
  # Domain management resources
  this_domain_group_id = var.create_domain_group ? alicloud_alidns_domain_group.domain_group[0].id : var.domain_group_id

  # DNS instance resources
  this_dns_instance_id = var.create_dns_instance ? alicloud_alidns_instance.dns_instance[0].id : var.dns_instance_id

  # GTM instance resources
  this_gtm_instance_id = var.create_gtm_instance ? alicloud_alidns_gtm_instance.gtm_instance[0].id : var.gtm_instance_id
}

# Domain Group
resource "alicloud_alidns_domain_group" "domain_group" {
  count = var.create_domain_group ? 1 : 0

  domain_group_name = var.domain_group_config.domain_group_name
  lang              = var.domain_group_config.lang
}

# Domain
resource "alicloud_alidns_domain" "domain" {
  count = var.create_domain ? 1 : 0

  domain_name       = var.domain_config.domain_name
  group_id          = local.this_domain_group_id
  resource_group_id = var.domain_config.resource_group_id
  lang              = var.domain_config.lang
  remark            = var.domain_config.remark
  tags              = var.common_tags
}

# DNS Instance
resource "alicloud_alidns_instance" "dns_instance" {
  count = var.create_dns_instance ? 1 : 0

  dns_security   = var.dns_instance_config.dns_security
  domain_numbers = var.dns_instance_config.domain_numbers
  version_code   = var.dns_instance_config.version_code
  payment_type   = var.dns_instance_config.payment_type
  period         = var.dns_instance_config.period
  renew_period   = var.dns_instance_config.renew_period
  renewal_status = var.dns_instance_config.renewal_status
}

# Domain Attachment
resource "alicloud_alidns_domain_attachment" "domain_attachment" {
  count = var.create_domain_attachment ? 1 : 0

  instance_id  = local.this_dns_instance_id
  domain_names = var.domain_attachment_config.domain_names
}

# GTM Instance
resource "alicloud_alidns_gtm_instance" "gtm_instance" {
  count = var.create_gtm_instance ? 1 : 0

  instance_name           = var.gtm_instance_config.instance_name
  payment_type            = var.gtm_instance_config.payment_type
  period                  = var.gtm_instance_config.period
  renewal_status          = var.gtm_instance_config.renewal_status
  package_edition         = var.gtm_instance_config.package_edition
  health_check_task_count = var.gtm_instance_config.health_check_task_count
  sms_notification_count  = var.gtm_instance_config.sms_notification_count
  public_cname_mode       = var.gtm_instance_config.public_cname_mode
  ttl                     = var.gtm_instance_config.ttl
  cname_type              = var.gtm_instance_config.cname_type
  resource_group_id       = var.gtm_instance_config.resource_group_id
  alert_group             = var.gtm_instance_config.alert_group
  public_user_domain_name = var.gtm_instance_config.public_user_domain_name
  strategy_mode           = var.gtm_instance_config.strategy_mode
  public_rr               = var.gtm_instance_config.public_rr
  public_zone_name        = var.gtm_instance_config.public_zone_name
  lang                    = var.gtm_instance_config.lang

  dynamic "alert_config" {
    for_each = var.gtm_instance_config.alert_config != null ? [var.gtm_instance_config.alert_config] : []
    content {
      sms_notice      = alert_config.value.sms_notice
      notice_type     = alert_config.value.notice_type
      email_notice    = alert_config.value.email_notice
      dingtalk_notice = alert_config.value.dingtalk_notice
    }
  }
}

# Address Pools
resource "alicloud_alidns_address_pool" "address_pools" {
  for_each = var.address_pools_config

  address_pool_name = each.value.address_pool_name
  instance_id       = local.this_gtm_instance_id
  lba_strategy      = each.value.lba_strategy
  type              = each.value.type

  dynamic "address" {
    for_each = each.value.addresses
    content {
      attribute_info = address.value.attribute_info
      remark         = address.value.remark
      address        = address.value.address
      mode           = address.value.mode
      lba_weight     = address.value.lba_weight
    }
  }
}

# Access Strategies
resource "alicloud_alidns_access_strategy" "access_strategies" {
  for_each = var.access_strategies_config

  strategy_name                   = each.value.strategy_name
  strategy_mode                   = each.value.strategy_mode
  instance_id                     = local.this_gtm_instance_id
  default_addr_pool_type          = each.value.default_addr_pool_type
  default_lba_strategy            = each.value.default_lba_strategy
  default_min_available_addr_num  = each.value.default_min_available_addr_num
  access_mode                     = each.value.access_mode
  default_latency_optimization    = each.value.default_latency_optimization
  default_max_return_addr_num     = each.value.default_max_return_addr_num
  failover_addr_pool_type         = each.value.failover_addr_pool_type
  failover_lba_strategy           = each.value.failover_lba_strategy
  failover_min_available_addr_num = each.value.failover_min_available_addr_num
  failover_latency_optimization   = each.value.failover_latency_optimization
  failover_max_return_addr_num    = each.value.failover_max_return_addr_num
  lang                            = each.value.lang

  dynamic "default_addr_pools" {
    for_each = each.value.default_addr_pools
    content {
      addr_pool_id = default_addr_pools.value.addr_pool_id
      lba_weight   = default_addr_pools.value.lba_weight
    }
  }

  dynamic "failover_addr_pools" {
    for_each = each.value.failover_addr_pools != null ? each.value.failover_addr_pools : []
    content {
      addr_pool_id = failover_addr_pools.value.addr_pool_id
      lba_weight   = failover_addr_pools.value.lba_weight
    }
  }

  dynamic "lines" {
    for_each = each.value.lines != null ? each.value.lines : []
    content {
      line_code = lines.value.line_code
    }
  }
}

# Monitor Configs
resource "alicloud_alidns_monitor_config" "monitor_configs" {
  for_each = var.monitor_configs_config

  addr_pool_id        = each.value.addr_pool_id
  evaluation_count    = each.value.evaluation_count
  interval            = each.value.interval
  timeout             = each.value.timeout
  protocol_type       = each.value.protocol_type
  monitor_extend_info = each.value.monitor_extend_info
  lang                = each.value.lang

  dynamic "isp_city_node" {
    for_each = each.value.isp_city_nodes
    content {
      city_code = isp_city_node.value.city_code
      isp_code  = isp_city_node.value.isp_code
    }
  }
}

# DNS Records
resource "alicloud_alidns_record" "dns_records" {
  for_each = var.dns_records_config

  domain_name    = each.value.domain_name
  rr             = each.value.rr
  type           = each.value.type
  value          = each.value.value
  ttl            = each.value.ttl
  priority       = each.value.priority
  line           = each.value.line
  lang           = each.value.lang
  remark         = each.value.remark
  status         = each.value.status
  user_client_ip = each.value.user_client_ip
}

# Custom Lines
resource "alicloud_alidns_custom_line" "custom_lines" {
  for_each = var.custom_lines_config

  custom_line_name = each.value.custom_line_name
  domain_name      = each.value.domain_name
  lang             = each.value.lang

  dynamic "ip_segment_list" {
    for_each = each.value.ip_segments
    content {
      start_ip = ip_segment_list.value.start_ip
      end_ip   = ip_segment_list.value.end_ip
    }
  }
}