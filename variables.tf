# Common configuration
variable "common_tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

# Domain Group configuration
variable "create_domain_group" {
  description = "Whether to create a new domain group"
  type        = bool
  default     = true
}

variable "domain_group_id" {
  description = "The ID of an existing domain group. Required when create_domain_group is false"
  type        = string
  default     = null
}

variable "domain_group_config" {
  description = "The parameters of domain group. The attribute 'domain_group_name' is required"
  type = object({
    domain_group_name = string
    lang              = optional(string, null)
  })
  default = {
    domain_group_name = null
  }
}

# Domain configuration
variable "create_domain" {
  description = "Whether to create a new domain"
  type        = bool
  default     = true
}

variable "domain_config" {
  description = "The parameters of domain. The attribute 'domain_name' is required"
  type = object({
    domain_name       = string
    resource_group_id = optional(string, null)
    lang              = optional(string, null)
    remark            = optional(string, null)
  })
  default = {
    domain_name = null
  }
}

# DNS Instance configuration
variable "create_dns_instance" {
  description = "Whether to create a new DNS instance"
  type        = bool
  default     = false
}

variable "dns_instance_id" {
  description = "The ID of an existing DNS instance. Required when create_dns_instance is false"
  type        = string
  default     = null
}

variable "dns_instance_config" {
  description = "The parameters of DNS instance. The attributes 'dns_security', 'domain_numbers' and 'version_code' are required"
  type = object({
    dns_security   = string
    domain_numbers = string
    version_code   = string
    payment_type   = optional(string, "Subscription")
    period         = optional(number, null)
    renew_period   = optional(number, null)
    renewal_status = optional(string, "ManualRenewal")
  })
  default = {
    dns_security   = null
    domain_numbers = null
    version_code   = null
  }
}

# Domain Attachment configuration
variable "create_domain_attachment" {
  description = "Whether to create domain attachment"
  type        = bool
  default     = false
}

variable "domain_attachment_config" {
  description = "The parameters of domain attachment. The attribute 'domain_names' is required"
  type = object({
    domain_names = list(string)
  })
  default = {
    domain_names = []
  }
}

# GTM Instance configuration
variable "create_gtm_instance" {
  description = "Whether to create a new GTM instance"
  type        = bool
  default     = false
}

variable "gtm_instance_id" {
  description = "The ID of an existing GTM instance. Required when create_gtm_instance is false"
  type        = string
  default     = null
}

variable "gtm_instance_config" {
  description = "The parameters of GTM instance. The attributes 'instance_name', 'payment_type', 'package_edition', 'health_check_task_count' and 'sms_notification_count' are required"
  type = object({
    instance_name           = string
    payment_type            = string
    package_edition         = string
    health_check_task_count = number
    sms_notification_count  = number
    period                  = optional(number, null)
    renewal_status          = optional(string, "ManualRenewal")
    public_cname_mode       = optional(string, null)
    ttl                     = optional(number, null)
    cname_type              = optional(string, null)
    resource_group_id       = optional(string, null)
    alert_group             = optional(list(string), null)
    public_user_domain_name = optional(string, null)
    strategy_mode           = optional(string, null)
    public_rr               = optional(string, null)
    public_zone_name        = optional(string, null)
    lang                    = optional(string, null)
    alert_config = optional(object({
      sms_notice      = optional(bool, null)
      notice_type     = optional(string, null)
      email_notice    = optional(bool, null)
      dingtalk_notice = optional(bool, null)
    }), null)
  })
  default = {
    instance_name           = null
    payment_type            = null
    package_edition         = null
    health_check_task_count = null
    sms_notification_count  = null
  }
}

# Address Pools configuration
variable "address_pools_config" {
  description = "Configuration for address pools"
  type = map(object({
    address_pool_name = string
    lba_strategy      = string
    type              = string
    addresses = list(object({
      attribute_info = string
      remark         = optional(string, null)
      address        = string
      mode           = string
      lba_weight     = optional(number, null)
    }))
  }))
  default = {}
}

# Access Strategies configuration
variable "access_strategies_config" {
  description = "Configuration for access strategies"
  type = map(object({
    strategy_name                   = string
    strategy_mode                   = string
    default_addr_pool_type          = string
    default_lba_strategy            = optional(string, null)
    default_min_available_addr_num  = number
    access_mode                     = optional(string, null)
    default_latency_optimization    = optional(string, null)
    default_max_return_addr_num     = optional(number, null)
    failover_addr_pool_type         = optional(string, null)
    failover_lba_strategy           = optional(string, null)
    failover_min_available_addr_num = optional(number, null)
    failover_latency_optimization   = optional(string, null)
    failover_max_return_addr_num    = optional(number, null)
    lang                            = optional(string, null)
    default_addr_pools = list(object({
      addr_pool_id = string
      lba_weight   = optional(number, null)
    }))
    failover_addr_pools = optional(list(object({
      addr_pool_id = string
      lba_weight   = optional(number, null)
    })), null)
    lines = optional(list(object({
      line_code = optional(string, null)
    })), null)
  }))
  default = {}
}

# Monitor Configs configuration
variable "monitor_configs_config" {
  description = "Configuration for monitor configs"
  type = map(object({
    addr_pool_id        = string
    evaluation_count    = string
    interval            = string
    timeout             = string
    protocol_type       = string
    monitor_extend_info = string
    lang                = optional(string, null)
    isp_city_nodes = list(object({
      city_code = string
      isp_code  = string
    }))
  }))
  default = {}
}

# DNS Records configuration
variable "dns_records_config" {
  description = "Configuration for DNS records"
  type = map(object({
    domain_name    = string
    rr             = string
    type           = string
    value          = string
    ttl            = optional(number, null)
    priority       = optional(number, null)
    line           = optional(string, null)
    lang           = optional(string, null)
    remark         = optional(string, null)
    status         = optional(string, null)
    user_client_ip = optional(string, null)
  }))
  default = {}
}

# Custom Lines configuration
variable "custom_lines_config" {
  description = "Configuration for custom lines"
  type = map(object({
    custom_line_name = string
    domain_name      = string
    lang             = optional(string, null)
    ip_segments = list(object({
      start_ip = string
      end_ip   = string
    }))
  }))
  default = {}
}