Alicloud DNS Management Terraform Module

# terraform-alicloud-alidns

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-alidns/blob/main/README-CN.md)

Terraform module which creates and manages Alibaba Cloud DNS resources including domains, DNS instances, GTM instances, DNS records, and advanced DNS features. This module provides comprehensive DNS management capabilities for [Alibaba Cloud DNS Service](https://www.alibabacloud.com/product/dns), enabling users to efficiently manage domain names, configure DNS resolution, set up global traffic management, and implement advanced DNS routing strategies.

## Usage

This module allows you to create and manage various DNS resources on Alibaba Cloud. You can use it to set up basic domain management, configure DNS records, or implement advanced features like Global Traffic Management (GTM) with health checks and failover capabilities.

```terraform
module "alidns" {
  source = "alibabacloud-automation/alidns/alicloud"

  # Domain group and domain configuration
  create_domain_group = true
  domain_group_config = {
    domain_group_name = "my-domain-group"
  }

  create_domain = true
  domain_config = {
    domain_name = "example.com"
    remark      = "Managed by Terraform"
  }

  # DNS records configuration
  dns_records_config = {
    www_record = {
      domain_name = "example.com"
      rr          = "www"
      type        = "A"
      value       = "192.168.1.1"
      ttl         = 600
    }
    mail_record = {
      domain_name = "example.com"
      rr          = "mail"
      type        = "CNAME"
      value       = "mail.example.com"
      ttl         = 600
    }
  }

  # Common tags
  common_tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-alidns/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.95.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.95.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_alidns_access_strategy.access_strategies](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alidns_access_strategy) | resource |
| [alicloud_alidns_address_pool.address_pools](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alidns_address_pool) | resource |
| [alicloud_alidns_custom_line.custom_lines](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alidns_custom_line) | resource |
| [alicloud_alidns_domain.domain](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alidns_domain) | resource |
| [alicloud_alidns_domain_attachment.domain_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alidns_domain_attachment) | resource |
| [alicloud_alidns_domain_group.domain_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alidns_domain_group) | resource |
| [alicloud_alidns_gtm_instance.gtm_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alidns_gtm_instance) | resource |
| [alicloud_alidns_instance.dns_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alidns_instance) | resource |
| [alicloud_alidns_monitor_config.monitor_configs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alidns_monitor_config) | resource |
| [alicloud_alidns_record.dns_records](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alidns_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_strategies_config"></a> [access\_strategies\_config](#input\_access\_strategies\_config) | Configuration for access strategies | <pre>map(object({<br/>    strategy_name                   = string<br/>    strategy_mode                   = string<br/>    default_addr_pool_type          = string<br/>    default_lba_strategy            = optional(string, null)<br/>    default_min_available_addr_num  = number<br/>    access_mode                     = optional(string, null)<br/>    default_latency_optimization    = optional(string, null)<br/>    default_max_return_addr_num     = optional(number, null)<br/>    failover_addr_pool_type         = optional(string, null)<br/>    failover_lba_strategy           = optional(string, null)<br/>    failover_min_available_addr_num = optional(number, null)<br/>    failover_latency_optimization   = optional(string, null)<br/>    failover_max_return_addr_num    = optional(number, null)<br/>    lang                            = optional(string, null)<br/>    default_addr_pools = list(object({<br/>      addr_pool_id = string<br/>      lba_weight   = optional(number, null)<br/>    }))<br/>    failover_addr_pools = optional(list(object({<br/>      addr_pool_id = string<br/>      lba_weight   = optional(number, null)<br/>    })), null)<br/>    lines = optional(list(object({<br/>      line_code = optional(string, null)<br/>    })), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_address_pools_config"></a> [address\_pools\_config](#input\_address\_pools\_config) | Configuration for address pools | <pre>map(object({<br/>    address_pool_name = string<br/>    lba_strategy      = string<br/>    type              = string<br/>    addresses = list(object({<br/>      attribute_info = string<br/>      remark         = optional(string, null)<br/>      address        = string<br/>      mode           = string<br/>      lba_weight     = optional(number, null)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_create_dns_instance"></a> [create\_dns\_instance](#input\_create\_dns\_instance) | Whether to create a new DNS instance | `bool` | `false` | no |
| <a name="input_create_domain"></a> [create\_domain](#input\_create\_domain) | Whether to create a new domain | `bool` | `true` | no |
| <a name="input_create_domain_attachment"></a> [create\_domain\_attachment](#input\_create\_domain\_attachment) | Whether to create domain attachment | `bool` | `false` | no |
| <a name="input_create_domain_group"></a> [create\_domain\_group](#input\_create\_domain\_group) | Whether to create a new domain group | `bool` | `true` | no |
| <a name="input_create_gtm_instance"></a> [create\_gtm\_instance](#input\_create\_gtm\_instance) | Whether to create a new GTM instance | `bool` | `false` | no |
| <a name="input_custom_lines_config"></a> [custom\_lines\_config](#input\_custom\_lines\_config) | Configuration for custom lines | <pre>map(object({<br/>    custom_line_name = string<br/>    domain_name      = string<br/>    lang             = optional(string, null)<br/>    ip_segments = list(object({<br/>      start_ip = string<br/>      end_ip   = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_dns_instance_config"></a> [dns\_instance\_config](#input\_dns\_instance\_config) | The parameters of DNS instance. The attributes 'dns\_security', 'domain\_numbers' and 'version\_code' are required | <pre>object({<br/>    dns_security   = string<br/>    domain_numbers = string<br/>    version_code   = string<br/>    payment_type   = optional(string, "Subscription")<br/>    period         = optional(number, null)<br/>    renew_period   = optional(number, null)<br/>    renewal_status = optional(string, "ManualRenewal")<br/>  })</pre> | <pre>{<br/>  "dns_security": null,<br/>  "domain_numbers": null,<br/>  "version_code": null<br/>}</pre> | no |
| <a name="input_dns_instance_id"></a> [dns\_instance\_id](#input\_dns\_instance\_id) | The ID of an existing DNS instance. Required when create\_dns\_instance is false | `string` | `null` | no |
| <a name="input_dns_records_config"></a> [dns\_records\_config](#input\_dns\_records\_config) | Configuration for DNS records | <pre>map(object({<br/>    domain_name    = string<br/>    rr             = string<br/>    type           = string<br/>    value          = string<br/>    ttl            = optional(number, null)<br/>    priority       = optional(number, null)<br/>    line           = optional(string, null)<br/>    lang           = optional(string, null)<br/>    remark         = optional(string, null)<br/>    status         = optional(string, null)<br/>    user_client_ip = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_domain_attachment_config"></a> [domain\_attachment\_config](#input\_domain\_attachment\_config) | The parameters of domain attachment. The attribute 'domain\_names' is required | <pre>object({<br/>    domain_names = list(string)<br/>  })</pre> | <pre>{<br/>  "domain_names": []<br/>}</pre> | no |
| <a name="input_domain_config"></a> [domain\_config](#input\_domain\_config) | The parameters of domain. The attribute 'domain\_name' is required | <pre>object({<br/>    domain_name       = string<br/>    resource_group_id = optional(string, null)<br/>    lang              = optional(string, null)<br/>    remark            = optional(string, null)<br/>  })</pre> | <pre>{<br/>  "domain_name": null<br/>}</pre> | no |
| <a name="input_domain_group_config"></a> [domain\_group\_config](#input\_domain\_group\_config) | The parameters of domain group. The attribute 'domain\_group\_name' is required | <pre>object({<br/>    domain_group_name = string<br/>    lang              = optional(string, null)<br/>  })</pre> | <pre>{<br/>  "domain_group_name": null<br/>}</pre> | no |
| <a name="input_domain_group_id"></a> [domain\_group\_id](#input\_domain\_group\_id) | The ID of an existing domain group. Required when create\_domain\_group is false | `string` | `null` | no |
| <a name="input_gtm_instance_config"></a> [gtm\_instance\_config](#input\_gtm\_instance\_config) | The parameters of GTM instance. The attributes 'instance\_name', 'payment\_type', 'package\_edition', 'health\_check\_task\_count' and 'sms\_notification\_count' are required | <pre>object({<br/>    instance_name           = string<br/>    payment_type            = string<br/>    package_edition         = string<br/>    health_check_task_count = number<br/>    sms_notification_count  = number<br/>    period                  = optional(number, null)<br/>    renewal_status          = optional(string, "ManualRenewal")<br/>    public_cname_mode       = optional(string, null)<br/>    ttl                     = optional(number, null)<br/>    cname_type              = optional(string, null)<br/>    resource_group_id       = optional(string, null)<br/>    alert_group             = optional(list(string), null)<br/>    public_user_domain_name = optional(string, null)<br/>    strategy_mode           = optional(string, null)<br/>    public_rr               = optional(string, null)<br/>    public_zone_name        = optional(string, null)<br/>    lang                    = optional(string, null)<br/>    alert_config = optional(object({<br/>      sms_notice      = optional(bool, null)<br/>      notice_type     = optional(string, null)<br/>      email_notice    = optional(bool, null)<br/>      dingtalk_notice = optional(bool, null)<br/>    }), null)<br/>  })</pre> | <pre>{<br/>  "health_check_task_count": null,<br/>  "instance_name": null,<br/>  "package_edition": null,<br/>  "payment_type": null,<br/>  "sms_notification_count": null<br/>}</pre> | no |
| <a name="input_gtm_instance_id"></a> [gtm\_instance\_id](#input\_gtm\_instance\_id) | The ID of an existing GTM instance. Required when create\_gtm\_instance is false | `string` | `null` | no |
| <a name="input_monitor_configs_config"></a> [monitor\_configs\_config](#input\_monitor\_configs\_config) | Configuration for monitor configs | <pre>map(object({<br/>    addr_pool_id        = string<br/>    evaluation_count    = string<br/>    interval            = string<br/>    timeout             = string<br/>    protocol_type       = string<br/>    monitor_extend_info = string<br/>    lang                = optional(string, null)<br/>    isp_city_nodes = list(object({<br/>      city_code = string<br/>      isp_code  = string<br/>    }))<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_strategy_ids"></a> [access\_strategy\_ids](#output\_access\_strategy\_ids) | A map of access strategy names to their IDs |
| <a name="output_address_pool_ids"></a> [address\_pool\_ids](#output\_address\_pool\_ids) | A map of address pool names to their IDs |
| <a name="output_custom_line_ids"></a> [custom\_line\_ids](#output\_custom\_line\_ids) | A map of custom line names to their IDs |
| <a name="output_dns_instance_id"></a> [dns\_instance\_id](#output\_dns\_instance\_id) | The ID of the DNS instance |
| <a name="output_dns_instance_version_name"></a> [dns\_instance\_version\_name](#output\_dns\_instance\_version\_name) | The version name of the DNS instance |
| <a name="output_dns_record_ids"></a> [dns\_record\_ids](#output\_dns\_record\_ids) | A map of DNS record names to their IDs |
| <a name="output_dns_servers"></a> [dns\_servers](#output\_dns\_servers) | A list of the DNS server names |
| <a name="output_domain_attachment_id"></a> [domain\_attachment\_id](#output\_domain\_attachment\_id) | The ID of the domain attachment |
| <a name="output_domain_group_id"></a> [domain\_group\_id](#output\_domain\_group\_id) | The ID of the domain group |
| <a name="output_domain_id"></a> [domain\_id](#output\_domain\_id) | The ID of the domain |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | The name of the domain |
| <a name="output_gtm_instance_id"></a> [gtm\_instance\_id](#output\_gtm\_instance\_id) | The ID of the GTM instance |
| <a name="output_monitor_config_ids"></a> [monitor\_config\_ids](#output\_monitor\_config\_ids) | A map of monitor config names to their IDs |
| <a name="output_puny_code"></a> [puny\_code](#output\_puny\_code) | The punycode of the domain name |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)