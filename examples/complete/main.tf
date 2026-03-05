# Configure the Alicloud Provider
provider "alicloud" {
  region = var.region
}

# Random string for unique domain name
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# Get resource groups
data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

# Get CMS alarm contact groups for GTM instance
data "alicloud_cms_alarm_contact_groups" "default" {}

# Example usage of the alidns module
module "alidns" {
  source = "../../"

  # Common tags
  common_tags = var.common_tags

  # Domain group configuration
  create_domain_group = true
  domain_group_config = {
    domain_group_name = var.domain_group_name
    lang              = "en"
  }

  # Domain configuration - disabled for example as domain must be registered first
  create_domain = false
  domain_config = {
    domain_name       = var.domain_name # Using variable instead of generated name
    resource_group_id = data.alicloud_resource_manager_resource_groups.default.groups[0].id
    lang              = "en"
    remark            = "Created by Terraform"
  }

  # DNS instance configuration
  create_dns_instance = var.create_dns_instance
  dns_instance_config = {
    dns_security   = "basic"
    domain_numbers = "3"
    version_code   = "version_personal"
    payment_type   = "Subscription"
    period         = 1
    renewal_status = "ManualRenewal"
  }

  # Domain attachment configuration - only when domain exists in account
  create_domain_attachment = false # Setting to false as attached domain must exist in account first
  domain_attachment_config = {
    domain_names = [var.domain_name]
  }

  # GTM instance configuration
  create_gtm_instance = var.create_gtm_instance
  gtm_instance_config = {
    instance_name           = var.gtm_instance_name
    payment_type            = "Subscription"
    period                  = 1
    renewal_status          = "ManualRenewal"
    package_edition         = "standard"
    health_check_task_count = 100
    sms_notification_count  = 1000
    public_cname_mode       = "SYSTEM_ASSIGN"
    ttl                     = 60
    cname_type              = "PUBLIC"
    resource_group_id       = data.alicloud_resource_manager_resource_groups.default.groups[0].id
    alert_group             = length(data.alicloud_cms_alarm_contact_groups.default.groups) > 0 ? [data.alicloud_cms_alarm_contact_groups.default.groups[0].alarm_contact_group_name] : []
    public_user_domain_name = "test-domain-${random_string.suffix.result}.com"
    lang                    = "en"
    alert_config = {
      sms_notice      = true
      notice_type     = "ADDR_ALERT"
      email_notice    = true
      dingtalk_notice = true
    }
  }

  # Address pools configuration
  address_pools_config = var.create_gtm_instance ? {
    pool1 = {
      address_pool_name = "tfgtmpool1"
      lba_strategy      = "RATIO"
      type              = "IPV4"
      addresses = [
        {
          attribute_info = jsonencode({
            lineCodeRectifyType = "RECTIFIED"
            lineCodes           = ["os_namerica_us"]
          })
          remark     = "Primary address"
          address    = "1.1.1.1"
          mode       = "SMART"
          lba_weight = 1
        }
      ]
    }
    pool2 = {
      address_pool_name = "tfgtmpool2"
      lba_strategy      = "RATIO"
      type              = "IPV4"
      addresses = [
        {
          attribute_info = jsonencode({
            lineCodeRectifyType = "RECTIFIED"
            lineCodes           = ["os_namerica_us"]
          })
          remark     = "Secondary address"
          address    = "8.8.8.8"
          mode       = "SMART"
          lba_weight = 1
        }
      ]
    }
  } : {}

  # DNS records configuration - disabled as domain must exist first
  dns_records_config = {} # Empty map as records can only be added to existing domains

  # Custom lines configuration - disabled as domain must exist first
  custom_lines_config = {} # Empty map as custom lines can only be added to existing domains

  # Access strategies configuration
  access_strategies_config = var.create_gtm_instance ? {
    strategy1 = {
      strategy_name                  = "tfgtmstrategy1"
      strategy_mode                  = "GEO"
      default_addr_pool_type         = "IPV4"
      default_lba_strategy           = "RATIO"
      default_min_available_addr_num = 1
      access_mode                    = "AUTO"
      default_addr_pools = [
        {
          addr_pool_id = module.alidns.address_pool_ids["pool1"]
          lba_weight   = 1
        }
      ]
      lines = [
        {
          line_code = "default"
        }
      ]
    }
  } : {}

  # Monitor configs configuration - temporarily disabled due to API issues
  monitor_configs_config = {}
}