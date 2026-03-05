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